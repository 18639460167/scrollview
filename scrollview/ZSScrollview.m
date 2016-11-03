//
//  ZSScrollview.m
//  scrollview
//
//  Created by tenpastnine-ios-dev on 16/9/27.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "ZSScrollview.h"
#define imageX 0
#define imageY 0
#define imageW  (self.frame.size.width﻿)

#define imageH  (self.frame.size.height﻿)
#define kImageCount self.imageArray.count﻿
#define kTimeChange 3.0f﻿

@interface ZSScrollview ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;//滚动时图
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) long currentIndex;
@property (nonatomic, assign) BOOL isTimeUp;

@end

@implementation ZSScrollview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.currentIndex=0;
        [self layoutScrollview];
        [self layoutImages];
        [self layoutPageCOntrol];
        [self layoutImageView];
        [self setImageByIndex:self.currentIndex];
    }
    return self;
}
/**
 *  自定义scrollview
 */
- (void)layoutScrollview
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(imageX, imageY,self.frame.size.width, self.frame.size.height)];
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*3, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate=self;
    self.scrollView.bounces=NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    
}
/**
 *  图片数组
 */

- (void)layoutImages
{
    self.imageArray = @[@"h0.jpg",@"h1.jpg",@"h2.jpg",@"h3.jpg",@"h4.jpg",@"h5.jpg",@"h6.jpg",@"h7.jpg"];
}

/**
 *  自定义pagecontroller
 */
- (void)layoutPageCOntrol
{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(imageX, imageY, self.frame.size.width, 30)];
    self.pageControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/10*9);
    self.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.enabled=NO;
    self.pageControl.numberOfPages = self.imageArray.count;
    [self addSubview:self.pageControl];
    
}
/**
 *  自定义imageview
 */
- (void)layoutImageView
{
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.leftImageView.backgroundColor = [UIColor orangeColor];
    [self.scrollView addSubview:self.leftImageView];
    
    self.centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self.scrollView addSubview:self.centerImageView];
    
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
    [self.scrollView addSubview:self.rightImageView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    _isTimeUp = NO;
    
}

/**
 *  刷新图片
 */
- (void)refreshImage
{
    if (self.scrollView.contentOffset.x>self.frame.size.width)
    {
        self.currentIndex = ((self.currentIndex+1)%self.imageArray.count);
    }
    else if (self.scrollView.contentOffset.x<self.frame.size.width)
    {
         self.currentIndex = ((self.currentIndex - 1 + self.imageArray.count) % self.imageArray.count);
    }
}

/**
 *  根据传回的下标设置三个imageview的图片
 *
 *  @param currentIndex 图片下标
 */
- (void)setImageByIndex:(long)currentIndex
{
    NSString *currentImageName =[NSString stringWithFormat:@"h%ld.jpg",currentIndex];
    NSLog(@"==%ld",currentIndex);
    self.centerImageView.image = [UIImage imageNamed:currentImageName];
    NSLog(@"当前页的名字是:%@",currentImageName);
    
    self.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"h%ld.jpg",((self.currentIndex - 1 + self.imageArray.count) % self.imageArray.count)]];
    NSLog(@"左边的图片名字是:%@",[NSString stringWithFormat:@"h%ld.jpg",
                          
                          ((self.currentIndex - 1 + self.imageArray.count)% self.imageArray.count)]);
    
    
    self.rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"h%ld.jpg",((self.currentIndex + 1) % self.imageArray.count)]];
    
    NSLog(@"右边的图片名字是:%@",[NSString stringWithFormat:@"h%ld.jpg",((self.currentIndex + 1) % self.imageArray.count)]);
    
    self.pageControl.currentPage = currentIndex;
    
}
- (void)timerAction
{
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
    _isTimeUp = YES;
//    
//    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:YES];
}


#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshImage];
    
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.pageControl.currentPage = self.currentIndex;
    
    // 手动控制图片滚动取消三秒定时器
    if (!_isTimeUp)
    {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    }
    _isTimeUp = NO;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.timer invalidate];
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [self layoutImages];
//}

@end
