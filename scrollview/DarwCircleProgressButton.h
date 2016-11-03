//
//  DarwCircleProgressButton.h
//  scrollview
//
//  Created by tenpastnine-ios-dev on 16/9/27.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DrawCircleProgressBlock)(void);

@interface DarwCircleProgressButton : UIButton

@property (nonatomic, strong) UIColor *trakColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *fillcolor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat animationDuration;

- (void)startAnimation:(CGFloat)duration withBlock:(DrawCircleProgressBlock)block;

@end
