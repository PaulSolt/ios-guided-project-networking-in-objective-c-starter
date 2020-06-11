//
//  NSDateInterval+LSIDayInterval.h
//  Quakes-Objc
//
//  Created by Paul Solt on 6/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateInterval (LSIDayInterval)

// NOTE: if we don't own the class, we need to use a prefix (lowercase_)
// future proof our code, since Apple may add this API in the future causing a future bug in 2021

// You don't need the prefix if you own the class source

+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days;
+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
