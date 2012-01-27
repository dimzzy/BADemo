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

#import "BAGridViewController.h"

@interface BAGridTestView : UIView

@property int sec, row, col;

@end


@implementation BAGridTestView

@synthesize sec, row, col;

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	[[UIColor blackColor] set];
	[[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 0.5, 0.5)] stroke];
	NSString *s = [NSString stringWithFormat:@"%d:%d:%d", self.sec, self.row, self.col];
	UIFont *font = [UIFont systemFontOfSize:13];
	CGSize ss = [s sizeWithFont:font];
	CGRect sr = CGRectMake((self.bounds.size.width - ss.width) / 2,
						   (self.bounds.size.height - ss.height) / 2,
						   ss.width, ss.height);
	[s drawInRect:sr withFont:font];
}

@end


@implementation BAGridViewController

@synthesize gridView = _gridView;

- (void)dealloc {
	self.gridView = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.gridView = [[[BAGridView alloc] initWithFrame:self.view.bounds] autorelease];
	self.gridView.dataSource = self;
	self.gridView.delegate = self;
	self.gridView.cellSize = CGSizeMake(80, 30);
	self.gridView.backgroundColor = [UIColor grayColor];
	[self.view addSubview:self.gridView];
}

- (NSInteger)numberOfSectionsInGridView:(BAGridView *)gridView {
	return 4;
}

- (NSInteger)gridView:(BAGridView *)gridView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (NSInteger)gridView:(BAGridView *)gridView numberOfColumnsInRow:(NSInteger)row inSection:(NSInteger)section {
	return 3;
}

- (BAGridViewCell *)gridView:(BAGridView *)gridView cellAtIndexPath:(NSIndexPath *)indexPath {
	CGRect f = CGRectMake(0, 0, 100, 50);
	BAGridTestView *tv = nil;
	BAGridViewCell *cell = [gridView dequeueReusableCellWithIdentifier:@"GCell"];
	if (!cell) {
		cell = [[[BAGridViewCell alloc] initWithReuseIdentifier:@"GCell"] autorelease];
		cell.frame = f;
		tv = [[[BAGridTestView alloc] initWithFrame:f] autorelease];
		tv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		tv.contentMode = UIViewContentModeRedraw;
		[cell.contentView addSubview:tv];
	} else {
		tv = [cell.contentView.subviews objectAtIndex:0];
	}
	cell.frame = f;
	tv.sec = indexPath.gridSection;
	tv.row = indexPath.gridRow;
	tv.col = indexPath.gridColumn;
	[tv setNeedsDisplay];
	tv.backgroundColor = indexPath.gridSection % 2 ? [UIColor yellowColor] : [UIColor orangeColor];
	return cell;
}

@end
