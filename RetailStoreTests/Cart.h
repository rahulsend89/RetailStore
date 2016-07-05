//
//  RetailStoreTests.m
//  RetailStoreTests
//
//  Created by Rahul Malik on 06/07/16.
//  Copyright © 2016 Rahul Malik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cart : NSManagedObject

@property (nonatomic) int16_t cost;
@property (nonatomic, retain) NSString * dec;
@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timeStamp;

@end
