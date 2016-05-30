//
//  PGQMenuButton.h
//  MenuDemo
//
//  Created by Lois_pan on 16/5/27.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PGQSheetItem.h"


typedef void(^DidSelctedItemCompletedBlock)(PGQSheetItem *menuItem);

@interface PGQMenuButton : UIView

@property (nonatomic, copy) DidSelctedItemCompletedBlock didSelctedItemCompleted;

- (instancetype)initWithFrame:(CGRect)frame
                     menuItem:(PGQSheetItem*)menuItem;

@end
