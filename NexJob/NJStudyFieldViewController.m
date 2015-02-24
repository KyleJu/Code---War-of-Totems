//
//  NJStudyFieldViewController.m
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJStudyFieldViewController.h"
#import "NJStudyFieldTableViewCell.h"
#import "AppDelegate.h"

static NSString * const kNJStudyFieldTableViewCell = @"NJStudyFieldTableViewCell";

@interface NJStudyFieldViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayOfStudyFields;

@end

@implementation NJStudyFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select Your Field of Study";
    
    self.arrayOfStudyFields = @[@"Architecture", @"Arts", @"Business", @"Education", @"Engineering", @"Forestry", @"Land and Food Systems", @"Law", @"Library, Archival and Information Studies", @"Medicine, Nursing, Pharmacy", @"Music", @"Science"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NJStudyFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kNJStudyFieldTableViewCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addCancelBarbuttonItem
{
    UIImage *image = [[UIImage imageNamed:@"navBarClose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(cancelBarButtonItemPressed)];
    
    self.navigationItem.rightBarButtonItem = cancelBarButtonItem;
}

- (void)cancelBarButtonItemPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfStudyFields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:kNJStudyFieldTableViewCell];
    NJStudyFieldTableViewCell *contentCell = (NJStudyFieldTableViewCell *)cell;
    
    [contentCell configureCell:self.arrayOfStudyFields[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *groupCodes = [self retrieveGroupCodesForSelectedRow:indexPath.row];
    NSArray *industryCodes = [self retrieveIndustryCodesForSelectedRow:indexPath.row];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] fetchJobsWithGroupCodes:groupCodes andIndustryCodes:industryCodes];
    
    NSLog(@"%lu", indexPath.row);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (!self.isRootVCTabBar) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] transitionToResultsScreen];
    }
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

#pragma mark - Helper Methods

- (NSArray *)retrieveGroupCodesForSelectedRow:(NSUInteger)index
{
    switch (index) {
        case 0:
            return @[@"7", @"20"];
            break;
        case 1:
            return @[@"5", @"13", @"14", @"15", @"16", @"18", @"19", @"22", @"23"];
            break;
        case 2:
            return @[@"1", @"2", @"3", @"4", @"6", @"17"];
            break;
        case 3:
            return @[@"12", @"13"];
            break;
        case 4:
            return @[@"7", @"8", @"20", @"21", @"26", @"27"];
            break;
        case 5:
            return @[@"20", @"24", @"25", @"27", @"28"];
            break;
        case 6:
            return @[@"16", @"24", @"25", @"28"];
            break;
        case 7:
            return @[@"0", @"13"];
            break;
        case 8:
            return @[@"14"];
            break;
        case 9:
            return @[@"9", @"10", @"11"];
            break;
        case 10:
            return @[@"14", @"15"];
            break;
        case 11:
            return @[@"7", @"8"];
            break;
        default:
            break;
    }
    
    return nil;
}

- (NSArray *)retrieveIndustryCodesForSelectedRow:(NSUInteger)index
{
    switch (index) {
        case 0:
            return @[@"6"];
            break;
        case 1:
            return @[@"5", @"9", @"10", @"16", @"17", @"18", @"19"];
            break;
        case 2:
            return @[@"9", @"11", @"13"];
            break;
        case 3:
            return @[@"14"];
            break;
        case 4:
            return @[@"6", @"7", @"12"];
            break;
        case 5:
            return @[@"4"];
            break;
        case 6:
            return @[@"17"];
            break;
        case 7:
            return @[@"18", @"19"];
            break;
        case 8:
            return @[@"14", @"16"];
            break;
        case 9:
            return @[@"15"];
            break;
        case 10:
            return @[@"16"];
            break;
        case 11:
            return @[@"12"];
            break;
        default:
            break;
    }
    
    return nil;
}

@end
