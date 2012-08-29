//
//  BBRecipesSource.m
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBRecipesSource.h"

@interface BBRecipesSource()
@property (strong, nonatomic) NSMutableArray *recipes;
@end

@implementation BBRecipesSource

- (NSInteger)recipeCount
{
    return [self.recipes count];
}

- (BBRecipe *)recipeAtIndex:(NSInteger)index
{
    return [self.recipes objectAtIndex:index];
}

- (void)deleteRecipeAtIndex:(NSInteger)index
{
    [self.recipes removeObjectAtIndex:index];
}

- (NSArray *)recipes
{
    if (nil == _recipes) {
    _recipes = [NSMutableArray array];
    
    for (int i = 0; i < 6; i++) {
        BBRecipe *recipe = [[BBRecipe alloc] init];
        recipe.directions = [NSString stringWithFormat:@"%d - Put some stuff in, and the other stuff, then stir.", i];
        recipe.title = [NSString stringWithFormat:@"%d - One Fine Food", i];
        recipe.image = [UIImage imageNamed:@"cookies.png"];
        [_recipes addObject:recipe];
    }
    
    NSString *directions = @"Put the flour and other dry ingredients in a bowl,\
    stir in the egs until evenly moust. Add chocolate chips and stir until event. \
    Place tablespoon-size portions on greased cookie sheet and bake at 350∘ for \
    6 minutes.";
    BBRecipe *recipe = [[BBRecipe alloc] init];
    recipe.title = @"Chocolate Chip Cookies";
    recipe.image = [UIImage imageNamed:@"cookies.png"];
    recipe.directions = directions;
    [_recipes addObject: recipe];
    }
    return _recipes;
}


@end
