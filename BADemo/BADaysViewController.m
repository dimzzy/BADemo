/*
 Copyright 2012 Dmitry Stadnik. All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are
 permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this list of
 conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice, this list
 of conditions and the following disclaimer in the documentation and/or other materials
 provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY DMITRY STADNIK ``AS IS'' AND ANY EXPRESS OR IMPLIED
 WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL DMITRY STADNIK OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 The views and conclusions contained in the software and documentation are those of the
 authors and should not be interpreted as representing official policies, either expressed
 or implied, of Dmitry Stadnik.
 */

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
