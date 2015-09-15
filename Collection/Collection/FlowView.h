//
//  FlowView.h
//  Collection
//
//  Created by Charlie.huang on 15/9/1.
//  Copyright (c) 2015年 Chalie. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FlowViewDelegate <NSObject>

-(void)tapOnViewHandle:(UIView *)view;

@end
@interface FlowView : UIView

@property (nonatomic,weak)id<FlowViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr;
-(instancetype)initWithFrame:(CGRect)frame;
@end

