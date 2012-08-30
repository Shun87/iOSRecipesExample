//
//  BBRecipeEditorDelegate.h
//  Recipes
//
//  Created by Martin Volerich on 8/30/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBRecipe;

@protocol BBRecipeEditorDelegate <NSObject>

- (void) finishedEditingRecipe:(BBRecipe *)recipe;
- (void) recipeChanged:(BBRecipe *)recipe;

@end
