//
//  NJTopProvinceTableViewCell.m
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "NJTopProvinceTableViewCell.h"

@interface NJTopProvinceTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *numberOneRankView;
@property (weak, nonatomic) IBOutlet UILabel *abbreviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceNameLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@end

@implementation NJTopProvinceTableViewCell

- (void)awakeFromNib {
    self.containerView.backgroundColor = [UIColor nj_redColor];
    self.containerView.layer.cornerRadius = 5.0f;
    
    self.numberOneRankView.layer.cornerRadius = self.numberOneRankView.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(Provinces *)province
{
    self.abbreviationLabel.text = province.abbreviation;
    self.provinceNameLabel.text = province.provinceName;
}

@end
