//
//  BBRecipeEditorViewController.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBRecipe;
@class BBRecipesListViewController;

@interface BBRecipeEditorViewController : UIViewController

@property (strong, nonatomic) BBRecipe *recipe;
@property (weak, nonatomic) BBRecipesListViewController *recipeListVC;
@end
