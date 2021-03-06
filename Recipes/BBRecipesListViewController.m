//
//  BBRecipesListViewController.m
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBRecipesListViewController.h"
#import "BBViewController.h"
#import "BBRecipeEditorViewController.h"
#import <MessageUI/MessageUI.h>

@interface BBRecipesListViewController () <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>

- (IBAction)sendEmail:(id)sender;

@end

@implementation BBRecipesListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recipesChanged:)
                                                 name:BBRecipesDidChangeNotification
                                               object:self.dataSource];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:BBRecipesDidChangeNotification
                                                  object:self.dataSource];
}

- (void)recipesChanged:(id)sender
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource recipeCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    BBRecipe *recipe = [self.dataSource recipeAtIndex:indexPath.row];
    cell.textLabel.text = recipe.title;
    cell.imageView.image = recipe.image;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",
                                 [recipe preparationTime],
                                 NSLocalizedString(@"minutes", nil)];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.dataSource deleteRecipeAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"editExistingRecipe" sender:cell];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"addNewRecipe" isEqualToString:segue.identifier]) {
        BBRecipe *recipe = [self.dataSource createNewRecipe];
        UIViewController *topVC = [[segue destinationViewController] topViewController];
        BBRecipeEditorViewController *editor = (BBRecipeEditorViewController *)topVC;
        editor.delegate = self;
        editor.recipe = recipe;
    }
    if ([@"presentRecipeDetail" isEqualToString:segue.identifier]) {
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        BBRecipe *recipe = [self.dataSource recipeAtIndex:index.row];
        [[segue destinationViewController] setRecipe:recipe];
    }
    if ([@"editExistingRecipe" isEqualToString:segue.identifier]) {
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        BBRecipe *recipe = [self.dataSource recipeAtIndex:index.row];
        UINavigationController *nav = [segue destinationViewController];
        BBRecipeEditorViewController *editor = (BBRecipeEditorViewController *)nav.topViewController;
        editor.delegate = self;
        editor.recipe = recipe;
    }
}

#pragma mark - BBRecipeEditorDelegate methods

- (void)finishedEditingRecipe:(BBRecipe *)recipe
{
    NSUInteger row = [self.dataSource indexOfRecipe:recipe];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    if (nil == cell) {
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
    } else {
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        [self.dataSource recipesChanged];
    }
}

- (void)recipeChanged:(BBRecipe *)recipe
{
    [self.dataSource recipesChanged];
    NSUInteger row = [self.dataSource indexOfRecipe:recipe];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    if (nil != cell) {
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)sendEmail:(id)sender
{
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
    mailVC.delegate = self;
    [mailVC setSubject:@"Great Recipes"];
    NSError *error = nil;
    [mailVC addAttachmentData:[self.dataSource dataForRecipes:&error]
                     mimeType:@"application/octet-stream"
                     fileName:@"Recipes.recipes"];
    if (nil == error) {
        mailVC.mailComposeDelegate = self;
        [self presentViewController:mailVC animated:YES completion:nil];
    } else {
        NSLog(@"error in coordinating read %@ - %@", error, error.userInfo);
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
