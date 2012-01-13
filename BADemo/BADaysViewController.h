//
//  BADaysViewController.h
//  BADemo
//
//  Created by Stadnik Dmitry on 1/13/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BADaysViewController : UIViewController

@property(retain) IBOutlet UILabel *nowLabel, *currDayLabel, *prevDayLabel, *nextDayLabel;
@property(retain) IBOutlet UILabel *sameDayLabel, *daysSinceNowLabel, *currHourLabel;

- (IBAction)prevDay;
- (IBAction)nextDay;

@end
