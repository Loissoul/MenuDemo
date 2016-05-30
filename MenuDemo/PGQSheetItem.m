//
//  PGQSheetItem.m
//  MenuDemo
//
//  Created by Lois_pan on 16/5/27.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import "PGQSheetItem.h"

@implementation PGQSheetItem

- (instancetype)initWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.title = title;
        self.iconImage = [UIImage imageNamed:iconName];
        self.index = index;
    }
    return self;
}

@end
