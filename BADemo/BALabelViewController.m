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

#import "BALabelViewController.h"

@implementation BALabelViewController

@synthesize l1, l2, l3, l4, l5, l6, l7, rb, rsb;

- (void)dealloc {
	self.l1 = self.l2 = self.l3 = self.l4 = self.l5 = self.l6 = self.l7 = self.rb = self.rsb = nil;
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.l2.textInsets = UIEdgeInsetsMake(5, 10, 15, 20);
	[self.l2 sizeToFit];
	self.l3.verticalAlignment = BAVerticalAlignmentTop;
	self.l5.verticalAlignment = BAVerticalAlignmentBottom;
	self.l6.verticalAlignment = BAVerticalAlignmentBottom;
	self.l6.textInsets = UIEdgeInsetsMake(5, 10, 15, 20);
	[self.l7 sizeToFitInWidth];
	self.rb.bezel = BALabelBezelRound;
	self.rb.bezelLineWidth = 2;
	self.rb.bezelColor = [UIColor blackColor];
	self.rsb.bezel = BALabelBezelRoundSolid;
	self.rsb.bezelColor = [UIColor blackColor];
	self.rsb.textColor = [UIColor whiteColor];
}

@end
