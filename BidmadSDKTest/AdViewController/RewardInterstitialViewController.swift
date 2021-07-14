//
//  RewardInterstitialViewController.swift
//  BidmadSDKTest
//
//  Created by ADOP_Mac on 2021/07/14.
//  Copyright © 2021 전혜연. All rights reserved.
//

import UIKit
import BidmadSDK

@objc
class RewardInterstitialViewControllerSwift: UIViewController {
    var rewardInterstititial: BIDMADRewardInterstitial!
    var appOpen: BIDMADAppOpenAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appOpen = BIDMADAppOpenAd()
        appOpen.zoneID = "8895ec21-d6b2-42d5-a2ad-1eb17e3e8f9c"
        appOpen.delegate = self
        appOpen.request()
        
        appOpen.delegate = self
        appOpen.registerForAppOpenAd(forZoneID: "8895ec21-d6b2-42d5-a2ad-1eb17e3e8f9c")
        appOpen.deregisterForAppOpenAd()
        
        rewardInterstititial = BIDMADRewardInterstitial()
        rewardInterstititial.zoneID = "1bb1963e-6a9b-46c9-a7e1-74a8d4066aea"
        rewardInterstititial.parentViewController = self
        rewardInterstititial.delegate = self
        rewardInterstititial.request()
    }
    
    func adShow() {
        if (rewardInterstititial.isLoaded) {
            rewardInterstititial.showView()
        }
    }
    
    func removeAd() {
        rewardInterstititial.removeAds()
        rewardInterstititial = nil
    }
}

extension RewardInterstitialViewControllerSwift: BIDMADRewardInterstitialDelegate {
    func bidmadRewardInterstitialLoad(_ core: BIDMADRewardInterstitial!) {
        print("bidmadRewardInterstitialLoad")
        self.adShow()
    }
    func bidmadRewardInterstitialShow(_ core: BIDMADRewardInterstitial!) {
        print("bidmadRewardInterstitialShow")
    }
    func bidmadRewardInterstitialClose(_ core: BIDMADRewardInterstitial!) {
        print("bidmadRewardInterstitialClose")
    }
    func bidmadRewardInterstitialSkipped(_ core: BIDMADRewardInterstitial!) {
        print("bidmadRewardInterstitialSkipped")
    }
    func bidmadRewardInterstitialSuccess(_ core: BIDMADRewardInterstitial!) {
        print("bidmadRewardInterstitialSuccess")
    }
    func bidmadRewardInterstitialAllFail(_ core: BIDMADRewardInterstitial!) {
        print("bidmadRewardInterstitialAllFail")
    }
}

extension RewardInterstitialViewControllerSwift: BIDMADAppOpenAdDelegate {
    func bidmadAppOpenAdLoad(_ core: BIDMADAppOpenAd!) {
        print("bidmadAppOpenAdLoad")
    }
    
    func bidmadAppOpenAdShow(_ core: BIDMADAppOpenAd!) {
        print("bidmadAppOpenAdShow")
    }
    
    func bidmadAppOpenAdClose(_ core: BIDMADAppOpenAd!) {
        print("bidmadAppOpenAdClose")
    }
    
    func bidmadAppOpenAdAllFail(_ core: BIDMADAppOpenAd!, code error: String!) {
        print("bidmadAppOpenAdAllFail")
    }
}
