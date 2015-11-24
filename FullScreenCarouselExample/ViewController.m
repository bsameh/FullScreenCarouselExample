//
//  ViewController.m
//  FullScreenCarouselExample
//
//  Created by Bassem Sameh on 11/24/15.
//  Copyright © 2015 Bassem Sameh. All rights reserved.
//

#import "ViewController.h"

static NSInteger const labelTag = 1;

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    items = @[@"One", @"Two", @"Three", @"Four"];
    
    self.verticalCarousel.delegate = self;
    self.verticalCarousel.dataSource = self;
    
    self.verticalCarousel.type = iCarouselTypeCustom; // This is needed so that you can use your own custom transform
    
    self.verticalCarousel.vertical = YES;
    self.verticalCarousel.scrollSpeed = 0.1f; // Ranges from 0.0f to 1.0f
    
    self.verticalCarousel.backgroundColor = [UIColor blackColor];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label;
    
    // Initialize the view
    if(view == nil) {
        view = [[UIView alloc] initWithFrame:self.view.frame]; // Use the whole frame
        view.backgroundColor = [UIColor lightGrayColor];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        
        // This tag will be used to retreive the label later on in case the view has already been initialized and is being reused
        label.tag = labelTag;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:label];
    }
    else {
        // View has already been initialized, get the label using its tag property
        label = [view viewWithTag:labelTag];
    }
    
    // This is where you use your datasource to populate the view, regardless of whether it's being reused or not
    label.text = [items objectAtIndex:index];
    
    
    return view;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    CGFloat viewHeight = carousel.currentItemView.frame.size.height;
    
    CGFloat hyperbola = sqrtf(offset * offset + 1.0f) - 1.0f;
    
    // This is the scaling factor
    CGFloat zFactor = -200.0f;
    
    if(offset > 0) {
        transform = CATransform3DTranslate(transform, 0, offset * viewHeight, hyperbola * zFactor); // Scale if you're going down
    }
    else {
        transform = CATransform3DTranslate(transform, 0, offset * viewHeight, 1.0f); // Don't scale
    }
    
    return transform;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    // Customize the carousel
    switch (option)
    {
        // Setting this option to YES will make the carousel scroll infinitely.
        case iCarouselOptionWrap:
        {
            return YES;
        }
        case iCarouselOptionFadeMax:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeRange:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionSpacing:
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value; // This is the default value
        }
    }
}

@end
