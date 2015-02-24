//
//  NJRestProvinceTableViewCell.m
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJRestProvinceTableViewCell.h"

@interface NJRestProvinceTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *rankBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *abbreviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end

@implementation NJRestProvinceTableViewCell

- (void)awakeFromNib
{
    self.rankBackgroundView.backgroundColor = [UIColor nj_redColor];
    self.provinceNameLabel.adjustsFontSizeToFitWidth = YES;
    self.rankBackgroundView.layer.cornerRadius = self.rankBackgroundView.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(Provinces *)province withRank:(NSInteger)index
{
    self.rankLabel.text = [NSString stringWithFormat:@"%lu", index];
    self.abbreviationLabel.text = province.abbreviation;
    self.provinceNameLabel.text = province.provinceName;
}

@end
