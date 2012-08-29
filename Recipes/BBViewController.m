//
//  BBViewController.m
//  Recipes
//
//  Created by Martin Volerich on 8/29/12.
//  Copyright (c) 2012 Bill Bear. All rights reserved.
//

#import "BBViewController.h"
#import "BBRecipe.h"

@interface BBViewController ()

@end

@implementation BBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.formatter = [[NSNumberFormatter alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.recipeTitle.text = self.recipe.title;
    self.directionsView.text = self.recipe.directions;
    if (nil != self.recipe.image) {
        self.imageView.image = self.recipe.image;
    }
    self.prepTime.text = [self.formatter stringFromNumber:self.recipe.preparationTime];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.directionsView = nil;
    self.recipeTitle = nil;
    self.directionsView = nil;
}

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
