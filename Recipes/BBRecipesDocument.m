//
//  BBRecipesDocument.m
//  Recipes
//
//  Created by Martin Volerich on 8/30/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBRecipesDocument.h"

NSString * const BBRecipesDidChangeNotification = @"BBRecipesDidChangeNotification";

@implementation BBRecipesDocument


#pragma mark - BBRecipesListDataSource methods

- (NSInteger)recipeCount
{
    return [self.recipes count];
}

- (NSUInteger)indexOfRecipe:(BBRecipe *)recipe
{
    return [self.recipes indexOfObject:recipe];
}

- (BBRecipe *)recipeAtIndex:(NSInteger)index
{
    return [self.recipes objectAtIndex:index];
}

- (void)deleteRecipeAtIndex:(NSInteger)index
{
    [self.recipes removeObjectAtIndex:index];
    [self updateChangeCount:UIDocumentChangeDone];
}

- (BBRecipe *)createNewRecipe
{
    BBRecipe *recipe = [[BBRecipe alloc] init];
    [self.recipes addObject:recipe];
    [self updateChangeCount:UIDocumentChangeDone];
    return recipe;
}

- (void)recipesChanged
{
    [self updateChangeCount:UIDocumentChangeDone];
}

- (NSData *)dataForRecipes:(NSError *__autoreleasing *)error
{
    __block NSData *data = nil;
    NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
    [coordinator coordinateReadingItemAtURL:self.fileURL
                                    options:NSFileCoordinatorReadingWithoutChanges
                                      error:error
                                 byAccessor:^(NSURL *newURL) {
                                     data = [NSData dataWithContentsOfURL:newURL];
                                 }];
    return data;
}

#pragma mark - UIDocument overrides

- (id)initWithFileURL:(NSURL *)url
{
    self = [super initWithFileURL:url];
    if (self) {
        _recipes = [NSMutableArray array];
    }
    return self;
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    return [NSKeyedArchiver archivedDataWithRootObject:self.recipes];
}

- (BOOL)loadFromContents:(id)contents
                  ofType:(NSString *)typeName
                   error:(NSError *__autoreleasing *)outError
{
    BOOL success = NO;
    if ([contents isKindOfClass:[NSData class]] && [contents length] > 0) {
        NSData *data = (NSData *)contents;
        self.recipes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        success = YES;
    }
    return success;
}

- (void)handleError:(NSError *)error userInteractionPermitted:(BOOL)userInteractionPermitted
{
    if ([[error domain] isEqualToString:NSCocoaErrorDomain] && [error code] == NSFileReadNoSuchFileError) {
        [self saveToURL:[self fileURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            NSLog(@"handled open error with a new doc");
        }];
    } else {
        [super handleError:error userInteractionPermitted:userInteractionPermitted];
    }
}

- (void)createNewDocumentFile
{
    [self saveToURL:self.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        NSLog(@"New file created.");
    }];
}

- (void)addRecipesFromDocument:(BBRecipesDocument *)newDoc
{
    [self.recipes addObjectsFromArray:newDoc.recipes];
    [[NSNotificationCenter defaultCenter] postNotificationName:BBRecipesDidChangeNotification object:self];
    [self updateChangeCount:UIDocumentChangeDone];
}

@end
