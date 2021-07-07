//
//  RewardInterstitialViewController.m
//  BidmadSDKTest
//
//  Created by ADOP_Mac on 2021/07/05.
//  Copyright © 2021 전혜연. All rights reserved.
//

#import "RewardInterstitialViewController.h"
@import GoogleMobileAds;

@interface RewardInterstitialViewController ()

@end

@implementation RewardInterstitialViewController {
    BIDMADRewardInterstitial *rewardInterstitial;
    SegueInterimAdVIew *adView;
    UIButton *reloadButton;
    UILabel *callbackLabelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"efef126bdf722af38e9142fe0869b4e7" ];
    
    [self setupRewardInterstitial];
    
    adView = [[SegueInterimAdVIew alloc] init];
    CGRect viewControllerBoundaries = [[self view] bounds];
    
    reloadButton = [[UIButton alloc] initWithFrame:CGRectMake((viewControllerBoundaries.size.width - 150) / 2,
                                                              (viewControllerBoundaries.size.height - 50) / 2,
                                                              150,
                                                              50)];
    [reloadButton setTitle:@"RELOAD AD" forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(reloadButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [reloadButton setBackgroundColor: UIColor.systemGreenColor];
    [reloadButton.layer setCornerRadius: 10];
    [reloadButton.layer setShadowRadius: 3];
    [reloadButton.layer setShadowColor: UIColor.grayColor.CGColor];
    [reloadButton.layer setShadowOpacity: 0.4];
    [reloadButton.layer setShadowOffset:CGSizeMake(0, 2)];
    [[self view] addSubview: reloadButton];
    
    [adView setFrame:CGRectMake((viewControllerBoundaries.size.width - [adView frame].size.width) / 2,
                                (viewControllerBoundaries.size.height - [adView frame].size.height) / 2,
                                [adView frame].size.width,
                                [adView frame].size.height)];
    [[self view] addSubview: adView];
    
    callbackLabelView = [[UILabel alloc] initWithFrame:CGRectMake((viewControllerBoundaries.size.width - 320) / 2,
                                                                  (viewControllerBoundaries.size.height - 100) / 4,
                                                                  320, 100)];
    [callbackLabelView setText: @"No Callback Yet"];
    [callbackLabelView setTextAlignment:NSTextAlignmentCenter];
    [[self view] addSubview: callbackLabelView];
    [adView setAdAvailableDelegate: self];
}

- (void)reloadButtonPressed {
    [self setupRewardInterstitial];
    
    CGRect viewControllerBoundaries = [[self view] bounds];
    adView = nil;
    adView = [[SegueInterimAdVIew alloc] init];
    [adView setFrame:CGRectMake((viewControllerBoundaries.size.width - [adView frame].size.width) / 2,
                                (viewControllerBoundaries.size.height - [adView frame].size.height) / 2,
                                [adView frame].size.width,
                                [adView frame].size.height)];
    [[self view] addSubview: adView];
    [adView setAdAvailableDelegate:self];
}

- (void)setupRewardInterstitial {
    rewardInterstitial = nil;
    rewardInterstitial = [[BIDMADRewardInterstitial alloc] init];
    rewardInterstitial.zoneID = @"5b2c91dd-fa33-454e-a482-c02e389bd3e8";
    rewardInterstitial.parentViewController = self;
    rewardInterstitial.delegate = self;
    [rewardInterstitial requestRewardInterstitial];
}

- (void)adAvailable {
    NSLog(@"Ad is available");
    if (rewardInterstitial.isLoaded) {
        [rewardInterstitial showRewardInterstitialView];
    }
}

- (void)adShowCancelled {
    NSLog(@"User cancelled showing the ad");
    [rewardInterstitial removeRewardInterstitialAds];
    rewardInterstitial = nil;
    adView = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isBeingDismissed) {
        [self removeAll];
    }
}

- (void)dealloc {
    [self removeAll];
}

- (void)removeAll {
    if (rewardInterstitial != nil) {
        NSLog(@"Removing Reward Interstitial Ads");
        [rewardInterstitial removeRewardInterstitialAds];
        rewardInterstitial = nil;
    }
    
    if (adView != nil) {
        adView = nil;
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [adView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)BIDMADRewardInterstitialLoad:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"Load"];
    NSLog(@"BIDMADRewardInterstitialLoad");
}

- (void)BIDMADRewardInterstitialShow:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"Show"];
    NSLog(@"BIDMADRewardInterstitialShow");
}

- (void)BIDMADRewardInterstitialClick:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"Click"];
    NSLog(@"BIDMADRewardInterstitialClick");
}

- (void)BIDMADRewardInterstitialClose:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"Close"];
    NSLog(@"BIDMADRewardInterstitialClose");
}

- (void)BIDMADRewardInterstitialSkipped:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"Skipped"];
    NSLog(@"BIDMADRewardInterstitialSkipped");
}

- (void)BIDMADRewardInterstitialSuccess:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"Success"];
    NSLog(@"BIDMADRewardInterstitialSuccess");
}

- (void)BIDMADRewardInterstitialComplete:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"Complete"];
    NSLog(@"BIDMADRewardInterstitialComplete");
}

- (void)BIDMADRewardInterstitialAllFail:(BIDMADRewardInterstitial *)core {
    [callbackLabelView setText: @"AllFail"];
    NSLog(@"BIDMADRewardInterstitialAllFail");
}

@end
