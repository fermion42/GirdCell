//
//  AGGridCell.h
//  GridCell
//
//  Created by Yang Han on 15/3/28.
//  Copyright (c) 2015 Yang Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGGridCell : UITableViewCell

@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) UIButton *addButton;

- (void)appendPhoto:(UIImage *)photo;

@end
