//
//  NSDateInterval+LSIDayInterval.m
//  Quakes-Objc
//
//  Created by Paul Solt on 6/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "NSDateInterval+LSIDayInterval.h"

@implementation NSDateInterval (LSIDayInterval)

// DRY: don't repeat yourself - Pragmatic Programmer - book
+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days
{
    return [self lsi_dateIntervalByAddingDays:days toDate:[NSDate date]]; // now +/- days
}

+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date
{
    NSDate *startDate = nil;
    NSDate *endDate = nil;
    
    if (days < 0) { // going into past
        endDate = date;
        startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:date options:0];
    } else { // going into future
        startDate = date;
        endDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:date options:0];
    }
    return [[NSDateInterval alloc] initWithStartDate:startDate endDate: endDate];
}

@end
