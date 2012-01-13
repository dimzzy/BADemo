//
//  BADaysViewController.m
//  BADemo
//
//  Created by Stadnik Dmitry on 1/13/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

#import "BADaysViewController.h"
#import "NSDate+BADays.h"

@implementation BADaysViewController {
@private
	NSDate *_date;
}

@synthesize nowLabel, currDayLabel, prevDayLabel, nextDayLabel, sameDayLabel, daysSinceNowLabel, currHourLabel;

- (void)dealloc {
	[_date release];
	self.nowLabel = nil;
	self.currDayLabel = nil;
	self.prevDayLabel = nil;
	self.nextDayLabel = nil;
	self.sameDayLabel = nil;
	self.daysSinceNowLabel = nil;
	self.currHourLabel = nil;
	[super dealloc];
}

- (void)updateViews {
	NSDateFormatter *fmt = [[[NSDateFormatter alloc] init] autorelease];
	fmt.dateStyle = NSDateFormatterMediumStyle;
	fmt.timeStyle = NSDateFormatterMediumStyle;
	self.nowLabel.text = [fmt stringFromDate:_date];
	self.currDayLabel.text = [fmt stringFromDate:[_date currDay]];
	self.prevDayLabel.text = [fmt stringFromDate:[_date prevDay]];
	self.nextDayLabel.text = [fmt stringFromDate:[_date nextDay]];
	self.sameDayLabel.text = [NSString stringWithFormat:@"Same day: %d", (int)[_date sameDay:[NSDate date]]];
	self.daysSinceNowLabel.text = [NSString stringWithFormat:@"Days since now: %d", [_date daysSinceNow]];
	self.currHourLabel.text = [NSString stringWithFormat:@"Current hour: %d", [_date currHour]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	_date = [[NSDate date] retain];
	[self updateViews];
}

- (IBAction)prevDay {
	NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
	[components setDay:-1];
	NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:_date options:0];
	[_date release];
	_date = [date retain];
	[self updateViews];
}

- (IBAction)nextDay {
	NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
	[components setDay:1];
	NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:_date options:0];
	[_date release];
	_date = [date retain];
	[self updateViews];
}

@end
