//
//  ATForecastTableViewCell.h
//  AnkitTest
//
//  Created by Ankit Gohel on 01/07/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATForecastTableViewCell : UITableViewCell


#pragma mark - Outlets

/// Label to show Day for Forecast
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
/// Label to show Climate for Forecast
@property (weak, nonatomic) IBOutlet UILabel *lblClimate;
/// Label to show Current Temperature for Forecast
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentTemp;
/// Image to show Image for climate for Forecast
@property (weak, nonatomic) IBOutlet UIImageView *imgClimateIcon;
/// Label to show Maximum Temperature for Forecast
@property (weak, nonatomic) IBOutlet UILabel *lblMaxTemp;
/// Label to show Minimum Temperature for Forecast
@property (weak, nonatomic) IBOutlet UILabel *lblMinTemp;

@end
