//
//  BBAppDelegate.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBViewController;

@interface BBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BBViewController *viewController;

@end
