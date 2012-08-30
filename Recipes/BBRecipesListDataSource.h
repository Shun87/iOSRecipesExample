//
//  BBRecipesListDataSource.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBRecipe.h"

extern NSString * const BBRecipesDidChangeNotification;

@protocol BBRecipesListDataSource <NSObject>

- (NSInteger)recipeCount;
- (BBRecipe *)recipeAtIndex:(NSInteger)index;
- (void)deleteRecipeAtIndex:(NSInteger)index;
- (BBRecipe *)createNewRecipe;
- (NSUInteger)indexOfRecipe:(BBRecipe *)recipe;
- (void)recipesChanged;
- (NSData *)dataForRecipes:(NSError **)error;

@end
