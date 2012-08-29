//
//  BBViewController.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBRecipe;

@interface BBViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *recipeTitle;
@property (strong, nonatomic) BBRecipe *recipe;
@property (weak, nonatomic) IBOutlet UITextView *directionsView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
