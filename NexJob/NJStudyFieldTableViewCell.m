//
//  NJStudyFieldTableViewCell.m
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJStudyFieldTableViewCell.h"

@interface NJStudyFieldTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NJStudyFieldTableViewCell

- (void)awakeFromNib
{
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
