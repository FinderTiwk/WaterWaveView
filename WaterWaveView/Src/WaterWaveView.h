//
//  WaterWaveView.h
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

#import <UIKit/UIKit.h>

@interface WaterWaveView : UIView

/*! 未填充时的图片名称*/
@property (nonatomic,assign) IBInspectable NSString *normalImageName;
/*! 填充满之后的图片名称*/
@property (nonatomic,assign) IBInspectable NSString *filledImageName;

/*! 水波正弦曲线振幅 default 3.0f*/
@property (nonatomic,assign) IBInspectable CGFloat amplitude;
/*! 波浪波动速度 default 0.2f*/
@property (nonatomic,assign) IBInspectable CGFloat fluctuationSpeed;

/*! 水波百分比  (0.00f ~ 1.00f)*/
@property (nonatomic,assign) CGFloat progress;
/*! 当progress发生变化时的回调*/
@property (nonatomic,copy) void (^progressDidChanged)(CGFloat progress);

/*! 开始动画*/
- (void)startAnimation;

@end
