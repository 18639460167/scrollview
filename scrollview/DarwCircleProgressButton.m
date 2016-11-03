//
//  DarwCircleProgressButton.m
//  scrollview
//
//  Created by tenpastnine-ios-dev on 16/9/27.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "DarwCircleProgressButton.h"
#define degressToRadians(x) ((x)*M_PI / 180.0)

@interface DarwCircleProgressButton()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progresslayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, copy)   DrawCircleProgressBlock myBlock;
@end
@implementation DarwCircleProgressButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        CGFloat width = CGRectGetWidth(self.frame)/2.0f;
        CGFloat height = CGRectGetHeight(self.frame)/2.0f;
        CGPoint centerPoint = CGPointMake(width, height);
        float radius = CGRectGetWidth(self.frame)/2;
        
        _bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                     radius:radius
                                                     startAngle:degressToRadians(-90)endAngle:degressToRadians(270)
                                                  clockwise:YES];
    }
    return self;
}

- (CAShapeLayer *)trackLayer
{
    if (!_trackLayer)
    {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.bounds;
        _trackLayer.fillColor = self.fillcolor.CGColor? self.fillcolor.CGColor : [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.3].CGColor ;
         _trackLayer.lineWidth = self.lineWidth ? self.lineWidth : 2.f;
         _trackLayer.strokeColor = self.trakColor.CGColor ? self.trakColor.CGColor : [UIColor redColor].CGColor ;
        _trackLayer.strokeStart = 0.f;
        _trackLayer.strokeEnd = 1.f;
        _trackLayer.path = self.bezierPath.CGPath;
    }
    return _trackLayer;
}

- (CAShapeLayer *)progresslayer
{
    if (!_progresslayer)
    {
        _progresslayer = [CAShapeLayer layer];
        _progresslayer.frame = self.bounds;
        _progresslayer.fillColor = [UIColor clearColor].CGColor;
        _progresslayer.lineWidth = self.lineWidth ? self.lineWidth : 2.f;
        _progresslayer.lineCap = kCALineCapRound;
        _progresslayer.strokeColor = self.progressColor.CGColor ? self.progressColor.CGColor  : [UIColor grayColor].CGColor;
        _progresslayer.strokeStart = 0.f;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = self.animationDuration;
        pathAnimation.fromValue = @(0.0);
        pathAnimation.toValue = @(1.0);
        pathAnimation.removedOnCompletion = YES;
        pathAnimation.delegate = self;
        [_progresslayer addAnimation:pathAnimation forKey:nil];
        
        _progresslayer.path = _bezierPath.CGPath;
    }
    return _progresslayer;
}

#pragma mark -- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        self.myBlock();
    }
}
#pragma mark --
- (void)startAnimation:(CGFloat)duration withBlock:(DrawCircleProgressBlock)block
{
    self.myBlock= block;
    self.animationDuration= duration;
    [self.layer addSublayer:self.progresslayer];
}
@end
