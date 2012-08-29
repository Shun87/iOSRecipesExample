//
//  BBRecipesListViewController.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBRecipesListDataSource.h"

@interface BBRecipesListViewController : UITableViewController

@property (strong, nonatomic) id<BBRecipesListDataSource> dataSource;

- (void)finishedEditingRecipe:(BBRecipe *)recipe;

@end
