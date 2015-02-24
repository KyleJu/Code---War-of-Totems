//
//  NJInfoViewController.m
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJInfoViewController.h"

@interface NJInfoViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation NJInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Info";

    
    [self addCancelBarbuttonItem];
    self.view.backgroundColor = [UIColor nj_redColor];
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
}

- (void)viewDidLayoutSubviews
{
    UIImageView *infoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 849)];
    infoImageView.image = [UIImage imageNamed:@"info"];
    infoImageView.contentMode = UIViewContentModeCenter;
    
    self.scrollView.contentSize = infoImageView.frame.size;
    [self.scrollView addSubview:infoImageView];
}

- (void)didReceiveMemoryWarning {
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

@end
