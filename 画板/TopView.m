//
//  TopView.m
//  画板
//
//  Created by 洪曦尘 on 15/12/24.
//  Copyright © 2015年 洪曦尘. All rights reserved.
//

#import "TopView.h"

@implementation TopView

{
    NSMutableArray *_colorArray;
    NSMutableArray *_lineWidthArray;
    UIView *_colorView;
    UIView *_lineWidthView;
    UIView *_selectView;
    UIImageView *_selectColorView;
    UIImageView *_selectWidthView;
    UIColor *_lastColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _colorArray = [[NSMutableArray alloc] init];
        [_colorArray addObject:[UIColor grayColor]];
        [_colorArray addObject:[UIColor redColor]];
        [_colorArray addObject:[UIColor greenColor]];
        [_colorArray addObject:[UIColor blueColor]];
        [_colorArray addObject:[UIColor yellowColor]];
        [_colorArray addObject:[UIColor orangeColor]];
        [_colorArray addObject:[UIColor purpleColor]];
        [_colorArray addObject:[UIColor brownColor]];
        [_colorArray addObject:[UIColor blackColor]];
        
        _lineWidthArray = [[NSMutableArray alloc] init];
        [_lineWidthArray addObject:@1];
        [_lineWidthArray addObject:@3];
        [_lineWidthArray addObject:@5];
        [_lineWidthArray addObject:@8];
        [_lineWidthArray addObject:@10];
        [_lineWidthArray addObject:@15];
        [_lineWidthArray addObject:@20];
        
        [self _createView];
        [self _createColorView];
        [self _createLineWidthView];
        [self _createSelectView];
        
        self.selectColor = [UIColor redColor];
    }
    
    return self;
}

//选择按钮的视图
- (void)_createSelectView
{
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth / 5, 5)];
    _selectView.backgroundColor = [UIColor redColor];
    
    _selectColorView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth / 9 - 20) / 2 + kScreenWidth / 9, 65, 20, 20)];
    _selectColorView.image = [UIImage imageNamed:@"checkmark"];
    
    _selectWidthView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth / 7 - 20) / 2 + kScreenWidth * 3 / 7, 65, 20, 20)];
    _selectWidthView.image = [UIImage imageNamed:@"checkmark"];
    _selectWidthView.hidden = YES;
    
    [self addSubview:_selectView];
    [self addSubview:_selectColorView];
    [self addSubview:_selectWidthView];
}

//选择视图移动
- (void)_selectViewMovie:(UIButton *)button
{
    CGRect frame = _selectView.frame;
    frame.origin = CGPointMake(button.frame.origin.x, 40);
    [UIView animateWithDuration:0.4 animations:^{
        _selectView.frame = frame;
    }];
}

- (void)_selectColorViewMovie:(UIButton *)button
{
    CGRect frame = _selectColorView.frame;
    frame.origin = CGPointMake(button.frame.origin.x + (kScreenWidth / 9 - 20) / 2, 65);
    [UIView animateWithDuration:0.4 animations:^{
        _selectColorView.frame = frame;
    }];
}

- (void)_selectWidthViewMovie:(UIButton *)button
{
    CGRect frame = _selectWidthView.frame;
    frame.origin = CGPointMake(button.frame.origin.x + (kScreenWidth / 7 - 20) / 2, 65);
    [UIView animateWithDuration:0.4 animations:^{
        _selectWidthView.frame = frame;
    }];
}

//视图
- (void)_createView
{
    UIButton *colorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 5, 30)];
    [colorButton setTitle:@"颜色" forState:UIControlStateNormal];
    [colorButton addTarget:self action:@selector(colorAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:colorButton];
    
    UIButton *lineWidthButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 5, 0, kScreenWidth / 5, 30)];
    [lineWidthButton setTitle:@"线宽" forState:UIControlStateNormal];
    [lineWidthButton addTarget:self action:@selector(lineWidthAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lineWidthButton];
    
    UIButton *eraserButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * 2 / 5, 0, kScreenWidth / 5, 30)];
    [eraserButton setTitle:@"橡皮" forState:UIControlStateNormal];
    [eraserButton addTarget:self action:@selector(eraserAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:eraserButton];
    
    UIButton *revokeButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * 3 / 5, 0, kScreenWidth / 5, 30)];
    [revokeButton setTitle:@"撤销" forState:UIControlStateNormal];
    [revokeButton addTarget:self action:@selector(revokeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:revokeButton];
    
    UIButton *cleanButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * 4 / 5, 0, kScreenWidth / 5, 30)];
    [cleanButton setTitle:@"清屏" forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(cleanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cleanButton];
}

//颜色视图
- (void)_createColorView
{
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 50)];
    [self addSubview:_colorView];
    
    for (int i = 0; i < 9; i++) {
        UIButton *color = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 9 * i, 0, kScreenWidth / 9 - 5, 45)];
        color.tag = 100 + i;
        color.backgroundColor = _colorArray[i];
        
        [color addTarget:self action:@selector(setColorAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_colorView addSubview:color];
    }
}

//线宽视图
- (void)_createLineWidthView
{
    _lineWidthView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 50)];
    _lineWidthView.hidden = YES;
    [self addSubview:_lineWidthView];
    
    for (int i = 0; i < 7; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 7 * i + 10, (20 - [_lineWidthArray[i] floatValue]) / 2, kScreenWidth / 7 - 20, [_lineWidthArray[i] floatValue])];
        view.backgroundColor = [UIColor whiteColor];
        [_lineWidthView addSubview:view];
        
        UIButton *lineWidth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 7 * i, 0, kScreenWidth / 7, 50)];
        lineWidth.tag = 110 + i;
        [lineWidth setTitle:[NSString stringWithFormat:@"%@点",_lineWidthArray[i]] forState:UIControlStateNormal];
        
        [lineWidth addTarget:self action:@selector(setLineWidthAction:) forControlEvents:UIControlEventTouchUpInside];
        
        lineWidth.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
        
        [_lineWidthView addSubview:lineWidth];
        
    }
}

//颜色
- (void)colorAction:(UIButton *)button
{
    
    self.colorBlock(_lastColor);
    
    _colorView.hidden = NO;
    _lineWidthView.hidden = YES;
    _selectColorView.hidden = NO;
    _selectWidthView.hidden = YES;
    
    [self _selectViewMovie:button];
}

//线宽
- (void)lineWidthAction:(UIButton *)button
{
    
    
    _colorView.hidden = YES;
    _lineWidthView.hidden = NO;
    _selectColorView.hidden = YES;
    _selectWidthView.hidden = NO;
    
    [self _selectViewMovie:button];
    
}

//橡皮
- (void)eraserAction:(UIButton *)button
{
    self.colorBlock([UIColor whiteColor]);
    
    _colorView.hidden = YES;
    _lineWidthView.hidden = NO;
    _selectColorView.hidden = YES;
    _selectWidthView.hidden = NO;
    
    _lastColor = self.selectColor;
    
    [self _selectViewMovie:button];
}

//撤销
- (void)revokeAction:(UIButton *)button
{
    self.revokeBlock();
    
    [self _selectViewMovie:button];
}

//清屏
- (void)cleanAction:(UIButton *)button
{
    self.cleanBlock();
    
    [self _selectViewMovie:button];
}

//设置颜色
- (void)setColorAction:(UIButton *)button
{
    self.selectColor = button.backgroundColor;
    
    self.colorBlock(button.backgroundColor);
    
    _lastColor = self.selectColor;
    
    [self _selectColorViewMovie:button];;
}

//设置线宽
- (void)setLineWidthAction:(UIButton *)button
{
    self.selectWidth = _lineWidthArray[button.tag - 110];
    
    [self _selectWidthViewMovie:button];
    
    self.widthBlock(_lineWidthArray[button.tag - 110]);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
