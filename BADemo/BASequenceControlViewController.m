/*
 Copyright 2011 Dmitry Stadnik. All rights reserved.
 
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

#import "BASequenceControlViewController.h"

@implementation BASequenceControlViewController

@synthesize c1, c2, label;

- (void)dealloc {
	self.c1 = nil;
	self.c2 = nil;
	self.label = nil;
	[super dealloc];
}

- (void)valueDidChange {
	self.label.text = [self.c1 titleForSegmentAtIndex:self.c1.selectedSegmentIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.c1 addSegmentWithTitle:@"Alpha" animated:NO];
	[self.c1 addSegmentWithTitle:@"Beta" animated:NO];
	[self.c1 addSegmentWithTitle:@"Gammadillo" animated:NO];
	self.c1.leftMargin = 10;
	self.c1.rightMargin = 10;
	self.c1.overlapWidth = 22;
	[self.c1 addTarget:self action:@selector(valueDidChange) forControlEvents:UIControlEventValueChanged];

	[self.c2 addSegmentWithTitle:@"First" animated:NO];
	[self.c2 addSegmentWithTitle:@"Second" animated:NO];
	self.c2.leftMargin = -22;
	self.c2.rightMargin = -22;
	self.c2.overlapWidth = 22;
}

@end
