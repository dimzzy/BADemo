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

#import "BAGroupedPageControlViewController.h"

@implementation BAGroupedPageControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_pc.numberOfPages = 11;
	_pc.pagesPerGroup = 3;
	_pc.activeColor = [UIColor blackColor];

	_pcc.numberOfPages = 5;
	_pcc.pagesPerGroup = 0;

	_pcl.numberOfPages = 5;
	_pcl.pagesPerGroup = 0;
	_pcl.alignment = BAPageControlAlignmentLeft;
	_pcl.inset = 10;

	_pcr.numberOfPages = 5;
	_pcr.pagesPerGroup = 0;
	_pcr.alignment = BAPageControlAlignmentRight;
	_pcr.inset = 10;
	
	_pc1.numberOfPages = 15;
	_pc1.pagesPerGroup = 5;
	_pc1.activeColor = [UIColor blackColor];
	
	_pc2.numberOfPages = 10;
	_pc2.pagesPerGroup = 3;
	_pc2.activeColor = [UIColor whiteColor];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void)dealloc {
	[_pc release];
	[_pcc release];
	[_pcl release];
	[_pcr release];
	[_pc1 release];
	[_pc2 release];
	[super dealloc];
}

@end
