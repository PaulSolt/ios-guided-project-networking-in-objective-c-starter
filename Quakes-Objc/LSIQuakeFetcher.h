//
//  LSIQuakeFetcher.h
//  Quakes-Objc
//
//  Created by Paul Solt on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// Swift
// typealias StudentName = String

// Forward class declaration
@class LSIQuake;

NS_ASSUME_NONNULL_BEGIN

@interface LSIQuakeFetcher : NSObject

- (void)fetchQuakesInTimeInterval:(NSDateInterval *)interval
                  completionBlock:(void (^)(NSArray<LSIQuake *> *quakes, NSError *error))completionBlock;

@end

NS_ASSUME_NONNULL_END
