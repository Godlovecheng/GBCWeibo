//
//  GBCDiscoverTblViewController.m
//  GBCWeibo
//
//  Created by Denny_cheng on 15/8/25.
//  Copyright (c) 2015年 Denny_cheng. All rights reserved.
//

#import "GBCDiscoverTblViewController.h"
#import "GBCSearchBar.h"

@interface GBCDiscoverTblViewController ()

@end

@implementation GBCDiscoverTblViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UISearchBar *search=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
//    self.navigationItem.titleView=search;
    
    GBCSearchBar *search=[[GBCSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-20, 32)];
    //search.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    UIImage *img=[UIImage imageNamed:@"searchbar_textfield_search_icon"];
    UIImageView *imgView=[[UIImageView alloc] initWithImage:img];
    //imgView.frame=CGRectMake(50, 0, img.size.width, img.size.height);
    
    search.borderStyle=UITextBorderStyleRoundedRect;
    search.leftView=imgView;
    search.leftViewMode=UITextFieldViewModeAlways;
    self.navigationItem.titleView=search;
    
    //self.title=@"发现";

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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