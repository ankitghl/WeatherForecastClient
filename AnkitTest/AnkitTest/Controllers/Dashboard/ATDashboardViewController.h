//
//  ATDashboardViewController.h
//  AnkitTest
//
//  Created by Ankit Gohel on 27/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATLocationManager.h"

@interface ATDashboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ATLocationManager,UISearchBarDelegate>

/**
 *  Table to show Cities nearby to current Locations
 */
@property (weak, nonatomic) IBOutlet UITableView *tblNearByCities;
/**
 *  Search bar to filter list or search
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
