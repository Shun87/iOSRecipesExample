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

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _directions = [aDecoder decodeObjectForKey:@"directions"];
        _preparationTime = [aDecoder decodeObjectForKey:@"preparationTime"];
        _image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.directions forKey:@"directions"];
    [aCoder encodeObject:self.preparationTime forKey:@"preparationTime"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

@end
