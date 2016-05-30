//
//  ViewController.m
//  MenuDemo
//
//  Created by Lois_pan on 16/5/27.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

#import "ViewController.h"

#import "PGQSheetItem.h"

#import "PGQMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton * buttonMenuView = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    buttonMenuView.backgroundColor = [UIColor greenColor];
    
    [buttonMenuView addTarget:self action:@selector(addMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonMenuView];
}


-(void)testClick
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    
    view.backgroundColor = [UIColor greenColor];
    [view addGestureRecognizer:tap];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    [self.view addSubview:view];
}


-(void)tapClick
{
    NSLog(@"点击了View");
}

-(void)buttonClick
{
    NSLog(@"点击了button");
}

- (void)addMenuView
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    PGQSheetItem * menuItem = [[PGQSheetItem alloc] initWithTitle:@"呵呵呵哒" iconName:@"5.png" index:0];
    
    [items addObject:menuItem];
    
    menuItem = [[PGQSheetItem alloc] initWithTitle:@"呵呵呵哒" iconName:@"5.png" index:1];
    [items addObject:menuItem];
//
    menuItem = [[PGQSheetItem alloc] initWithTitle:@"呵呵呵哒" iconName:@"5.png" index:2];
    [items addObject:menuItem];
//
    menuItem = [[PGQSheetItem alloc] initWithTitle:@"呵呵呵哒" iconName:@"5.png" index:3];
    [items addObject:menuItem];
    
    menuItem = [[PGQSheetItem alloc] initWithTitle:@"呵呵呵哒" iconName:@"5.png" index:4];
    [items addObject:menuItem];
    
    menuItem = [[PGQSheetItem alloc] initWithTitle:@"呵呵呵哒" iconName:@"5.png" index:5];
    [items addObject:menuItem];
    
    PGQMenuView *centerButton = [[PGQMenuView alloc] initWithFrame:self.view.bounds items:items];
    centerButton.perRowItemCount = 2;
    centerButton.didSelectedItemCompletion = ^(PGQSheetItem *selectedItem) {
        
        NSLog(@"%ld",selectedItem.index);
        NSLog(@"hehehda ");
        
    };
    
    [self.view addSubview:centerButton];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

@end
