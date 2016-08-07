//
//  WaterWaveView.m
//  WaterWaveView
//
//  _____  _           _          _____ _          _
//  |  ___(_)_ __   __| | ___ _ _|_   _(_)_      _| | __
//  | |_  | | '_ \ / _` |/ _ \ '__|| | | \ \ /\ / / |/ /
//  |  _| | | | | | (_| |  __/ |   | | | |\ V  V /|   <
//  |_|   |_|_| |_|\__,_|\___|_|   |_| |_| \_/\_/ |_|\_\
//
//  Created by _Finder丶Tiwk on 16/8/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "WaterWaveView.h"

@interface WaterWaveView ()

/*! 水波深度为0%时的ImageView*/
@property (nonatomic,strong) UIImageView *backgroundImageView;
/*! 水波深度为100%时的ImageView*/
@property (nonatomic,strong) UIImageView *foregroundImageView;
/*! 动画定时器*/
@property (nonatomic,strong) CADisplayLink *displayLink;

@end

@implementation WaterWaveView{
    CGFloat __curvature;
}

#pragma mark - Setter & Getter
- (void)setNormalImageName:(NSString *)normalImageName{
    NSCParameterAssert(normalImageName);
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.image = [UIImage imageNamed:normalImageName];
    [self addSubview:_backgroundImageView];
}

- (void)setFilledImageName:(NSString *)filledImageName{
    NSCParameterAssert(filledImageName);
    _foregroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _foregroundImageView.layer.mask = [CAShapeLayer layer];
    _foregroundImageView.image = [UIImage imageNamed:filledImageName];
    [self insertSubview:_foregroundImageView aboveSubview:_backgroundImageView];
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (progress >= 1.0f) {
        _progress = 1.0f;
    }
    if (self.progressDidChanged) {
        self.progressDidChanged(_progress);
    }
}

- (void)startAnimation{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)dealloc{
    [_displayLink invalidate];
    [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _displayLink = nil;
}

- (void)waveAnimation{
    
    @synchronized (self) {
        __curvature += (_fluctuationSpeed > 0?_fluctuationSpeed:0.2);
        // 这里做一个修正，防止__curvature无限增长导致溢出
        if (__curvature > 60.f) {
            __curvature = 0.f;
        }
        
        CGFloat width  = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        // 1.绘制波浪曲线路径
        UIBezierPath * path = [[UIBezierPath alloc] init];
        path.lineWidth = 1;
        
        CGFloat  waterDepth = (1 - _progress) * height;
        CGFloat curveY = waterDepth;
        
        [path moveToPoint:CGPointMake(0, curveY)];
        for (CGFloat x = 0; x <= self.frame.size.width; x++) {
            double radius = (x/180 *M_PI + __curvature/M_PI);
            curveY = (_amplitude>0?_amplitude:3.f)*sin(radius) + waterDepth;
            [path addLineToPoint:CGPointMake(x, curveY)];
        }
        [path addLineToPoint:CGPointMake(width, waterDepth)];
        [path addLineToPoint:CGPointMake(width, height)];
        [path addLineToPoint:CGPointMake(0, height)];
        [path closePath];
        
        // 2.为填充满的图片视图添加遮罩
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = path.CGPath;
        _foregroundImageView.layer.mask = maskLayer;
    }
}


@end
