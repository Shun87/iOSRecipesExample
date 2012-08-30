//
//  BBRecipesDocument.h
//  Recipes
//
//  Created by Martin Volerich on 8/30/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBRecipesListDataSource.h"

@interface BBRecipesDocument : UIDocument <BBRecipesListDataSource>

@property (strong, nonatomic) NSMutableArray *recipes;

- (void)createNewDocumentFile;
- (void)addRecipesFromDocument:(BBRecipesDocument *)newDoc;

@end
