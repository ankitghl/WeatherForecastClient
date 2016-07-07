//
//  ATDashboardViewController.m
//  AnkitTest
//
//  Created by Ankit Gohel on 27/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import "ATDashboardViewController.h"
#import "AppDelegate.h"
#import "ATNearByCities.h"
#import "ATList.h"
#import "ATWeather.h"

#import "ATForecast.h"

#import "ATForecastViewController.h"

#import "ATUtilityClass.h"

@interface ATDashboardViewController ()
{
    /// Object to store cities nearby
    ATNearByCities *objNearByCities;
    
    ATLocationManager *loc;
    
    NSArray *arrSearchResults;
    
    NSMutableDictionary *dictImages;
    
    BOOL isSearching;
    
}
@end

@implementation ATDashboardViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Weather Forecast";
    
    dictImages = [[NSMutableDictionary alloc] init];
    
    [self addNavigationRightButton];
    
    [self initialiseLocationManagerFor:kForNearByCities];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.searchBar.text.length > 0)
    {
        self.searchBar.text = @"";
        isSearching = NO;
        [self.tblNearByCities reloadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

#pragma mark - Private/ Helper Methods

/**
 *  Gets Forecast for current Location (Latitude and Longitude)
 */
-(void)addNavigationRightButton
{
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"currentLocation"] style:UIBarButtonItemStylePlain target:self action:@selector(btnLoadWeatherForCurrentLocation)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


/**
 *  Initalise locaiton manager for type
 *
 *  @param kType Location fetch type
 */
-(void)initialiseLocationManagerFor:(kLocationTag)kType
{
    loc = [[ATLocationManager alloc] init];
    loc.delegate=self;
    loc.locationTag = kType;
}


/**
 *  Gets locaiton and fetches location datafor tag
 *
 *  @param location Location
 *  @param kTag     Type of weather to be fetched
 */
-(void)getCurrentLocation:(CLLocation *)location forTag:(kLocationTag)kTag
{
    if (kTag == kForNearByCities)   /// get nearby cities
    {
        [self getNearbyCitiesForCurrentLocation:location];
    }
    else if (kTag == kForCurrentLocation)   /// gets forecast of
    {
        [self getForecastForCurrentLocation:location];
    }
}


/**
 *  Filter array of city
 *
 *  @param searchText text to search
 *  @param scope
 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"name contains[cd] %@",
                                    searchText];
    
    arrSearchResults = [objNearByCities.list filteredArrayUsingPredicate:resultPredicate];
    isSearching = YES;
    [self.tblNearByCities reloadData];
}


#pragma mark - Get Weather Forecast
/**
 *  Get all the nearby cities (Default 20) by current location as center
 *
 *  @param location Current Location of user
 */
-(void)getNearbyCitiesForCurrentLocation:(CLLocation *)location
{
    [[[AppDelegate appDelegate] weatherAPI ] findForecastWeatherByCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) withCount:20 withSuccess:^(id receivedString)
     {
         objNearByCities = [[ATNearByCities alloc] initWithDictionary:(NSDictionary *)receivedString];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tblNearByCities reloadData];
         });
         
         
     } orFailure:^(NSError *error) {
         NSLog(@"Error: %@",error.description);
         
     }];
}

/**
 *  Get Weather for city by city name
 *
 *  @param strCityName Name of city whose weather is to be found
 */
-(void)getCurrentWeatherForCity:(NSString *)strCityName
{
    [[[AppDelegate appDelegate] weatherAPI] dailyForecastWeatherByCityName:strCityName withCount:14 withSuccess:^(id receivedString) {
        ATForecast *objForecast = [[ATForecast alloc] initWithDictionary:(NSDictionary *)receivedString];
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ATForecastViewController *vcForecast = [main instantiateViewControllerWithIdentifier:@"ATForecastViewController"];
        vcForecast.objForecast = objForecast;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:vcForecast animated:YES];
        });
        
    } orFailure:^(NSError *error) {
        NSLog(@"Error: %@",error.description);
    }];
}

/**
 *  Get weather forecast for current location
 *
 *  @param location Locaiton fo rwhich forecast to be fetched
 */
-(void)getForecastForCurrentLocation:(CLLocation *)location
{
    [[[AppDelegate appDelegate] weatherAPI] dailyForecastWeatherByCoordinate:location.coordinate withCount:14 withSuccess:^(id receivedString) {
        
        ATForecast *objForecast = [[ATForecast alloc] initWithDictionary:(NSDictionary *)receivedString];
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ATForecastViewController *vcForecast = [main instantiateViewControllerWithIdentifier:@"ATForecastViewController"];
        vcForecast.objForecast = objForecast;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:vcForecast animated:YES];
        });
        
    } orFailure:^(NSError *error) {
        NSLog(@"Error: %@",error.description);

        
    }];
    
}

#pragma mark - UISearchDisplayController delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    if (searchBar.text.length > 0)
    {
        [self getCurrentWeatherForCity:searchBar.text];
    }
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 0)
    {
        [self filterContentForSearchText:searchText
                                   scope:[[self.searchBar scopeButtonTitles] objectAtIndex:[self.searchBar selectedScopeButtonIndex]]];
    }
    else
    {
        isSearching = NO;
        [self.tblNearByCities reloadData];
    }
}



#pragma mark - Table Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching) {
        return arrSearchResults.count;
    }
    else {
        return objNearByCities.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ATList *objList ;
    if (isSearching) {
        objList = [arrSearchResults objectAtIndex:indexPath.row];
    }
    else {
        objList = [objNearByCities.list objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",objList.name];
    [cell.textLabel setTextColor:[ATUtilityClass getThemeColor]];
    
    cell.detailTextLabel.text = [ATUtilityClass getDateStringFromTimestamp:objList.dt];
    [cell.detailTextLabel setTextColor:[ATUtilityClass getThemeColor]];

    cell.imageView.image = [UIImage imageNamed:@"ic_weatherplaceholder"];

    if ([dictImages valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
    {
        cell.imageView.image = [dictImages valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];

    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",((ATWeather *)[objList .weather  firstObject]).icon]];
            
            __block NSData *imageData;
            
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                          ^{
                              imageData = [NSData dataWithContentsOfURL:imageURL];
                              
                              [dictImages setObject:[UIImage imageWithData:imageData] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                              
                              dispatch_sync(dispatch_get_main_queue(), ^{
                                  cell.imageView.image = [dictImages valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                                  [cell layoutSubviews];

                              });
                          });
        });
    }

    return cell;
    
}


#pragma mark - Table Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ATList *objList ;
    if (isSearching) {
        objList = [arrSearchResults objectAtIndex:indexPath.row];
    }
    else {
        objList = [objNearByCities.list objectAtIndex:indexPath.row];
    }
    
    [self getCurrentWeatherForCity:objList.name];
}


#pragma mark - Button Events

-(void)btnLoadWeatherForCurrentLocation
{
    [self initialiseLocationManagerFor:kForCurrentLocation];
}


@end
