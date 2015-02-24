//
//  NJRestJobTableViewCell.m
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJJobTableViewCell.h"

@interface NJJobTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageProjectionLabel;


@end

@implementation NJJobTableViewCell

- (void)awakeFromNib {
    self.jobTitleLabel.textColor = [UIColor blackColor];
    self.indicatorView.layer.cornerRadius = self.indicatorView.frame.size.width/2;
    
    self.jobTitleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(JobProjection *)job
{
    // depending on whether job's group number is selected or not, change font, grouplabel
    
    self.indicatorView.backgroundColor = [UIColor nj_redColor];
    self.jobTitleLabel.text = job.jobTitle;
    self.averageProjectionLabel.text = [NSString stringWithFormat:@"%.02f%%", job.projectionAverage];
}

@end
