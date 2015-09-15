//
//  FlowView.m
//  Collection
//
//  Created by Charlie.huang on 15/9/1.
//  Copyright (c) 2015年 Chalie. All rights reserved.
//

#import "FlowView.h"
#import "FlowViewCell.h"
#define SIDE_MARGIN 20
#define CELL_WIDTH self.frame.size.width - 2 * SIDE_MARGIN
#define BETWEEN_MARGIN 0
#define TOP_MARGIN self.center.y - 125
#define MIN_SCALE 0.7
#define MAX_SCALE 1.0
#define TAG_OFFSET 1000
@interface FlowView ()<UIScrollViewDelegate>
{
    UIScrollView *centerView;
    NSArray *imageArr;
    CGFloat curPage;
    NSNumber *currentPageForReuse;
}
@property(strong,nonatomic) NSMutableArray* reusableArr;
@property(strong,nonatomic) NSMutableArray* visibleArr;
@end

@implementation FlowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr1
{
    imageArr = [[NSArray alloc] initWithArray:imageArr1];
    return [self initWithFrame:frame];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       [self initView];
    }
    return self;
}

-(void)initView
{
    //config scrollview
    self.clipsToBounds = YES;
    centerView = [[UIScrollView alloc] initWithFrame:CGRectMake(SIDE_MARGIN, TOP_MARGIN, CELL_WIDTH, CELL_WIDTH+ BETWEEN_MARGIN)];
    centerView.backgroundColor = [UIColor cyanColor];
    centerView.delegate = self;
    centerView.center = self.center;
    CGFloat sizeHeight = (CELL_WIDTH + BETWEEN_MARGIN) * imageArr.count;
    centerView.contentSize = CGSizeMake(0, sizeHeight);
    centerView.pagingEnabled = YES;
    //重点  no 之后可以显示view frame外的视图
    centerView.clipsToBounds = NO;
    centerView.showsHorizontalScrollIndicator = NO;
    centerView.showsVerticalScrollIndicator = NO;
    [self addSubview:centerView];
    //配置view
//    UIImageView *tempImageV;
//    UITapGestureRecognizer *tap;
//    for (int i = 0; i < imageArr.count; i++) {
//
//        tempImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,(CELL_WIDTH + BETWEEN_MARGIN) * i , CELL_WIDTH, CELL_WIDTH )];
//        if (i != 0) {
//        tempImageV.transform = CGAffineTransformMakeScale(MIN_SCALE, MIN_SCALE);
//        }
//        tempImageV.image = [imageArr objectAtIndex:i];
//        tempImageV.tag = TAG_OFFSET + i;
//        tempImageV.layer.shadowColor = [UIColor blackColor].CGColor;
//        tempImageV.layer.shadowRadius = 4;
//        tempImageV.layer.shadowOpacity = 1;
//        tempImageV.layer.shadowOffset = CGSizeMake(0, 0);
//        tempImageV.userInteractionEnabled = YES;
//        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
//        [tempImageV addGestureRecognizer:tap];
//        [centerView addSubview:tempImageV];
//    }
    [self loadPage:0 first:YES];
}
/**
 *  reuse part 重用部分
 */
-(NSMutableArray *)reusableArr
{
    //get 方法 当重用数组为空的时候 new一个
    if (!_reusableArr) {
        _reusableArr = [NSMutableArray array];
    }
    return _reusableArr;
}
-(NSMutableArray *)visibleArr
{
    //当可视view 数据为空的时候 new一个
    if (!_visibleArr) {
        _visibleArr = [NSMutableArray array];
    }
    return _visibleArr;
}
-(void)enqueueReusable:(FlowViewCell *)view
{
    //加入重用数组中
    //由于图像进行缩小处理在放入重用数组之前必须将比例弄成原来大小，这样才保证重用后的坐标能够与之对应
    view.transform = CGAffineTransformMakeScale(1, 1);
    [self.reusableArr addObject:view];
}
-(FlowViewCell *)dequeueReusableWithPage:(NSInteger)page
{
    //类似tableView的dequeue  
    static int numberOfInstance = 0;
    FlowViewCell* view = [self.reusableArr firstObject];
    if (view) {
        [self.reusableArr removeObject:view];
    }
    else
    {
        view = [[FlowViewCell alloc] init];
        view.numberOfInstance = numberOfInstance;
        numberOfInstance ++;
    }
    return view;
}
-(void)addViewForPage:(NSInteger)page first:(BOOL)isFirst
{
    if (page < 0 || page >= imageArr.count) {
        return;
    }
    FlowViewCell *tempImageV = [self dequeueReusableWithPage:page];
    tempImageV.page = @(page);
    tempImageV.frame = CGRectMake(0, (CELL_WIDTH + BETWEEN_MARGIN) * page , CELL_WIDTH, CELL_WIDTH);
    tempImageV.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, CELL_WIDTH, CELL_WIDTH )];
    
//    CAGradientLayer* maskLayer = [CAGradientLayer layer];
//    maskLayer.frame = tempImageV.imageView.frame;
//    maskLayer.colors = @[[UIColor redColor],[UIColor blackColor]];
//    maskLayer.startPoint = CGPointZero;
//    maskLayer.endPoint = CGPointMake(100, 100);
//    [tempImageV.maskView.layer addSublayer:maskLayer];

    [tempImageV addSubview:tempImageV.imageView];

    if (page != 0) {
        tempImageV.transform = CGAffineTransformMakeScale(MIN_SCALE, MIN_SCALE);
    }else if (page == 0 && !isFirst)
    {
        tempImageV.transform = CGAffineTransformMakeScale(MIN_SCALE, MIN_SCALE);
    }
    tempImageV.imageView.image = [imageArr objectAtIndex:page];
    tempImageV.tag = TAG_OFFSET + page;
    tempImageV.layer.shadowColor = [UIColor blackColor].CGColor;
    tempImageV.layer.shadowRadius = 4;
    tempImageV.layer.shadowOpacity = 1;
    tempImageV.layer.shadowOffset = CGSizeMake(0, 0);
    tempImageV.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [tempImageV addGestureRecognizer:tap];
    [centerView addSubview:tempImageV];
    [_visibleArr addObject:tempImageV];
    NSLog(@"img:%@",tempImageV);
}
-(void)loadPage:(NSInteger)page first:(BOOL)isFirst
{
    if (currentPageForReuse && page == [currentPageForReuse integerValue]) {
        return;
    }
    currentPageForReuse = @(page);
    NSMutableArray *pagesToLoad = [@[@(page), @(page - 1), @(page + 1),@(page + 2)] mutableCopy];
    NSMutableArray *viewToEnqueue = [NSMutableArray array];
    for (FlowViewCell *view in self.visibleArr) {
        if (!view.page || ![pagesToLoad containsObject:view.page]) {
            
            [viewToEnqueue addObject:view];
        }else if (view.page)
        {
            [pagesToLoad removeObject:view.page];
        }
    }
    for (FlowViewCell *view in viewToEnqueue) {
        [view removeFromSuperview];
        [_visibleArr removeObject:view];
        [self enqueueReusable:view];
    }
    for (NSNumber *page1 in pagesToLoad) {
        [self addViewForPage:[page1 integerValue] first:isFirst];
    }
}
//
-(void)tapHandle:(UIGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(tapOnViewHandle:)]) {
        [self.delegate tapOnViewHandle:gesture.view];
    }
    NSLog(@"%ld",gesture.view.tag);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSInteger c = offset.y / scrollView.bounds.size.height;
     curPage =fabs(offset.y / scrollView.bounds.size.height);
    c = MAX(c, 0);
    c = MIN(c, imageArr.count - 1);

    [self loadPage:c first:NO];
    [self animationVisibleViewWithIntPage:c];
}
-(void)animationVisibleViewWithIntPage:(NSInteger)c
{
   UIView *curView = [self viewWithTag:(curPage + TAG_OFFSET)];
    CGFloat curViewScale = MAX_SCALE - (curPage - c)* (MAX_SCALE - MIN_SCALE);
    curView.transform = CGAffineTransformMakeScale(curViewScale, curViewScale);
    UIView *nextView = [self viewWithTag:(curPage + TAG_OFFSET + 1)];
    CGFloat nextViewScale = MAX_SCALE + (curPage - c - 1)* (MAX_SCALE - MIN_SCALE);
    nextView.transform = CGAffineTransformMakeScale(nextViewScale,nextViewScale);
}
-(CGPoint)nearestTar:(CGPoint)offset
{
    CGFloat pageSize = CELL_WIDTH + BETWEEN_MARGIN;
    NSInteger c = roundf(offset.y / pageSize);
    CGFloat targetY = pageSize * c ;
    return CGPointMake(offset.x, targetY);
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint tartOffset = [self nearestTar:* targetContentOffset];
    targetContentOffset->x = tartOffset.x;
    targetContentOffset->y = tartOffset.y;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     NSLog(@"did end DECE anim");
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"did end scroll anim");
}
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"did scroll to top");
}
@end
