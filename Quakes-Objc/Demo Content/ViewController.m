//
//  ViewController.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSILog.h"
#import "LSIFirstResponder.h"
#import "LSIQuakeFetcher.h"
#import "LSIQuake.h"
#import "NSDateInterval+LSIDayInterval.h"

// Class extension
@interface ViewController ()

@property (nonatomic) LSIQuakeFetcher *fetcher;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Hey Quakes!");
    
    // How do I create a first responder object?
    LSIFirstResponder *responder = [[LSIFirstResponder alloc] init];

    NSLog(@"responder: %@", responder);
    NSLog(@"name: %@", responder.name);
    
    // Objects will be nil / null
    // int / float / double / bool will be 0 (NO)
    
    responder.name = @"John";
    NSLog(@"name: %@", responder.name);
    
    // Blocks = closures (un-named function)

    // Swift
    //let addNumbers = { (a: Int, b: Int) -> Int in
    //    a + b
    //}
    //addNumbers(6, 3) // 9

    // int x =

    // returnType (^blockVariableName)(parameters) = ^returnType(parameters) {
    // };
    int (^addNumber)(int a, int b) = ^int(int a, int b) {
        return a + b;
    };

    int result = addNumber(27, 101);
    NSLog(@"result: %i", result);
    
    [self fetchPhotosWithCompletition:^(NSArray<NSString *> *photos) {
        NSLog(@"Update UI with new photo: %@", photos.firstObject);
    }];

    NSDateInterval *dateInterval = [NSDateInterval lsi_dateIntervalByAddingDays:-7]; // 3000 for 7 days vs. 300 ~1day
    [self.fetcher fetchQuakesInTimeInterval:dateInterval completionBlock:^(NSArray<LSIQuake *> * _Nullable quakes, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Quake Fetching Error: %@", error);
            return;
        }
        
        NSLog(@"Quakes: %ld", quakes.count);
        // TODO: print quakes, add to map, etc.
        
    }];
}

// Properties

// Lazy property
- (LSIQuakeFetcher *)fetcher {
    if (!_fetcher) {
        _fetcher = [[LSIQuakeFetcher alloc] init];
    }
    return _fetcher;
}

// Methods

- (void)fetchPhotosWithCompletition:(void (^)(NSArray<NSString *> *photos))completion {
    // network request ...
    completion(@[@"https://.../Photo.png"]);
}


@end
