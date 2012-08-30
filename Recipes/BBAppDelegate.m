//
//  BBAppDelegate.m
//  StoryboardRecipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBAppDelegate.h"
#import "BBRecipesListViewController.h"
#import "BBRecipesDocument.h"

@interface BBAppDelegate()

@property (strong, nonatomic) BBRecipesDocument *document;

@end

@implementation BBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    BBRecipesListViewController *controller = (BBRecipesListViewController *)navigationController.topViewController;
    
    NSURL *docDir = [[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents"];
    
    NSURL *docURL = [docDir URLByAppendingPathComponent:@"Recipes.recipes"];
    BBRecipesDocument *doc = [[BBRecipesDocument alloc] initWithFileURL:docURL];
    
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:[docURL path]];
 
    if (!exists) {
        [doc createNewDocumentFile];
    }
    
    
    [doc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            [controller.tableView reloadData];
        } else {
            NSLog(@"Failed to open document");        
        }
    }];
    
    controller.dataSource = doc;
    self.document = doc;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BBRecipesDocument *newDoc = [[BBRecipesDocument alloc] initWithFileURL:url];
    [newDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            [self.document addRecipesFromDocument:newDoc];
        } else {
            NSLog(@"Failed to open new document -%@", url);
        }
    }];
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
