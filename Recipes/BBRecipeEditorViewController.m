//
//  BBRecipeEditorViewController.m
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBRecipeEditorViewController.h"
#import "BBRecipe.h"
#import "BBRecipesListViewController.h"
#import "BBDirectionsEditorViewController.h"

@interface BBRecipeEditorViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *directionsText;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UIStepper *prepTimeStepper;

@property (strong, nonatomic) NSNumberFormatter *formatter;

- (IBAction)done:(id)sender;

- (IBAction)changePreparationTime:(UIStepper *)sender;

@end

@implementation BBRecipeEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.formatter = [[NSNumberFormatter alloc] init];
	// Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleField.text = self.recipe.title;
    self.directionsText.text = self.recipe.directions;
    self.prepTimeLabel.text = [self.formatter stringFromNumber:self.recipe.preparationTime];
    self.prepTimeStepper.value = [self.recipe.preparationTime doubleValue];
    
    if (nil != self.recipe.image) {
        self.recipeImage.image = self.recipe.image;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate finishedEditingRecipe:self.recipe];
}

- (IBAction)changePreparationTime:(UIStepper *)sender
{
    NSInteger value = (NSInteger)[sender value];
    self.recipe.preparationTime = @(value);
    self.prepTimeLabel.text = [self.formatter stringFromNumber:self.recipe.preparationTime];
    [self.delegate recipeChanged:self.recipe];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.recipe.title = textField.text;
    [self.delegate recipeChanged:self.recipe];
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"choosePhoto" isEqualToString:segue.identifier]) {
        [[segue destinationViewController] setDelegate:self];
    }
    if ([@"editDirections" isEqualToString:segue.identifier]) {
        BBDirectionsEditorViewController *directionsVC = segue.destinationViewController;
        directionsVC.recipe = self.recipe;
        directionsVC.delegate = self.delegate;
        
    }
}

#pragma mark - Image Picker Delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.recipe.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.delegate recipeChanged:self.recipe];
}

@end
