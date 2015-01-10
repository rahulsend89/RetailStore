//
//  Product.m
//  RetailStore
//
//  Created by Rahul Malik on 02/12/14.
//  Copyright (c) 2014 Rahul Malik. All rights reserved.
//

#import "Product.h"

@implementation Product
-(id)initWithProductWithDic:(NSDictionary*)dec{
if (![super init]) {
		return nil;
	}
    _name = [dec valueForKey:@"name"];
    _cat = [dec valueForKey:@"cat"];
    _cost = [NSNumber numberWithInt:[[dec valueForKey:@"cost"] intValue]];
    _img = [dec valueForKey:@"img"];
    _dec = [dec valueForKey:@"dec"];
    return self;
}
@end
