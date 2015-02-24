//
//  NJMainNavigationViewController.m
//  NexJob
//
//  Created by KP on 2/21/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJMainNavigationViewController.h"

@interface NJMainNavigationViewController ()

@end

@implementation NJMainNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Regular" size:17.0f], NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationBar.barTintColor = [UIColor nj_greyColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
