//
//  ATForecastViewController.h
//  AnkitTest
//
//  Created by Ankit on 30/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATForecast.h"

@interface ATForecastViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

#pragma mark - Outlets
/**
 * View to show Current Weather Summary
 */
@property (weak, nonatomic) IBOutlet UIView *vwCurrentDayForecast;
/**
 *  City Name
 */
@property (weak, nonatomic) IBOutlet UILabel *lblCityName;
/**
 *  Weather to be shown
 */
@property (weak, nonatomic) IBOutlet UILabel *lblWeather;
/**
 *  Temp to be shown
 */
@property (weak, nonatomic) IBOutlet UILabel *lblTemp;
/**
 *  Show date
 */
@property (weak, nonatomic) IBOutlet UILabel *lblDay;


/// Table view with Fore cast of city's weather
@property (weak, nonatomic) IBOutlet UITableView *tblForecast;

#pragma mark - Protected Methods
/**
 *  Forecast obj used to show data
 */
@property(strong,nonatomic) ATForecast *objForecast;

@end
