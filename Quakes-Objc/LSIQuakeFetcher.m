//
//  LSIQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Paul Solt on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeFetcher.h"
#import "LSIErrors.h"
#import "LSIQuake.h"
#import "LSIQuakeResults.h"

static NSString *baseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";

@implementation LSIQuakeFetcher

// https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02

- (void)fetchQuakesInTimeInterval:(NSDateInterval *)interval
                  completionBlock:(LSIQuakeFetcherCompletion)completionBlock {
    
    NSLog(@"fetch");
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseURLString];
    
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSString *startTimeString = [formatter stringFromDate:interval.startDate];
    NSString *endTimeString = [formatter stringFromDate:interval.endDate];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"format" value:@"geojson"],
        [NSURLQueryItem queryItemWithName:@"starttime" value:startTimeString],
        [NSURLQueryItem queryItemWithName:@"endtime" value:endTimeString],
    ];
    
    NSURL *url = urlComponents.URL;
    // guard let
//    if (!url) {
//        return;
//    }
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"url: %@", url);
        
        if (error) {
            completionBlock(nil, error);
            return;
        }

        if (!data) {
            NSError *dataError = errorWithMessage(@"No earthquake data returned", LSIDataNilError);
            completionBlock(nil, dataError);
            return;
        }

        NSError *jsonError = nil; // no error has happened ... if it's not nil after call, there is an error
        // & = address of error
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completionBlock(nil, jsonError);
            return;
        }
        
        LSIQuakeResults *quakeResults = [[LSIQuakeResults alloc] initWithDictionary:dictionary];
        completionBlock(quakeResults.quakes, nil);
        
        
    }];
    
    [task resume];
}

@end
