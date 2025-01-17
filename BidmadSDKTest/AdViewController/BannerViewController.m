//
//  BannerViewController.m
//  AdopSDKTest
//
//  Created by 김선정 on 2017. 9. 13..
//  Copyright © 2017년 김선정. All rights reserved.
//

#import "BannerViewController.h"
//#import <AdFitSDK/AdFitSDK.h>
@import OpenBiddingHelper;
@import BidmadSDK;

@interface BannerViewController () <BIDMADBannerDelegate> {
    BIDMADBanner* banner;
    NSString *zoneId;
}

@end

@implementation BannerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /*
        1. 테스트 기기 등록하기
          GoogleAdmob의 경우, 실 코드로 테스트를 자주할 경우 계정이 정지될 수 있기 때문에 실기기에서 테스트를 진행할 경우, 반드시 테스트 기기를 등록하여 테스트를 하시고,
          실제 앱이 릴리즈 단계에서는 테스트기기 등록 코드 (아래참조)를 삭제 처리 해주셔야 합니다.
          아래 문자열을 얻는 방법은, 일단 [banner setTestDevice:@"xxxxxx"]; 함수를 삭제하고 아래코드들을 실행한 한 후,하단 Log창에서
          "GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers"를 검색하여 찾은후
          GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"xxxxxx" ] 문구의, xxxxxx(애드몹에서 인식하는 사용자의 폰 ID)  스트링을 복사하여 그대로 setTestDevice 함수의 파라미터로 넣어주시면 됩니다.이때, Simulator에서 실행시에는 kGADSimulatorID를 넣어주시면 됩니다.(아래 코드 참조)
     */
    
    
//    [[BIDMADSetting sharedInstance] setTestDeviceId:@"YOUR_TEST_DEVICE_ID"];
    
    [BIDMADSetting sharedInstance].isDebug = YES;
    [[BIDMADSetting sharedInstance] setTestDeviceId:@"efef126bdf722af38e9142fe0869b4e7"];
//    banner = [[OpenBiddingBanner alloc] initWithParentViewController:self rootView:self.BannerContainer];
    banner = [[BIDMADBanner alloc] initWithParentViewController:self rootView:self.BannerContainer];
//    banner = [[OpenBiddingBanner alloc] initWithParentViewController:self adsPosition:CGPointMake(0, 20)];
//    banner = [[OpenBiddingBanner alloc] initWithParentViewController:self yPoint:20];
    [banner setZoneID:@"ffb30f2a-f85f-4994-9540-62735ca6534e"];
//    [banner setZoneID:@"6e688caf-321c-455b-87ad-736ad91e6d84"];
    [banner setDelegate:self];
    [banner setRefreshInterval:60];
}

- (IBAction)loadBanner:(id)sender {
    [banner requestBannerView];
}

#pragma mark Banner Deleagate
- (void)BIDMADBannerAllFail:(BIDMADBanner *)core {
    self.bannerCallbackDisplay.text = @"BIDMADBannerAllFail";
    NSLog(@"APPUI BIDMADBannerAllFail");
}

- (void)BIDMADBannerLoad:(BIDMADBanner *)core {
    self.bannerCallbackDisplay.text = @"BIDMADBannerClosed";
}

- (void)BIDMADBannerClick:(BIDMADBanner *)core {
    self.bannerCallbackDisplay.text = @"BIDMADBannerLoad";
    NSLog(@"APPUI BIDMADBannerLoad");
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [banner removeAds];
//    });
}



- (IBAction)backBtn:(id)sender {
    NSLog(@"Back Button Pressed");
    
    [banner removeAds];     //광고 삭제
    [self dismissViewControllerAnimated:YES completion:^{
        // DO NOTHING;
    }];
}
@end
