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

#import "BAProgressViewController.h"
#import "BAProgressLayer.h"

@implementation BAProgressViewController

- (void)dealloc {
	[_progressView1 release];
	[_progressView2 release];
	[_plateView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[_progressView1 release];
	_progressView1 = nil;
	[_progressView2 release];
	_progressView2 = nil;
	[_plateView release];
	_plateView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	_progressView1.progressColor = [UIColor darkGrayColor];
	_progressView2.progressColor = [UIColor darkGrayColor];
	_progressView2.failed = YES;
	
	BAProgressLayer *l1 = [[[BAProgressLayer alloc] init] autorelease];
	l1.progress = 0.33;
	l1.frame = CGRectMake(5, 5, 40, 40);
	l1.progressColor = [UIColor blackColor].CGColor;
	l1.backgroundColor = [UIColor clearColor].CGColor;
	[_plateView.layer addSublayer:l1];

	BAProgressLayer *l2 = [[[BAProgressLayer alloc] init] autorelease];
	l2.failed = YES;
	l2.frame = CGRectMake(55, 5, 40, 40);
	l2.progressColor = [UIColor blackColor].CGColor;
	l2.backgroundColor = _plateView.backgroundColor.CGColor;
	[_plateView.layer addSublayer:l2];
	
	BAProgressLayer *l3 = [[[BAProgressLayer alloc] init] autorelease];
	l3.frame = CGRectMake(105, 5, 40, 40);
	l3.progressColor = [UIColor blackColor].CGColor;
	l3.backgroundColor = [UIColor clearColor].CGColor;
	[_plateView.layer addSublayer:l3];

	CABasicAnimation *progressAnimation = [CABasicAnimation animationWithKeyPath:@"progress"];
	progressAnimation.fromValue = [NSNumber numberWithInt:0];
	progressAnimation.toValue = [NSNumber numberWithInt:1];
	progressAnimation.duration = 10;
	[l3 addAnimation:progressAnimation forKey:@"duration"];
	l3.progress = 1;
}

- (IBAction)less {
	_progressView1.progress -= 0.2;
}

- (IBAction)more {
	_progressView1.progress += 0.2;
}

@end
