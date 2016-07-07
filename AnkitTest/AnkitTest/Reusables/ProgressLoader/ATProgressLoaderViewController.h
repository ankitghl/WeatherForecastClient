//
//  ATProgressLoaderViewController.h
//  AnkitTest
//
//  Created by Ankit Gohel on 05/07/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATProgressLoaderViewController : UIViewController

/**
 *   View with BG and Loader
 */
@property (weak, nonatomic) IBOutlet UIView *vwContainer;
/**
 *  Loader
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityProgress;

@end
