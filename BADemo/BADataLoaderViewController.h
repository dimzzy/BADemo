//
//  BADataLoaderViewController.h
//  BADemo
//
//  Created by Stadnik Dmitry on 1/13/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BADataLoader.h"

@interface BADataLoaderViewController : UIViewController <BADataLoaderDelegate>

@property(retain) IBOutlet UITextField *linkView;
@property(retain) IBOutlet UITextView *logView;

- (IBAction)load;
- (IBAction)reload;
- (IBAction)stopLoading;

@end
