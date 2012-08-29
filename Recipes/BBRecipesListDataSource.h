//
//  BBRecipesListDataSource.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBRecipe.h"

@protocol BBRecipesListDataSource <NSObject>

- (NSInteger)recipeCount;
- (BBRecipe *)recipeAtIndex:(NSInteger)index;
- (void)deleteRecipeAtIndex:(NSInteger)index;

@end
