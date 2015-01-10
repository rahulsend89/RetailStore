//
//  MasterViewController.h
//  RetailStore
//
//  Created by Rahul Malik on 02/12/14.
//  Copyright (c) 2014 Rahul Malik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductData.h"
#import "ProductData.h"
#import "CartData.h"
@interface ProductViewController : UITableViewController
@property(readwrite)BOOL isCustomCell;
-(void)initView;
-(ProductData * )getFetchedResultsController;
-(NSString*)getCostFormatWithNum:(int)aNum;
@end

