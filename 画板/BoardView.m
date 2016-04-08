//
//  BoardView.m
//  画板
//
//  Created by 洪曦尘 on 15/12/24.
//  Copyright © 2015年 洪曦尘. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView

{
    CGPoint _currentP;
    CGMutablePathRef _path;
    NSMutableArray *_pathArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _pathArray = [[NSMutableArray alloc] init];
        _colorArray = [[NSMutableArray alloc] init];
        _color = [UIColor redColor];
        _widthArray = [[NSMutableArray alloc] init];
        _width = @8;
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef _context = UIGraphicsGetCurrentContext();
    
    [self _drawLines:_context];
}

- (void)_drawLines:(CGContextRef)context
{
    for (int i = 0; i < _pathArray.count; i++) {
        CGMutablePathRef path1 = (__bridge CGMutablePathRef)(_pathArray[i]);
        
        CGContextAddPath(context, path1);
        
        CGContextSetStrokeColorWithColor(context, ((UIColor *)_colorArray[i]).CGColor);
        CGContextSetLineWidth(context, [(NSNumber *)_widthArray[i] floatValue]);
        
        CGContextDrawPath(context, kCGPathStroke);
    }
    
//    CGPathMoveToPoint(_path, NULL, _oldP.x, _oldP.y);
    CGPathAddLineToPoint(_path, NULL, _currentP.x, _currentP.y);
    
    CGContextAddPath(context, _path);
    
    CGContextSetStrokeColorWithColor(context, _color.CGColor);
    CGContextSetLineWidth(context, [_width floatValue]);
    
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    _currentP = [touch locationInView:self];
    
    _path = CGPathCreateMutable();
    
    CGPathMoveToPoint(_path, NULL, _currentP.x, _currentP.y);
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    _context = UIGraphicsGetCurrentContext();
    UITouch *touch = [touches anyObject];
//    _oldP = _currentP;
    _currentP = [touch locationInView:self];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.colorArray addObject:_color];
    [self.widthArray addObject:_width];
    
    
    if (_path != nil) {
        [_pathArray addObject:(__bridge id _Nonnull)(_path)];
        CGPathRelease(_path);
        _path = nil;
    }
}

- (void)revoke
{
    [_pathArray removeLastObject];
    [_colorArray removeLastObject];
    [_widthArray removeLastObject];
    
    [self setNeedsDisplay];
}

- (void)clean
{
    [_pathArray removeAllObjects];
    [_colorArray removeAllObjects];
    [_widthArray removeAllObjects];
    
    [self setNeedsDisplay];
}

@end
