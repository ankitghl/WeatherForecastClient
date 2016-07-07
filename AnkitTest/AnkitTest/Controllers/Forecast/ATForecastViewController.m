//
//  ATForecastViewController.m
//  AnkitTest
//
//  Created by Ankit on 30/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import "ATForecastViewController.h"

#import "ATForecastTableViewCell.h"

#import "ATListForecast.h"
#import "ATWeather.h"
#import "ATTemp.h"
#import "ATCity.h"

#import "ATUtilityClass.h"

@interface ATForecastViewController ()
{
    NSMutableDictionary *dictImages;
}
@end

@implementation ATForecastViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Weather Forecast";
    
    dictImages = [[NSMutableDictionary alloc] init];

    [self showCurrentWeatherDetails];
    
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - Private/ Helper Methods
/**
 *  Shows current Weather Details on top of the screen.
 */
-(void)showCurrentWeatherDetails
{
    ATCity *objCity = self.objForecast.city;
    
    self.lblCityName.text = objCity.name;
    
    ATListForecast *objClimateList  = [self.objForecast.list firstObject];
    ATWeather *objWeather           = [objClimateList.weather firstObject];

    self.lblWeather.text = objWeather.weatherDescription;
    
    ATTemp *objTemp                 = objClimateList.temp;
    self.lblTemp.text = [NSString stringWithFormat:@"%.2f℃",objTemp.day];
    
    self.lblDay.text     = [ATUtilityClass getDateStringFromTimestamp:objClimateList.dt];

}

#pragma mark - Table View Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objForecast.list.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ATForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATForecastTableViewCell"];
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    ATListForecast *objClimateList  = [self.objForecast.list objectAtIndex:indexPath.row];
    ATWeather *objWeather           = [objClimateList.weather firstObject];
    ATTemp *objTemp                 = objClimateList.temp;

    cell.lblDay.text     = [ATUtilityClass getDateStringFromTimestamp:objClimateList.dt];
    cell.lblClimate.text = objWeather.main;
    
    cell.lblCurrentTemp.text = [NSString stringWithFormat:@"%.2f",objClimateList.rain];
    cell.lblMaxTemp.text     = [NSString stringWithFormat:@"%.2f℃",objTemp.max];
    cell.lblMinTemp.text     = [NSString stringWithFormat:@"%.2f℃",objTemp.min];
    
    cell.imgClimateIcon.image = [UIImage imageNamed:@"ic_weatherplaceholder"];
    
    if ([dictImages valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
    {
        cell.imgClimateIcon.image = [dictImages valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",objWeather.icon]];
            
            __block NSData *imageData;
            
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                          ^{
                              imageData = [NSData dataWithContentsOfURL:imageURL];
                              
                              [dictImages setObject:[UIImage imageWithData:imageData] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                              
                              dispatch_sync(dispatch_get_main_queue(), ^{
                                  cell.imgClimateIcon.image = [dictImages valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                              });
                          });
        });
    }

    
    return cell;
}

@end
