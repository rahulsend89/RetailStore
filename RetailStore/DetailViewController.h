//
//  DetailViewController.h
//  RetailStore
//
//  Created by Rahul Malik on 02/12/14.
//  Copyright (c) 2014 Rahul Malik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Product *detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *currentImage;
@property (weak, nonatomic) IBOutlet UILabel *currentCost;
@property (weak, nonatomic) IBOutlet UILabel *currentName;
@property (weak, nonatomic) IBOutlet UITextView *currentDec;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;

@end

