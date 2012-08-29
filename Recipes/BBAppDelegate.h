//
//  BBAppDelegate.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBRecipesListViewController;

@interface BBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BBRecipesListViewController *viewController;
@property (copy, nonatomic) NSArray *recipes;

@end
