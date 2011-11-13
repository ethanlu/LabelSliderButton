//
//  LabelSliderButton.m
//  viewslider
//
//  Created by Ethan Lu on 11/5/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "LabelSliderButton.h"

@implementation LabelSliderButton

@synthesize button = _button;

-(id) initWithLabels:(NSMutableArray *)labels AtY:(CGFloat)y
{
    self = [super init];
    
    if (self && labels.count > 2)
    {
        _texts = labels;
        _indexOfMiddle = 1; //-text at index 1 is defaulted to be middle layer
        
        //-create button
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,y,320.0f,kLayerHeight)];
        self.button.backgroundColor = [UIColor lightGrayColor];
        
        _layerLeft = [CATextLayer layer];
        [_layerLeft setFrame:CGRectMake(10.0f,kSideOffsetY,kLayerWidth,kLayerHeight)];
        [_layerLeft setString:[_texts objectAtIndex:0]];
        [_layerLeft setFontSize:kSideFontSize];
        [_layerLeft setAlignmentMode:kCAAlignmentLeft];
        [_layerLeft setForegroundColor:[UIColor blackColor].CGColor];
        
        _layerMiddle = [CATextLayer layer];
        [_layerMiddle setFrame:CGRectMake(110.0f,kMainOffsetY,kLayerWidth,kLayerHeight)];
        [_layerMiddle setString:[_texts objectAtIndex:1]];
        [_layerMiddle setFontSize:kMainFontSize];
        [_layerMiddle setAlignmentMode:kCAAlignmentCenter];
        [_layerMiddle setForegroundColor:[UIColor blackColor].CGColor];
        
        _layerRight = [CATextLayer layer];
        [_layerRight setFrame:CGRectMake(210.0f,kSideOffsetY,kLayerWidth,kLayerHeight)];
        [_layerRight setString:[_texts objectAtIndex:2]];
        [_layerRight setFontSize:kSideFontSize];
        [_layerRight setAlignmentMode:kCAAlignmentRight];
        [_layerRight setForegroundColor:[UIColor blackColor].CGColor];
        
        _layerHiddenLeft = [CATextLayer layer];
        [_layerHiddenLeft setFrame:CGRectMake(-100.0f,kSideOffsetY,kLayerWidth,kLayerHeight)];
        [_layerHiddenLeft setString:[_texts objectAtIndex:_texts.count-1]];
        [_layerHiddenLeft setFontSize:kSideFontSize];
        [_layerHiddenLeft setAlignmentMode:kCAAlignmentLeft];
        [_layerHiddenLeft setForegroundColor:[UIColor blackColor].CGColor];
        
        _layerHiddenRight = [CATextLayer layer];
        [_layerHiddenRight setFrame:CGRectMake(320.0f,kSideOffsetY,kLayerWidth,kLayerHeight)];
        [_layerHiddenRight setString:(_texts.count > 3 ? [_texts objectAtIndex:3] : [_texts objectAtIndex:0])];
        [_layerHiddenRight setFontSize:kSideFontSize];
        [_layerHiddenRight setAlignmentMode:kCAAlignmentRight];
        [_layerHiddenRight setForegroundColor:[UIColor blackColor].CGColor];
        
        [self.button.layer addSublayer:_layerMiddle];
        [self.button.layer addSublayer:_layerLeft];
        [self.button.layer addSublayer:_layerRight];
        
        [self.button.layer addSublayer:_layerHiddenRight];
        [self.button.layer addSublayer:_layerHiddenLeft];
    }
    
    return self;
}

-(void) slideLeft
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:kAnimationDuration];
    
    //-shift left layer off screen
    _layerLeft.position = CGPointMake(-60.0f,kSideAnimateOffsetY);
    _layerLeft.alignmentMode = kCAAlignmentLeft;
    
    //-shift middle layer to left
    _layerMiddle.position = CGPointMake(60.0f,kSideAnimateOffsetY);
    _layerMiddle.alignmentMode = kCAAlignmentLeft;
    _layerMiddle.fontSize = kSideFontSize;
    
    //-shift right layer to middle
    _layerRight.position = CGPointMake(160.0f,kMainAnimateOffsetY);
    _layerRight.alignmentMode = kCAAlignmentCenter;
    _layerRight.fontSize = kMainFontSize;
    
    //-shift offscreen hidden right layer to right
    _layerHiddenRight.position = CGPointMake(260.0f,kSideAnimateOffsetY);
    _layerHiddenRight.alignmentMode = kCAAlignmentRight;
    
    [CATransaction setCompletionBlock:^{
        //-update index
        _indexOfMiddle = (_indexOfMiddle < (_texts.count - 1)) ? (_indexOfMiddle + 1) : 0;
        
        //-reassign the layer variables
        CATextLayer *temp = _layerHiddenLeft;
        _layerHiddenLeft = _layerLeft;
        _layerLeft = _layerMiddle;
        _layerMiddle = _layerRight;
        _layerRight = _layerHiddenRight;
        _layerHiddenRight = temp;
        
        //-update hidden layer values with the previous and next texts from the array of labels
        int indexHiddenLeft = _indexOfMiddle - 2;
        if (indexHiddenLeft < 0)
        {
            indexHiddenLeft = _texts.count + indexHiddenLeft;
        }
        
        int indexHiddenRight = _indexOfMiddle + 2;
        if (indexHiddenRight >= _texts.count)
        {
            indexHiddenRight = indexHiddenRight - _texts.count;
        }
        
        _layerHiddenLeft.string = [_texts objectAtIndex:indexHiddenLeft];
        _layerHiddenRight.string = [_texts objectAtIndex:indexHiddenRight];
        
        //-move the now hidden left layer over to hidden right side
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        _layerHiddenRight.position = CGPointMake(370.0f,kSideAnimateOffsetY);
        _layerHiddenRight.alignmentMode = kCAAlignmentRight;
        [CATransaction commit];
    }];
    
    [CATransaction commit];
}

-(void) slideRight
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:kAnimationDuration];
    
    //-shift right layer off screen
    _layerRight.position = CGPointMake(370.0f,kSideAnimateOffsetY);
    _layerRight.alignmentMode = kCAAlignmentRight;
    
    //-shift middle layer to right
    _layerMiddle.position = CGPointMake(260.0f,kSideAnimateOffsetY);
    _layerMiddle.alignmentMode = kCAAlignmentRight;
    _layerMiddle.fontSize = kSideFontSize;
    
    //-shift left layer to middle
    _layerLeft.position = CGPointMake(160.0f,kMainAnimateOffsetY);
    _layerLeft.alignmentMode = kCAAlignmentCenter;
    _layerLeft.fontSize = kMainFontSize;
    
    //-shift hidden left layer to left
    _layerHiddenLeft.position = CGPointMake(60.0f,kSideAnimateOffsetY);
    _layerHiddenLeft.alignmentMode = kCAAlignmentLeft;
    
    [CATransaction setCompletionBlock:^{
        //-update index
        _indexOfMiddle = (_indexOfMiddle > 0) ? (_indexOfMiddle - 1) : (_texts.count - 1);
        
        //-reassign variables
        CATextLayer *temp = _layerHiddenRight;
        _layerHiddenRight = _layerRight;
        _layerRight = _layerMiddle;
        _layerMiddle = _layerLeft;
        _layerLeft = _layerHiddenLeft;
        _layerHiddenLeft = temp;
        
        //-update hidden layer values with the previous and next texts from the array of labels
        int indexHiddenLeft = _indexOfMiddle - 2;
        if (indexHiddenLeft < 0)
        {
            indexHiddenLeft = _texts.count + indexHiddenLeft;
        }
        
        int indexHiddenRight = _indexOfMiddle + 2;
        if (indexHiddenRight >= _texts.count)
        {
            indexHiddenRight = indexHiddenRight - _texts.count;
        }
        
        _layerHiddenLeft.string = [_texts objectAtIndex:indexHiddenLeft];
        _layerHiddenRight.string = [_texts objectAtIndex:indexHiddenRight];
        
        //-move hidden right layer to hidden left
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        _layerHiddenLeft.position = CGPointMake(-60.0f,kSideAnimateOffsetY);
        _layerHiddenLeft.alignmentMode = kCAAlignmentLeft;
        [CATransaction commit];
    }];
    
    [CATransaction commit];
}

-(NSString*) getLeftText
{
    return [_texts objectAtIndex:((_indexOfMiddle < (_texts.count - 1)) ? (_indexOfMiddle + 1) : 0)];
}

-(NSString*) getCenterText
{
    return [_texts objectAtIndex:_indexOfMiddle];
}

-(NSString*) getRightText
{
    return [_texts objectAtIndex:((_indexOfMiddle > 0) ? (_indexOfMiddle - 1) : (_texts.count - 1))];
}

@end
