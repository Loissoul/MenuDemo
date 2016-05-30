//
//  PGQMenuButton.m
//  MenuDemo
//
//  Created by Lois_pan on 16/5/27.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import "PGQMenuButton.h"

@interface PGQMenuButton()

@property (nonatomic, strong) UIButton *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) PGQSheetItem * menuItem;


@end

@implementation PGQMenuButton

- (instancetype)initWithFrame:(CGRect)frame
                     menuItem:(PGQSheetItem*)menuItem{

    self = [super initWithFrame:frame];
    
    if (self) {
        self.menuItem = menuItem;
//        self.iconImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, menuItem.iconImage.size.width, menuItem.iconImage.size.height)];
        self.iconImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        self.iconImageView.userInteractionEnabled = NO;
        [self.iconImageView setImage:menuItem.iconImage forState:UIControlStateNormal];
        self.iconImageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.iconImageView.bounds));
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), CGRectGetWidth(self.bounds), 35)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = menuItem.title;
        CGPoint center = self.titleLabel.center;
        center.x = CGRectGetMidX(self.bounds);
        self.titleLabel.center = center;
        [self addSubview:self.titleLabel];
        [self addSelfGesture];
    }
    return self;
}


-(void)addSelfGesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTapClick)];
    
    [self addGestureRecognizer:tap];
}

-(void)addTapClick
{
    if (self.didSelctedItemCompleted) {
        self.didSelctedItemCompleted(self.menuItem);
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 播放缩放动画
    [self initIBeaconAnimate];
}



-(void)initIBeaconAnimate{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.5;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.1];
    [self.layer addAnimation:animation forKey:@"scale-layer"];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self initIBeaconAnimate];
    
}


@end
