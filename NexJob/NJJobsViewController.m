//
//  NJJobsViewController.m
//  NexJob
//
//  Created by KP on 2/21/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJJobsViewController.h"
#import "NJStudyFieldViewController.h"
#import "NJMainNavigationViewController.h"
#import "NJInfoViewController.h"
#import "NJJobTableViewCell.h"
#import "JobProjection.h"

static NSString * const kNJJobTableViewCell = @"NJJobTableViewCell";

@interface NJJobsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfIndicatorView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *tabBarBackgroundView;

@end

@implementation NJJobsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Fastest Growing Jobs";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tabBarBackgroundView.backgroundColor = [UIColor nj_greyColor];
    
    [self setupBarButtonItems];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NJJobTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kNJJobTableViewCell];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:@"NJNotificationJobsVC" object:nil];
}


-(void)reloadTableView:(NSNotification*)notification
{
    self.arrayOfJobs = [notification object];
    [self.tableView reloadData];
}

- (void)setupBarButtonItems
{
    UIImage *image = [[UIImage imageNamed:@"navBarInfo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *infoBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(infoBarButtonItemPressed)];
    UIBarButtonItem *reselectBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reselect" style:UIBarButtonItemStylePlain target:self action:@selector(reselectBarButtonItemPressed)];

    self.navigationItem.leftBarButtonItem = infoBarButtonItem;
    self.navigationItem.rightBarButtonItem = reselectBarButtonItem;
}

- (void)infoBarButtonItemPressed
{
    NJInfoViewController *infoVC = [[NJInfoViewController alloc] init];
    NJMainNavigationViewController *navVC = [[NJMainNavigationViewController alloc] initWithRootViewController:infoVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)reselectBarButtonItemPressed
{
    NJStudyFieldViewController *introVC = [[NJStudyFieldViewController alloc] init];
    NJMainNavigationViewController *navVC = [[NJMainNavigationViewController alloc] initWithRootViewController:introVC];
    [introVC addCancelBarbuttonItem];
    introVC.isRootVCTabBar = YES;
    
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.widthOfIndicatorView.constant = self.view.frame.size.width/2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfJobs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:kNJJobTableViewCell];
    NJJobTableViewCell *contentCell = (NJJobTableViewCell *)cell;
    
    [contentCell configureCell:self.arrayOfJobs[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
