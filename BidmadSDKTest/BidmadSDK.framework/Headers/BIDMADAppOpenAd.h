//
//  BIDMADRewardVideo.h
//  BidmadSDK
//
//  Created by 김선정 on 2018. 10. 29..
//  Copyright © 2018년 ADOP Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BIDMADUtil.h"
#import "BIDMADSetting.h"
#import "BIDMADFacebook.h"
#import "BIDMADAtomReward.h"
#import "BIDMADAdmob.h"
#import "BIDMADAdmanager.h"
#import "BIDMADUnityAds.h"
#import "BIDMADAppLoving.h"
#import "BIDMADInterstitial.h"
#import "BIDMADAdmobAppOpenAd.h"

@protocol BIDMADAppOpenAdDelegate;
@protocol BIDMADAppOpenAdInnerDelegate;

@interface BIDMADAppOpenAd : NSObject<BIDMADAppOpenAdInnerDelegate>

@property (nonatomic, strong) id<BIDMADAppOpenAdDelegate> delegate;
@property (nonatomic, strong) id<BIDMADAppOpenAdInnerDelegate> innerDelegate;
@property (nonatomic, strong) UIViewController*             parentViewController;
@property (strong, nonatomic) NSDictionary*                 ads_dic;
@property (nonatomic) BOOL isDirectLoad;
@property (nonatomic) NSString * zoneID;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic) BOOL                       isLabelService;
@property (nonatomic) BOOL                       isLabelServiceAdmin;
@property (nonatomic) BOOL                       testMode;
@property (nonatomic) BOOL                       isComplete;
@property (nonatomic) BOOL                       isLoaded;

- (id)      init;
- (void)    loadAppOpenAd;
- (void)    showAppOpenAd;
- (void)    selectAds:(NSDictionary *)lv_dic;
- (void)    sendLog :(NSDictionary *) info :(NSString *) advertisementType :(NSString *) logType;
- (void)    setTestDevice :(NSString *)deviceId;
- (void)    releaseBidmadResource;

@end

@protocol BIDMADAppOpenAdDelegate <NSObject>
@optional
- (void)BIDMADAppOpenAdLoad:(BIDMADAppOpenAd *)core       current:(NSDictionary*) currentDic;
- (void)BIDMADAppOpenPresentFail:(BIDMADAppOpenAd *)core code:(NSString *)error failType:(NSString*) failType current:(NSDictionary*)currentDic passbackStr:(NSString*) passBackStr passback:(NSDictionary*) passbackDic;
- (void)BIDMADAppOpenAdShow:(BIDMADAppOpenAd *)core       current:(NSDictionary*) currentDic;
- (void)BIDMADAppOpenAdClose:(BIDMADAppOpenAd *)core;
- (void)BIDMADAppOpenAdAllFail:(BIDMADAppOpenAd *)core;

@end

@protocol BIDMADAppOpenAdInnerDelegate <NSObject>
@required

- (void)onAppOpenAdLoad:(BIDMADAppOpenAd *) core current:(NSDictionary*) currentDic;
- (void)onAppOpenAdPresentFailed:(BIDMADAppOpenAd *) core code:(NSString *)error failType:(NSString*) failType current:(NSDictionary*)currentDic passbackStr:(NSString*) passBackStr passback:(NSDictionary*) passbackDic;
- (void)onAppOpenAdPresentSuccess:(BIDMADAppOpenAd *)core current:(NSDictionary*) currentDic;
- (void)onAppOpenAdClose:(BIDMADAppOpenAd *)core current:(NSDictionary*) currentDic;
- (void)onAppOpenAdSuccess:(BIDMADAppOpenAd *)core current:(NSDictionary*) currentDic;

@end



