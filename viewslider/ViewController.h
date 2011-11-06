//
//  ViewController.h
//  viewslider
//
//  Created by Ethan Lu on 11/2/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "LabelSliderButton.h"

#define kAnimationDuration .25f
#define kSideFontSize 12.0f
#define kMainFontSize 16.0f

@interface ViewController : UIViewController
{
    LabelSliderButton *_titleButton;
    
    CATextLayer *_layerLeft;
    CATextLayer *_layerMiddle;
    CATextLayer *_layerRight;
    
    CATextLayer *_layerHiddenLeft;
    CATextLayer *_layerHiddenRight;
}

@property (nonatomic,strong) IBOutlet UIButton *leftButton;
@property (nonatomic,strong) IBOutlet UIButton *rightButton;

-(IBAction) moveLeft:(id)sender;
-(IBAction) moveRight:(id)sender;

@end
