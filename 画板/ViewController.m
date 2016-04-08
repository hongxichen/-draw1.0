//
//  ViewController.m
//  画板
//
//  Created by 洪曦尘 on 15/12/24.
//  Copyright © 2015年 洪曦尘. All rights reserved.
//

#import "ViewController.h"
#import "TopView.h"
#import "BoardView.h"

@interface ViewController ()
{
    TopView *topView;
    BoardView *boardView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    topView = [[TopView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 100)];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topView];
    
    boardView = [[BoardView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight - 120)];
    boardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boardView];
    
    __weak BoardView *weakBoardView = boardView;
    
    topView.colorBlock = ^(UIColor *color){
        
        weakBoardView.color = color;
        
    };
    
    topView.widthBlock = ^(NSNumber *width){
        
        weakBoardView.width = width;
        
    };
    
    topView.revokeBlock = ^(){
        
        [weakBoardView revoke];
        
    };
    
    topView.cleanBlock = ^(){
        
        [weakBoardView clean];
        
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
