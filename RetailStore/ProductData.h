//
//  ProductData.h
//  RetailStore
//
//  Created by Rahul Malik on 02/12/14.
//  Copyright (c) 2014 Rahul Malik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
@interface ProductData : NSObject<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(readwrite,nonatomic)NSString *entityName;
@property(readonly,strong)NSDictionary*tampData;
@property(readwrite,strong,nonatomic)UITableView *tableView;
+(ProductData *)sharedData;
-(void)setDataReload:(UITableView*) tableView :(void (^)())handler;
- (void)addProduct:(Product *)product;
-(int)calCulateTotal;
@end
