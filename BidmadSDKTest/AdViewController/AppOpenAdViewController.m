//
//  AppOpenAdViewController.m
//  BidmadSDKTest
//
//  Created by ADOP_Mac on 2021/07/06.
//  Copyright © 2021 전혜연. All rights reserved.
//

#import "AppOpenAdViewController.h"
#import <BidmadSDK/BIDMADAppOpenAd.h>

@interface AppOpenAdViewController () <BIDMADAppOpenAdDelegate>
@property (weak, nonatomic) IBOutlet UILabel *callbackLabel;
@property (strong, nonatomic) BIDMADAppOpenAd *bidmadAppOpenAd;
@end

@implementation AppOpenAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bidmadAppOpenAd = [[BIDMADAppOpenAd alloc] init];
    self.bidmadAppOpenAd.zoneID = @"14fc71bd-5284-4e72-a201-9a5cf670cfa2";
    self.bidmadAppOpenAd.parentViewController = self;
    self.bidmadAppOpenAd.delegate = self;
}

- (IBAction)backButtonPressed:(id)sender {
    
}

- (IBAction)actionButtonPressed:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString: @"load"]) {
        [self.bidmadAppOpenAd loadAppOpenAd];
    } else if ([sender.titleLabel.text isEqualToString: @"show"]) {
        [self.bidmadAppOpenAd showAppOpenAd];
    }
}

- (void)BIDMADAppOpenAdClose:(BIDMADAppOpenAd *)core {
    NSLog(@"Callback → BIDMADAppOpenAdClose");
    [self.callbackLabel setText:@"Close"];
}

- (void)BIDMADAppOpenAdLoad:(BIDMADAppOpenAd *)core current:(NSDictionary *)currentDic {
    NSLog(@"Callback → BIDMADAppOpenAdLoad");
    [self.callbackLabel setText:@"Load"];
}

- (void)BIDMADAppOpenAdShow:(BIDMADAppOpenAd *)core current:(NSDictionary *)currentDic {
    NSLog(@"Callback → BIDMADAppOpenAdShow");
    [self.callbackLabel setText:@"Show"];
}

- (void)BIDMADAppOpenAdAllFail:(BIDMADAppOpenAd *)core {
    NSLog(@"Callback → BIDMADAppOpenAdAllFail");
    [self.callbackLabel setText:@"Fail"];
}

- (void)BIDMADAppOpenPresentFail:(BIDMADAppOpenAd *)core
                            code:(NSString *)error
                        failType:(NSString *)failType
                         current:(NSDictionary *)currentDic
                     passbackStr:(NSString *)passBackStr
                        passback:(NSDictionary *)passbackDic {
    NSLog(@"Callback → BIDMADAppOpenPresentFail");
    [self.callbackLabel setText:@"Could Not Present"];
}

@end
