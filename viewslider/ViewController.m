//
//  ViewController.m
//  viewslider
//
//  Created by Ethan Lu on 11/2/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction) moveLeft:(id)sender
{
    [_titleButton slideLeft];
}

-(IBAction) moveRight:(id)sender
{
    [_titleButton slideRight];
}

-(void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSMutableArray *labels = [NSMutableArray array];
    [labels addObject:@"first"];
    [labels addObject:@"second"];
    [labels addObject:@"third"];
    
    [labels addObject:@"fourth"];
    [labels addObject:@"fifth"];
    
    _titleButton = [[LabelSliderButton alloc] initWithLabels:labels AtY:44.0f];
    [self.view addSubview:_titleButton.button];
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
