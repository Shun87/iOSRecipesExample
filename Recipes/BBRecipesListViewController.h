//
//  BBRecipesListViewController.h
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBRecipesListDataSource.h"
#import "BBRecipeEditorDelegate.h"

@interface BBRecipesListViewController : UITableViewController <BBRecipeEditorDelegate>

@property (strong, nonatomic) id<BBRecipesListDataSource> dataSource;

@end
