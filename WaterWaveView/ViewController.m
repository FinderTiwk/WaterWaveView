//
//  ViewController.m
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

#import "ViewController.h"

#import "WaterWaveView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@property (weak, nonatomic) IBOutlet UILabel *amplitudeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *deltaCurvatureValueLabel;

@property (weak, nonatomic) IBOutlet WaterWaveView *waterWaveView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //code setting
//    {
//        _waterWaveView.normalImageName = @"normal";
//        _waterWaveView.filledImageName = @"filled";
//        _waterWaveView.progress = 0.5;
//        _waterWaveView.amplitude = 3;
//        _waterWaveView.fluctuationSpeed = 0.3;
//    }
    
    __weak typeof(self) weakRef = self;
    [_waterWaveView setProgressDidChanged:^(CGFloat progress) {
        __strong typeof(weakRef) strongRef = weakRef;
        strongRef.progressSlider.value = progress;
        strongRef.progressValueLabel.text = [NSString stringWithFormat:@"%.2f",progress];
        strongRef.progressLabel.text = [NSString stringWithFormat:@"%.2f%%",progress*100];
    }];
}

#pragma mark - IBAction
- (IBAction)beginAnimation:(UIButton *)sender {
    [_waterWaveView startAnimation];
    // 模拟下载进度
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(download) userInfo:nil repeats:YES];
}

- (void)download{
    _waterWaveView.progress += ((double)arc4random() / (0x100000000*10))+ 0.01;
}

- (IBAction)amplitudeChanged:(UISlider *)sender {
    _waterWaveView.amplitude = sender.value;
    _amplitudeValueLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
}

- (IBAction)progessChanged:(UISlider *)sender {
    _waterWaveView.progress = sender.value;
    _progressValueLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
}

- (IBAction)speedChanged:(UISlider *)sender {
    _waterWaveView.fluctuationSpeed = sender.value;
    _deltaCurvatureValueLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
}

@end
