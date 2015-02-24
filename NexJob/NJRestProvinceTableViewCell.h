//
//  NJRestProvinceTableViewCell.h
//  NexJob
//
//  Created by KP on 2/22/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provinces.h"

@interface NJRestProvinceTableViewCell : UITableViewCell

- (void)configureCell:(Provinces*)province withRank:(NSInteger)index;

@end
