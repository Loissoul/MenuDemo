//
//  PGQSheetItem.h
//  MenuDemo
//
//  Created by Lois_pan on 16/5/27.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PGQSheetItem : NSObject

@property (nonatomic, copy)   NSString   * title;
@property (nonatomic, strong) UIImage    * iconImage;
@property (nonatomic, assign) NSUInteger   index;

- (instancetype)initWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSUInteger)index;

@end
