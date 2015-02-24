//
//  NJIndustriesViewController.m
//  NexJob
//
//  Created by KP on 2/21/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJIndustriesViewController.h"
#import "NJStudyFieldViewController.h"
#import "NJMainNavigationViewController.h"
#import "NJInfoViewController.h"
#import "NJTopProvinceTableViewCell.h"
#import "NJRestProvinceTableViewCell.h"

static NSString * const kNJTopProvinceTableViewCell = @"NJTopProvinceTableViewCell";
static NSString * const kNJRestProvinceTableViewCell = @"NJRestProvinceTableViewCell";

typedef NS_ENUM(NSInteger, NJIndustriesSection) {
    NJIndustriesSectionNumberOne,
    NJIndustriesSectionRest,
    NJIndustriesSectionCount
};

@interface NJIndustriesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *tabBarBackgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *numberOne;
@property (strong, nonatomic) NSArray *rest;

@end

@implementation NJIndustriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Most Suitable Provinces";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarBackgroundView.backgroundColor = [UIColor nj_greyColor];
    
    [self setupBarButtonItems];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NJTopProvinceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kNJTopProvinceTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"NJRestProvinceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kNJRestProvinceTableViewCell];
}

-(void)reloadTableView:(NSNotification*)notification
{
    self.arrayOfIndustries = [notification object];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NJIndustriesSectionCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == NJIndustriesSectionNumberOne) ? 275.0f : 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == NJIndustriesSectionNumberOne) ? 1 : 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case NJIndustriesSectionNumberOne: {
            cell = [tableView dequeueReusableCellWithIdentifier:kNJTopProvinceTableViewCell];
            NJTopProvinceTableViewCell *contentCell = (NJTopProvinceTableViewCell *)cell;
            [contentCell configureCell:self.arrayOfIndustries[indexPath.row]];
        }   break;
        case NJIndustriesSectionRest: {
            cell = [tableView dequeueReusableCellWithIdentifier:kNJRestProvinceTableViewCell];
            NJRestProvinceTableViewCell *contentCell = (NJRestProvinceTableViewCell *)cell;
            [contentCell configureCell:self.arrayOfIndustries[indexPath.row + 1] withRank:indexPath.row +
             2];
        }   break;
        default:
            break;
    }
    
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
