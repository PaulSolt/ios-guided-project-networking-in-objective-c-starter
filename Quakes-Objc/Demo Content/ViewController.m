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
#import "LSIQuake.h"
#import "LSIQuakeFetcher.h"
#import "NSDateInterval+LSIDayInterval.h"

@interface ViewController ()

@property (nonatomic) LSIQuakeFetcher *quakeFetcher;

@end

@implementation ViewController

// Lazy property
- (LSIQuakeFetcher *)quakeFetcher {
    if (_quakeFetcher == nil) {
        _quakeFetcher = [[LSIQuakeFetcher alloc] init];
    }
    return _quakeFetcher;
}

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
    
    
    
    // Blocks

    // Swift
    //    let addNumbers: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in {
    //        a + b
    //    }
    //    addNumbers(6, 3) // return 9

    // returnType (^blockName)(parameterList) = ^returnType(parameterList) {
    //      return someExpressionUsingParameters;
    // };

    int (^addNumbers)(int a, int b) = ^int(int a, int b) {
        NSLog(@"adding numbers %d + %d", a, b);
        return a + b;
    };

    int result = addNumbers(5, 20);
    NSLog(@"The sum is %d", result);
    
    
    [self doWorkAndCallCompletition:^(int temperature) {
        NSLog(@"The weather is %dºF in Rochester, NY", temperature);
        
        // add more code here ...
    }];
    
    // Swift Extension = Objective-C Category
    
    NSDateInterval *lastWeek = [NSDateInterval lsi_dateIntervalByAddingDays:-7];
    [self.quakeFetcher fetchQuakesInTimeInterval:lastWeek completion:^(NSArray<LSIQuake *> * _Nullable quakes, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching quakes: \(error)");
        }
        
        NSLog(@"There are %d earthquakes!", quakes.count);
    }];
}

- (void)doWorkAndCallCompletition:(void (^)(int temperature))completion {
    NSLog(@"Do some work ...");
    
    completion(72);
}


@end
