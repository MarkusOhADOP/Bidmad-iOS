//
//  OpenBiddingUtility.h
//  divination
//
//  Created by ADOP_Mac on 2021/06/24.
//  Copyright © 2021 Handasoft Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenBiddingUtility : NSObject

+ (NSURLSessionDataTask *)openBiddingDataFetcherWithZoneId: (NSString *)zoneId completionBlock:(void (^)(NSDictionary *, NSError *, NSDictionary *, NSString *, NSString *))completionBlock;
+ (void) sendLogOBH :(NSDictionary *)info :(NSString *)advertisementType :(NSString *)logType :(NSString*)sessionId :(NSString*)realZoneId;

@end

NS_ASSUME_NONNULL_END
