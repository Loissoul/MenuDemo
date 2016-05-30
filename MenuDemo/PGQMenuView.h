//
//  PGQMenuView.h
//  MenuDemo
//
//  Created by Lois_pan on 16/5/27.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PGQSheetItem.h"

typedef void(^DidSelectedItemBlock)(PGQSheetItem *selectedItem);


@interface PGQMenuView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                        items:(NSArray*)items;

@property (nonatomic, strong, readonly) NSArray *items;

@property (nonatomic, copy) DidSelectedItemBlock didSelectedItemCompletion;

@property (nonatomic, assign)NSInteger  perRowItemCount;//每行 有多少个


@end
