//
//  NSDateInterval+LSIDayInterval.h
//  Quakes-Objc
//
//  Created by Paul Solt on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// We can extend classes that we don't have original source access for

NS_ASSUME_NONNULL_BEGIN

@interface NSDateInterval (LSIDayInterval)

// + = class method

// if you don't own the class, you need to use a prefix lsi_ so that you don't
// have a bug where the system randomly choices an implementation

/// Creates a date interval relative to the current date
+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days;


+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
