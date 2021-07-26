//
//  RewardViewController.m
//  BidmadSDKTest
//  Created by hyjeon on 2019. 12. 25
//  Copyright © 2019년 전혜연. All rights reserved.
//

#import "RewardViewController.h"
#import <OpenBiddingHelper/OpenBiddingRewardVideo.h>
@import FacebookAdapter;

@interface RewardViewController () <BIDMADOpenBiddingRewardVideoDelegate>
{

    NSInteger entry;
    
    UILabel *startLabel;
    UILabel *label1;
    UILabel *label2;
    UILabel * timeLabel;
    
    NSString * startLog;
    NSString * errorLog;
    NSString * successLog;
    NSString * timeLog;
}

@property OpenBiddingRewardVideo* reward;
@end

@implementation RewardViewController

- (void)viewDidLoad {
    
  [super viewDidLoad];
    
  /*
      1. 테스트 기기 등록하기
        GoogleAdmob의 경우, 실 코드로 테스트를 자주할 경우 계정이 정지될 수 있기 때문에 실기기에서 테스트를 진행할 경우, 반드시 테스트 기기를 등록하여 테스트를 하시고,
        실제 앱이 릴리즈 단계에서는 테스트기기 등록 코드 (아래참조)를 삭제 처리 해주셔야 합니다.
        아래 문자열을 얻는 방법은, 일단 [rewardVideo1 setTestDevice:@"xxxxxx"]; 함수를 삭제하고 아래코드들을 실행한 한 후,하단 Log창에서
        "GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers"를 검색하여 찾은후
        GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"xxxxxx" ] 문구의, xxxxxx(애드몹에서 인식하는 사용자의 폰 ID)  스트링을 복사하여 그대로 setTestDevice 함수의 파라미터로 넣어주시면 됩니다.이때, Simulator에서 실행시에는 kGADSimulatorID를 넣어주시면 됩니다.(아래 코드 참조)
    
      2. loadRewardVideo를 보통 ViewController(가령, 리워드 광고 상품이 있는 화면 ) 진입할 때 해주고, 실제로 RewardVideo를 보여줘야하는 상황에서 실제로 showRewardVideo를 호출해줍니다.
      3. 2번에서, 반드시 아래의 BIDMADRewardVideoLoad 콜백함수가 호출된 상태여야, load가 완료된 것이니, 콜백에 주의하여 load 콜백의 상태를 파악하여 showRewardVideo를 해주셔야 합니다.
      4. 한번 광고를 시청하고나면,첫번째 광고를 다 보고 난 후 Close 버튼을 통해서 아래의 BIDMADRewardVideoClose 콜백함수가 불리게 됩니다. 이때, 미리 다음 광고영상을 loadRewardVideo를 통해서 미리 로드하길 권장합니다.
   */
    
//    [[BIDMADSetting sharedInstance] setTestDeviceId:@"YOUR_TEST_DEVICE_ID"];
    
    [FBAdSettings addTestDevice:@"073ae9596656231a5a8dafbc8f47bd548769ef87"];
    
    self.reward = [[OpenBiddingRewardVideo alloc]init];
    [[BIDMADSetting sharedInstance]setIsDebug:YES];
    [self.reward setZoneID:@"c28c280e-77e7-4f08-9e06-5e729432362c"];//테스트 존아이디입니다. 프로젝트 적용시 그대로 사용하시면 안됩니다.
    [self.reward setParentViewController:self];
    [self.reward setDelegate:self];
    
    NSLog(@" deviceId: %@", [BIDMADUtil identifierForAdvertising]);
  
}

-(IBAction)loadReward:(UIButton*)sender{
    [self.reward loadRewardVideo];
   
}

-(IBAction)showReward:(UIButton*)sender{
    if([self.reward isLoaded]){
        [self.reward showRewardVideo];
    }
}
- (IBAction)backBtnPressed:(id)sender {
    NSLog(@"Back Button Pressed");
    
    if (self.reward != nil) {
//        [self.reward removeRewardADS];
        self.reward = nil;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        // DO NOTHING;
    }];
}

#pragma mark Reward Delegate
- (void)BIDMADOpenBiddingRewardVideoLoad:(OpenBiddingRewardVideo *)core {
    self.rewardCallbackDisplay.text = @"OpenBiddingRewardVideoLoad";
}
- (void)BIDMADOpenBiddingRewardVideoAllFail:(OpenBiddingRewardVideo *)core {
    self.rewardCallbackDisplay.text = @"OpenBiddingRewardVideoAllFail";
}
- (void)BIDMADOpenBiddingRewardVideoShow:(OpenBiddingRewardVideo *)core {
    self.rewardCallbackDisplay.text = @"OpenBiddingRewardVideoShow";
    NSLog(@"OpenBiddingRewardVideoShow Reload");
    
    self.reward = [[OpenBiddingRewardVideo alloc]init];
    [self.reward setZoneID:core.zoneID];//테스트 존아이디입니다. 프로젝트 적용시 그대로 사용하시면 안됩니다.
    [self.reward setParentViewController:self];
    [self.reward setDelegate:self];
    [self.reward loadRewardVideo];
}
- (void)BIDMADOpenBiddingRewardSkipped:(OpenBiddingRewardVideo *)core {
    self.rewardCallbackDisplay.text = @"BIDMADRewardSkipped";
}

- (void)BIDMADOpenBiddingRewardVideoClose:(OpenBiddingRewardVideo *)core {
    self.rewardCallbackDisplay.text = @"OpenBiddingRewardVideoClose";
    NSLog(@"OpenBiddingRewardVideoClose");
}
- (void)BIDMADOpenBiddingRewardVideoSucceed:(OpenBiddingRewardVideo *)core {
    self.rewardCallbackDisplay.text = @"OpenBiddingRewardVideoSucceed";
    NSLog(@"OpenBiddingRewardVideoSucceed");
}

@end
