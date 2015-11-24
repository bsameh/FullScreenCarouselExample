//
//  ViewController.h
//  FullScreenCarouselExample
//
//  Created by Bassem Sameh on 11/24/15.
//  Copyright © 2015 Bassem Sameh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) IBOutlet iCarousel *verticalCarousel;

@end

