//
//  TopView.h
//  画板
//
//  Created by 洪曦尘 on 15/12/24.
//  Copyright © 2015年 洪曦尘. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ColorBlock)(UIColor *);
typedef void (^WidthBlock)(NSNumber *);
typedef void (^RevokeBlock)();
typedef void (^CleanBlock)();

@interface TopView : UIView

@property (nonatomic,strong) UIColor *selectColor;
@property (nonatomic,strong) NSNumber *selectWidth;

@property (nonatomic,copy) ColorBlock colorBlock;
@property (nonatomic,copy) WidthBlock widthBlock;
@property (nonatomic,copy) RevokeBlock revokeBlock;
@property (nonatomic,copy) CleanBlock cleanBlock;

@end
