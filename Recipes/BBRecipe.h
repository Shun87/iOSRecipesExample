//
//  BBRecipe.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBRecipe : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *directions;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSNumber *preparationTime;

@end
