//
//  FlowViewCell.m
//  Collection
//
//  Created by Charlie.huang on 15/9/7.
//  Copyright (c) 2015年 Chalie. All rights reserved.
//

#import "FlowViewCell.h"

@implementation FlowViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame Page:(NSInteger)page
{
    if (self = [super initWithFrame:frame]) {
        self.page = @(page);
    }
    return self;
}
- (void)setPage:(NSNumber *)page
{
    if (_page != page) {
        _page = page;
        [self reloadData];
    }
}
- (void)reloadData
{
    NSLog(@"asdasdasdad:%ld",(long)self.numberOfInstance);
//    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"676x676.jpg"]];
//    [self addSubview:self.imageView];
    //self.imageView =
//    self.instanceNumberLabel.text = [NSString stringWithFormat:@"Instance #%ld", self.numberOfInstance];
}

@end
