//
//  NSDateInterval+LSIDayInterval.m
//  Quakes-Objc
//
//  Created by Paul Solt on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "NSDateInterval+LSIDayInterval.h"

@implementation NSDateInterval (LSIDayInterval)

+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days {
    return [self lsi_dateIntervalByAddingDays:days toDate:[NSDate date]];
}

+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date {
    NSDate *endDate = nil;
    NSDate *startDate = nil;
    if (days < 0) {
        endDate = date;
        startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:date options:0];
    } else { // days >= 0
        startDate = date;
        endDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:date options:0];
    }
    return [[NSDateInterval alloc] initWithStartDate:startDate endDate:endDate];
}

@end
