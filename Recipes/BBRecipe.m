//
//  BBRecipe.m
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBRecipe.h"

@implementation BBRecipe

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"New Recipe";
    }
    return self;
}

@end
