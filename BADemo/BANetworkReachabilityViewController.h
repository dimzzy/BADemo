//
//  BANetworkReachabilityViewController.h
//  BADemo
//
//  Created by Dmitry Stadnik on 8/23/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BANetworkReachabilityViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end
