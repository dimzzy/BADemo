//
//  BASeparatedTableViewController.h
//  BADemo
//
//  Created by Stadnik Dmitry on 2/3/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BASeparatedTableProvider.h"

@interface BASeparatedTableViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, BASeparatedTableProviderDelegate>

@property(retain) IBOutlet UITableView *tableView;

@end
