//
//  GBCTableViewController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCHomeTblViewController.h"
#import "GBCButton.h"
#import "GBCAccessToken.h"
#import "UIImageView+WebCache.h"
#import "GBCStatus.h"
#import "GBCUser.h"
#import "Reachability.h"
#import "FMDatabase.h"
#import "GBCStatusCellFrame.h"
#import "GBCTableViewCell.h"

@interface GBCHomeTblViewController ()
@property(nonatomic,strong)AFHTTPRequestOperationManager *mgr;
@property(nonatomic,strong)NSMutableArray *statusArr;
@property(nonatomic,weak) UIRefreshControl *refresh;
@property(nonatomic,strong)FMDatabase *db;
@property(nonatomic,weak) UILabel *lbl;


@end

@implementation GBCHomeTblViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusArr=[NSMutableArray array];
    
    [self setTabButton];
    [self creatDB];
    [self loadStatus];
    [self freshTableView];
    
}
- (void)setTabButton
{
    //左边的button
    UIButton *leftBtn=[[UIButton alloc] init];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    
    UIImage *bgImg=leftBtn.currentBackgroundImage;
    //记住,如果把某个控件放到另外一个控件的左边，右边，中间，等位置，只需要设置宽度和高度，不用管x,y坐标
    leftBtn.frame=CGRectMake(0, 0, bgImg.size.width, bgImg.size.height);
    
    //右边的button
    UIButton *rightBtn=[[UIButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop"] forState:(UIControlStateNormal)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:(UIControlStateHighlighted)];
    rightBtn.frame=CGRectMake(0, 0, bgImg.size.width, bgImg.size.height);
    
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=left;
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
    
    GBCButton *titleBtn=[[GBCButton alloc] init];
    
    GBCAccessToken *token=[GBCAccessToken read];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"access_token"]=token.access_token;
    dict[@"uid"]=token.uid;
    self.mgr=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    __block NSString *title;//如果要修改block中的值，就加两个下划线
    [self.mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:dict success:^(AFHTTPRequestOperation * operation, NSDictionary* responseData) {
        
        title=responseData[@"screen_name"];
        
        [titleBtn setTitle:title forState:(UIControlStateNormal)];
        [defaults setObject:title forKey:@"screen_name"];
        [defaults synchronize];//写不写都可以保存，写这个是立刻保存，不写可能待会儿保存
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        title=[defaults objectForKey:@"screen_name"];
        [titleBtn setTitle:title forState:(UIControlStateNormal)];
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:(UIControlStateNormal)];
    
    [titleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.navigationItem.titleView=titleBtn;
    titleBtn.imageView.contentMode=UIViewContentModeCenter;
    
}

- (void)creatDB
{
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"status.sqlite"];
    NSLog(@"%@",path);
    self.db=[FMDatabase databaseWithPath:path];//sqlite3
    [self.db open];
    NSString *table=@"create table if not exists status(sid integer  primary key,created_at text, s_text text,source text,reposts_count integer,comments_count integer,attitudes_count integer,screen_name text, profile_image_url text,pic_ids text)";
    [self.db executeUpdate:table];//executeUpdate：可以增删改创建表操作
}


//刷新--往下拉一下，就会出现转的一圈原点，实际并不是刷新功能
- (void)freshTableView
{
    UIRefreshControl *fresh=[[UIRefreshControl alloc] init];
    self.refresh=fresh;
    [fresh addTarget:self action:@selector(loadStatus) forControlEvents:(UIControlEventValueChanged)];
    
    [self.tableView addSubview:fresh];
    
}
- (void)loadStatus
{
    
    Reachability *reach=[Reachability reachabilityForInternetConnection];
    if (![reach isReachable]) {
        NSLog(@"no");
        //从沙盒读取数据
        [self readStatus];
        [self.tableView reloadData];
        [self.refresh endRefreshing];
        return;
    }
    GBCAccessToken *token=[GBCAccessToken read];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"access_token"]=token.access_token;

    long long sid=[self getMaxId];
    NSString *sidStr=[NSString stringWithFormat:@"%lld",sid];
    dict[@"since_id"]=sidStr;
    
    
    [self.mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:dict success:^(AFHTTPRequestOperation *operation, NSDictionary *dict) {
        
        [self.refresh endRefreshing];
        NSArray *arr=dict[@"statuses"];//nil 或count=0;
        //if (arr==nil||arr.count==0) return ;
        [self showNewWbCount:arr.count];
        [self saveStatus:arr];
        [self readStatus];
        [self.tableView reloadData];
        
    }
        failure:^(AFHTTPRequestOperation * operation, NSError *error)
    {
        [self.refresh endRefreshing];
    }];
}
- (UILabel *)lbl
{
    if (_lbl==nil) {
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
        [self.view addSubview:lbl];
        _lbl=lbl;
    }
    return _lbl;
}
/**
 *  显示最新微博的个数
 */
- (void)showNewWbCount:(NSInteger)cnt
{
    if (cnt) {
        [self.lbl setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]]];
        self.lbl.textAlignment=NSTextAlignmentCenter;
        self.lbl.text=[NSString stringWithFormat:@"%zd条新微博",cnt];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __block CGPoint center=self.lbl.center;
            [UIView animateWithDuration:1 animations:^{
                center=CGPointMake(center.x, -35);
                self.lbl.center=center;
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.lbl removeFromSuperview];//移除提示
            });
            
        });
    }
    
}


//获取数据库中当前最大的微博主键
- (long long)getMaxId
{
    if (self.db==nil) {
        return 0;//sname,gender,age select age,sname,gender  表示age是第一列
    }
    FMResultSet *set=[self.db executeQuery:@"select sid from status order by sid desc LIMIT 0, 1"];//也可以select max(sid) from STATUS
    return (set.next)?[set longLongIntForColumnIndex:0]:0;
}

/**
 *  保存的过程：先从数据库中选择出来最大的微博主键，然后，判断数组中的主键是否小于最大主键，如果是，说明该条微博在数据库中保存过了，否则需要保存
 */
- (void)saveStatus:(NSArray *)arr//这个是coredata还是用fmdb吧
{
    long long maxSid=[self getMaxId];
    NSLog(@"%lld",maxSid);
    for (NSDictionary *dict in arr) {
        long long sid=[dict[@"id"] longLongValue];
        if (sid>maxSid) {
            
            NSArray *arr=dict[@"pic_urls"];
            NSString *str=[NSString stringWithFormat:@"%@",arr];
            
            NSLog(@"%@",str);
            
            str=[str stringByReplacingOccurrencesOfString:@"(" withString:@"["];
            str=[str stringByReplacingOccurrencesOfString:@")" withString:@"]"];
            str=[str stringByReplacingOccurrencesOfString:@";" withString:@""];
            str=[str stringByReplacingOccurrencesOfString:@"=" withString:@":"];
            NSLog(@"%@",str);
            
            NSString *insert=[NSString stringWithFormat:@"insert into status values('%lld','%@','%@','%@','%d','%d','%d','%@','%@','%@')",
                sid,
                dict[@"created_at"],
                dict[@"text"],
                dict[@"source"],
                [dict[@"reposts_count"] intValue],
                [dict[@"comments_count"] intValue],
                [dict[@"attitudes_count"] intValue],
                dict[@"user"][@"screen_name"],
                dict[@"user"][@"profile_image_url"],
                str//pic_urls
                //dict[@"pic_urls"]
                ];
            [self.db executeUpdate:insert];
        }
    }
    
}
/**
 *  读取数据库中所有的数据
 */
- (void)readStatus//这个是coredata还是用fmdb吧
{
    if (self.statusArr.count>0) {
        [self.statusArr removeAllObjects];
    }
    
    NSString *select=@"select * from status order by sid desc";//sid s_text pro
    FMResultSet *set=[self.db executeQuery:select];//executeQuery只是用来执行查询操作
    while (set.next) {
        GBCStatus *status=[[GBCStatus alloc] init];
        status.sid=[set longLongIntForColumnIndex:0];
        status.created_at=[set stringForColumnIndex:1];
        status.text=[set stringForColumnIndex:2];
        status.source=[set stringForColumnIndex:3];
        status.reposts_count=[set intForColumnIndex:4];
        status.comments_count=[set intForColumnIndex:5];
        status.attitudes_count=[set intForColumnIndex:6];
        
        GBCUser *user=[[GBCUser alloc] init];
        user.screen_name=[set stringForColumnIndex:7];
        user.profile_image_url=[set stringForColumnIndex:8];
        //status.profileimg=[set stringForColumnIndex:2];
        
        status.pic_urls=[set stringForColumnIndex:9];
        
        status.user=user;
        
        
        //调重写的set方法
        GBCStatusCellFrame *cellFrame=[[GBCStatusCellFrame alloc] init];
        cellFrame.status=status;
        [self.statusArr addObject:cellFrame];
        
    }
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GBCTableViewCell *cell=[GBCTableViewCell cellWithTableView:tableView];
    cell.statusCellFrame=self.statusArr[indexPath.row];
    return cell;
    
    
}

#pragma mark - uitableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBCStatusCellFrame *cellFrame=self.statusArr[indexPath.row];
    return cellFrame.cellHeight;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
