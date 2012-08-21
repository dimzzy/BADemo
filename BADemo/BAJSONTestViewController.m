//
//  BAJSONTestViewController.m
//  BADemo
//
//  Created by Dmitry Stadnik on 8/21/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

#import "BAJSONTestViewController.h"
#import "BAJSONViewController.h"
#import "BARuntime.h"

@interface BAJSONTestViewController ()

@end

@implementation BAJSONTestViewController

- (void)showFile:(NSString *)file {
	NSURL *u = [[NSBundle mainBundle] URLForResource:file withExtension:@"json"];
	NSData *d = [NSData dataWithContentsOfURL:u];
	NSError *e = nil;
	id v = [BARuntime parseJSONData:d error:&e];
	if (!v) {
		if (e) {
			NSLog(@"%@", e);
		}
		return;
	}
	BAJSONViewController *c = [[[BAJSONViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
	c.JSONValue = v;
	[self.navigationController pushViewController:c animated:YES];
}

- (IBAction)test1 {
	[self showFile:@"test1"];
}

- (IBAction)test2 {
	[self showFile:@"test2"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end
