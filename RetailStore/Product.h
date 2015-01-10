//
//  Product.h
//  RetailStore
//
//  Created by Rahul Malik on 02/12/14.
//  Copyright (c) 2014 Rahul Malik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property(readonly,strong)NSString*name;
@property(readonly,strong)NSString*cat;
@property(readonly,strong)NSString*img;
@property(readonly,strong)NSString*dec;
@property(readonly)NSNumber *cost;
-(id)initWithProductWithDic:(NSDictionary*)dec;
@end
