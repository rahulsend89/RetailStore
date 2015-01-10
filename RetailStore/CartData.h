//
//  CartData.h
//  RetailStore
//
//  Created by Rahul Malik on 03/12/14.
//  Copyright (c) 2014 Rahul Malik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductData.h"
@interface CartData : ProductData
+(CartData *)sharedData;
@end
