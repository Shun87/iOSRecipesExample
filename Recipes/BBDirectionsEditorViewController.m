//
//  BBDirectionsEditorViewController.m
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBDirectionsEditorViewController.h"
#import "BBrecipe.h"

@interface BBDirectionsEditorViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BBDirectionsEditorViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Edit Directions";
    [self.textView becomeFirstResponder];
    self.textView.text = self.recipe.directions;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

#pragma mark -
#pragma mark UITextViewDelegate methods

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.recipe.directions = textView.text;
    [self.delegate recipeChanged:self.recipe];
}

@end
