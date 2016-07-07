//
//  ATProgressLoaderViewController.m
//  AnkitTest
//
//  Created by Ankit Gohel on 05/07/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import "ATProgressLoaderViewController.h"

@interface ATProgressLoaderViewController ()

@end

@implementation ATProgressLoaderViewController

#pragma mark - View life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Customise and start animating loader
    
    [self.vwContainer.layer setCornerRadius:10.0f];
    [self.vwContainer.layer setMasksToBounds:YES];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    self.activityProgress.transform = transform;
    [self.activityProgress startAnimating];

}

@end
