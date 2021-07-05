//
//  RewardInterstitialViewController.m
//  BidmadSDKTest
//
//  Created by ADOP_Mac on 2021/07/05.
//  Copyright © 2021 전혜연. All rights reserved.
//

#import "RewardInterstitialViewController.h"

@interface RewardInterstitialViewController ()

@end

@implementation RewardInterstitialViewController {
    BIDMADRewardInterstitial *rewardInterstitial;
    SegueInterimAdVIew *adView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    rewardInterstitial = [[BIDMADRewardInterstitial alloc] init];
    rewardInterstitial.zoneID = @"5b2c91dd-fa33-454e-a482-c02e389bd3e8";
    rewardInterstitial.parentViewController = self;
    
    [rewardInterstitial requestRewardInterstitial];
    
    adView = [[SegueInterimAdVIew alloc] init];
    CGRect viewControllerBoundaries = [[self view] bounds];
    
    [adView setFrame:CGRectMake((viewControllerBoundaries.size.width - [adView frame].size.width) / 2,
                                (viewControllerBoundaries.size.height - [adView frame].size.height) / 2,
                                [adView frame].size.width,
                                [adView frame].size.height)];
    
    [[self view] addSubview:adView];
    [adView setAdAvailableDelegate: self];
}

- (void)adAvailable {
    NSLog(@"Ad is available");
    if (rewardInterstitial.isLoaded) {
        [rewardInterstitial showRewardInterstitialView];
    }
}

- (void)adShowCancelled {
    NSLog(@"User cancelled showing the ad");
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (IBAction)backButtonPressed:(id)sender {
    [adView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)requestRewardInterstitialAd {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
