//
//  BoardView.h
//  画板
//
//  Created by 洪曦尘 on 15/12/24.
//  Copyright © 2015年 洪曦尘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView

@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSMutableArray *widthArray;
@property (nonatomic, strong) NSNumber *width;

- (void)revoke;
- (void)clean;

@end
