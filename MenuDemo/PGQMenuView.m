//
//  PGQMenuView.m
//  MenuDemo
//
//  Created by Lois_pan on 16/5/27.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import "PGQMenuView.h"

#import "PGQMenuButton.h"
#define MenuButtonHeight 110
#define MenuButtonVerticalPadding 10
#define MenuButtonHorizontalMargin 10
#define MenuButtonAnimationTime 0.2
#define MenuButtonAnimationInterval (MenuButtonAnimationTime / 5)

#define kMenuButtonBaseTag 100

@interface PGQMenuView()
{
    NSInteger columnNum;
}
@property (nonatomic, strong, readwrite) NSArray *items;

@property (nonatomic, strong) PGQSheetItem *selectedItem;

@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) UIImageView *deleteImage;

@property (nonatomic, strong) UIView * bottomView;

@end

@implementation PGQMenuView

- (NSArray *)menuItems {
    return self.items;
}

- (instancetype)initWithFrame:(CGRect)frame
                        items:(NSArray*)items
{
    self = [super initWithFrame: frame];
    
    if (self) {
        if (!self.perRowItemCount) {
            columnNum = 2;
        }
        self.items = items;
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addTapGesture];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addDeleteImageView];
    [self showButtons];
}

//添加删除的图片
-(void)addDeleteImageView
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDissClick)];
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-40, CGRectGetWidth(self.bounds), 40)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.alpha = 0;
    [_bottomView addGestureRecognizer:tap];
    
    _deleteImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_bottomView.bounds)/2-15, (CGRectGetHeight(_bottomView.bounds)-30)/2, 30, 30)];
    _deleteImage.image = [UIImage imageNamed:@"deleteImage.png"];
    
    [UIView animateWithDuration:1.0 animations:^{
        _deleteImage.transform = CGAffineTransformRotate(_deleteImage.transform, M_PI_4);
        _bottomView.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];

    [_bottomView addSubview:_deleteImage];
    [self addSubview:_bottomView];
}


//设置有多少列
-(void)setPerRowItemCount:(NSInteger)perRowItemCount
{
    columnNum = perRowItemCount;
    [self showButtons];
}

//添加点击消失的手势
-(void) addTapGesture{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDissClick)];
    
    [self addGestureRecognizer:tap];
}

-(void)tapDissClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _deleteImage.transform = CGAffineTransformRotate(_deleteImage.transform, M_PI_4);
        _bottomView.alpha = 0;
    } completion:^(BOOL finished) {
    }];

    [self hidenButtons];
    typeof(self) __weak weakSelf = self;
    double delayInSeconds = (self.items.count + 3) * MenuButtonAnimationInterval;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf removeFromSuperview];
    });
}


#pragma mark - 私有方法
- (void)showButtons {
    NSArray *items = [self menuItems];
    
    CGFloat menuButtonWidth = (CGRectGetWidth(self.bounds) - ((columnNum + 1) * MenuButtonHorizontalMargin)) / columnNum;
    
//计算每列有多少行
    CGFloat perRowItemCountNum = items.count / columnNum;
    
    if (items.count % columnNum != 0 ) {
        perRowItemCountNum += 1;
    }
    
    typeof(self) __weak weakSelf = self;
    
    for (int index = 0; index < items.count; index ++) {
        
        PGQSheetItem *menuItem = items[index];
        menuItem.index = index;
        PGQMenuButton *menuButton = (PGQMenuButton *)[self viewWithTag:kMenuButtonBaseTag + index];
        
        CGRect toRect = [self getFrameWithItemCount:items.count perRowItemCount:columnNum perColumItemCount:perRowItemCountNum itemWidth:menuButtonWidth itemHeight:MenuButtonHeight paddingX:MenuButtonVerticalPadding paddingY:MenuButtonHorizontalMargin atIndex:index onPage:0];
        
        CGRect fromRect = toRect;
        fromRect.origin.y = CGRectGetHeight(self.bounds);
        if (!menuButton) {
            menuButton = [[PGQMenuButton alloc] initWithFrame:fromRect menuItem:menuItem];
            menuButton.tag = kMenuButtonBaseTag + index;
            menuButton.didSelctedItemCompleted = ^(PGQSheetItem *menuItem) {
                weakSelf.selectedItem = menuItem;
                if (weakSelf.didSelectedItemCompletion) {
                    weakSelf.didSelectedItemCompletion(weakSelf.selectedItem);
                }
            //点击消失
                [weakSelf tapDissClick];
            };
            [self addSubview:menuButton];
        } else {
            menuButton.frame = fromRect;
        }
        
        double delayInSeconds = index * (MenuButtonAnimationInterval+0.1);
        
        [self initailzerAnimationWithToPostion:toRect withView:menuButton beginTime:delayInSeconds];
    }
}

- (void)hidenButtons {
    NSArray *items = [self menuItems];

    for (int index = 0; index < items.count; index ++) {
        PGQMenuButton *menuButton = (PGQMenuButton *)[self viewWithTag:kMenuButtonBaseTag + index];
        
        CGRect fromRect = menuButton.frame;
        
        CGRect toRect = fromRect;
        toRect.origin.y = CGRectGetHeight(self.bounds);
        
        double delayInSeconds = (items.count - index) * MenuButtonAnimationInterval;
        [self initailzerAnimationWithToPostion:toRect withView:menuButton beginTime:delayInSeconds];
    }
}


/**
 *  通过目标的参数，获取一个grid布局
 *
 *  @param perRowItemCount   每行有多少列
 *  @param perColumItemCount 每列有多少行
 *  @param itemWidth         gridItem的宽度
 *  @param itemHeight        gridItem的高度
 *  @param paddingX          gridItem之间的X轴间隔
 *  @param paddingY          gridItem之间的Y轴间隔
 *  @param index             某个gridItem所在的index序号
 *  @param page              某个gridItem所在的页码
 *
 *  @return 返回一个已经处理好的gridItem frame
 */
- (CGRect)getFrameWithItemCount:(NSInteger)itemCount
                perRowItemCount:(NSInteger)perRowItemCount
              perColumItemCount:(NSInteger)perColumItemCount
                      itemWidth:(CGFloat)itemWidth
                     itemHeight:(NSInteger)itemHeight
                       paddingX:(CGFloat)paddingX
                       paddingY:(CGFloat)paddingY
                        atIndex:(NSInteger)index
                         onPage:(NSInteger)page
{
    //
    NSUInteger rowCount = itemCount / perRowItemCount + (itemCount % perColumItemCount > 0 ? 1 : 0);
    
    //计算每个空间的Y
    CGFloat insetY = (CGRectGetHeight(self.bounds) - (itemHeight + paddingY) * rowCount) -200;
    
    CGFloat originY = ((index / perRowItemCount) - perColumItemCount * page) * (itemHeight + paddingY) + paddingY;
    
    //计算每个控件的x
    
    CGFloat originX = (index % perRowItemCount) * (itemWidth + paddingX) + paddingX + (page * CGRectGetWidth(self.bounds));
    
    CGRect itemFrame = CGRectMake(originX, originY + insetY, itemWidth, itemHeight);
    
    return itemFrame;
}


#pragma mark - Animation
- (void)initailzerAnimationWithToPostion:(CGRect)toRect withView:(UIView *)view beginTime:(CFTimeInterval)beginTime {
    //一个点到另一个点的动画
    [UIView animateWithDuration:1.0 delay:beginTime usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = toRect;
    } completion:^(BOOL finished) {
        
    }];
}


@end
