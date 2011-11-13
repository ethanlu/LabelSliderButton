//
//  LabelSliderButton.h
//  viewslider
//
//  Created by Ethan Lu on 11/5/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration .25f
#define kSideFontSize 12.0f
#define kMainFontSize 16.0f
#define kLayerWidth 100.0f
#define kLayerHeight 20.0f
#define kSideOffsetY 4.0f
#define kMainOffsetY 3.0f
#define kSideAnimateOffsetY 15.0f
#define kMainAnimateOffsetY 13.0f

@interface LabelSliderButton : NSObject
{
    CATextLayer *_layerLeft;
    CATextLayer *_layerMiddle;
    CATextLayer *_layerRight;
    
    CATextLayer *_layerHiddenLeft;
    CATextLayer *_layerHiddenRight;
    
    NSMutableArray *_texts;
    int _indexOfMiddle;
}

@property (nonatomic,strong) UIButton *button;

-(id) initWithLabels:(NSMutableArray *)labels AtY:(CGFloat)y;
-(NSString*) getCenterText;
-(void) slideLeft;
-(void) slideRight;

@end
