//
//  SegueInterimAdVIew.m
//  BidmadSDKTest
//
//  Created by ADOP_Mac on 2021/07/05.
//  Copyright © 2021 전혜연. All rights reserved.
//

#import "SegueInterimAdVIew.h"
#import <QuartzCore/QuartzCore.h>

@implementation SegueInterimAdVIew {
    NSNumber *autoAdCall;
    UILabel *defaultLabel;
    UILabel *secondsDisplay;
    UIButton *skipButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isAdReadyForDisplay = NO;
        autoAdCall = [[NSNumber alloc] initWithInt:0];
        [self uiSetting];
        
        [self performSelector:@selector(reflectEachSecond) withObject:nil afterDelay:1];
    }
    return self;
}

- (void)uiSetting {
    self.frame = CGRectMake(0, 0, 300, 150);
    self.backgroundColor = UIColor.whiteColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:10];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:path.CGPath];
    self.layer.mask = shape;
    
    [self.layer setShadowColor:UIColor.grayColor.CGColor];
    [self.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.layer setShadowOpacity:0.6];
    [self.layer setMasksToBounds:NO];
    [self setClipsToBounds: NO];
    [self.layer setShadowRadius:5];
    
    defaultLabel = [[UILabel alloc] init];
    [defaultLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [defaultLabel setText: @"Video Ad Starting In..."];
    [defaultLabel setMinimumScaleFactor:20];
    [defaultLabel setAdjustsFontSizeToFitWidth:YES];
    [self addSubview: defaultLabel];
    
    secondsDisplay = [[UILabel alloc] init];
    [secondsDisplay setTranslatesAutoresizingMaskIntoConstraints:NO];
    [secondsDisplay setFont: [UIFont systemFontOfSize:50]];
    [secondsDisplay setText: autoAdCall.stringValue];
    [secondsDisplay setTextAlignment:NSTextAlignmentCenter];
    [secondsDisplay setCenter: self.center];
    [self addSubview: secondsDisplay];
    
    skipButton = [[UIButton alloc] init];
    [skipButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [skipButton setTitle:@"SKIP AD" forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipAdClicked) forControlEvents:UIControlEventTouchUpInside];
    [skipButton setBackgroundColor:UIColor.systemBlueColor];
    [self addSubview: skipButton];
    
    [NSLayoutConstraint activateConstraints:
     @[
         [defaultLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
         [defaultLabel.topAnchor constraintEqualToAnchor: self.topAnchor],
         [defaultLabel.bottomAnchor constraintEqualToAnchor: secondsDisplay.topAnchor],
         [secondsDisplay.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
         [secondsDisplay.topAnchor constraintEqualToAnchor: defaultLabel.bottomAnchor],
         [secondsDisplay.bottomAnchor constraintEqualToAnchor: skipButton.topAnchor],
         [skipButton.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:0.5],
         [skipButton.topAnchor constraintEqualToAnchor:secondsDisplay.bottomAnchor],
         [skipButton.bottomAnchor constraintEqualToAnchor: self.bottomAnchor]
     ]];
}

- (void)skipAdClicked {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (self.adAvailableDelegate != nil) {
        [self.adAvailableDelegate adShowCancelled];
    }
    
    [self removeFromSuperview];
}

- (void)reflectEachSecond {
    autoAdCall = [[NSNumber alloc] initWithInt:[autoAdCall intValue] + 1];
    [self setNeedsDisplay];
    if (autoAdCall != [[NSNumber alloc] initWithInt:5]) {
        [self performSelector:@selector(reflectEachSecond) withObject:nil afterDelay:1];
    } else {
        self.isAdReadyForDisplay = YES;
        if (self.adAvailableDelegate != nil) {
            [self.adAvailableDelegate adAvailable];
        }
        [self removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect {
    [defaultLabel setText: @"Video Ad Starting In..."];
    [secondsDisplay setText: autoAdCall.stringValue];
    [skipButton setTitle:@"SKIP AD" forState:UIControlStateNormal];
}

@end
