//
//  NJIntroViewController.m
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJIntroViewController.h"
#import "NJStudyFieldViewController.h"
#import "NJMainNavigationViewController.h"

@interface NJIntroViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintFromTopForLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintFromBottomForLogo;
@property (weak, nonatomic) IBOutlet UIImageView *companyLabelImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;

- (IBAction)continueButtonPressed:(UIButton *)sender;

@end

@implementation NJIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor nj_redColor];
    
    self.continueButton.layer.cornerRadius = 5.0;
    self.continueButton.backgroundColor = [UIColor whiteColor];
    self.continueButton.enabled = NO;
    self.continueButton.alpha = 0;
}

- (void)viewDidLayoutSubviews
{
    self.constraintFromTopForLabel.constant = self.view.frame.size.height/4 - self.companyLabelImageView.frame.size.height/2;
    self.constraintFromBottomForLogo.constant = self.view.frame.size.height/4 - self.logoImageView.frame.size.height/2;
    
    [UIView animateWithDuration:1.5 animations:^{
        self.lineView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height/2 - 75.0f);
        self.lineView.layer.cornerRadius = 5.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.7 animations:^{
            CGRect currentFrame = self.lineView.frame;
            self.lineView.frame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width, 60.0f);
        } completion:^(BOOL finished) {
            [self.view bringSubviewToFront:self.continueButton];
            self.continueButton.enabled = YES;
            self.continueButton.alpha = 1;
        }];
    }];
    
    [UIView animateWithDuration:1.7 animations:^{
        self.logoImageView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height/2);
        self.companyLabelImageView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height/4);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)continueButtonPressed:(UIButton *)sender
{
    NJStudyFieldViewController *introVC = [[NJStudyFieldViewController alloc] init];
    NJMainNavigationViewController *navVC = [[NJMainNavigationViewController alloc] initWithRootViewController:introVC];
    introVC.isRootVCTabBar = NO;
    
    [self presentViewController:navVC animated:YES completion:nil];
}
@end
