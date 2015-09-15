//
//  FlowViewCell.h
//  Collection
//
//  Created by Charlie.huang on 15/9/7.
//  Copyright (c) 2015年 Chalie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowViewCell : UIView
@property (assign, nonatomic) NSInteger numberOfInstance;
@property (assign, nonatomic) NSNumber* page;
@property (nonatomic,retain)UIImageView* imageView;
- (void)reloadData;
-(instancetype)initWithFrame:(CGRect)frame Page:(NSInteger)page;
@end
