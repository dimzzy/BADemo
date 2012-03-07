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

#import "BAMeshViewController.h"

@interface BAmeshTestView : UIView

@property int sec, cell;

@end


@implementation BAmeshTestView

@synthesize sec, cell;

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	[[UIColor blackColor] set];
	[[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 0.5, 0.5)] stroke];
	NSString *s = [NSString stringWithFormat:@"%d:%d", self.sec, self.cell];
	UIFont *font = [UIFont systemFontOfSize:13];
	CGSize ss = [s sizeWithFont:font];
	CGRect sr = CGRectMake((self.bounds.size.width - ss.width) / 2,
						   (self.bounds.size.height - ss.height) / 2,
						   ss.width, ss.height);
	[s drawInRect:sr withFont:font];
}

@end


@implementation BAMeshViewController

@synthesize meshView = _meshView;

- (void)dealloc {
	self.meshView = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.meshView = [[[BAMeshView alloc] initWithFrame:self.view.bounds] autorelease];
	self.meshView.dataSource = self;
	self.meshView.delegate = self;
	self.meshView.cellSize = CGSizeMake(80, 30);
	self.meshView.sectionHeaderHeight = 30;
	self.meshView.sectionFooterHeight = 50;
	self.meshView.backgroundColor = [UIColor grayColor];
	[self.view addSubview:self.meshView];
}

- (NSInteger)numberOfSectionsInMeshView:(BAMeshView *)meshView {
	return 4;
}

- (NSInteger)meshView:(BAMeshView *)meshView numberOfCellsInSection:(NSInteger)section {
	return 15;
}

- (BAMeshViewCell *)meshView:(BAMeshView *)meshView cellAtIndexPath:(NSIndexPath *)indexPath {
	CGRect f = CGRectMake(0, 0, 100, 50);
	BAmeshTestView *tv = nil;
	BAMeshViewCell *cell = [meshView dequeueReusableCellWithIdentifier:@"ACell"];
	if (!cell) {
		cell = [[[BAMeshViewCell alloc] initWithReuseIdentifier:@"ACell"] autorelease];
		cell.frame = f;
		tv = [[[BAmeshTestView alloc] initWithFrame:f] autorelease];
		tv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		tv.contentMode = UIViewContentModeRedraw;
		[cell.contentView addSubview:tv];
	} else {
		tv = [cell.contentView.subviews objectAtIndex:0];
	}
	cell.frame = f;
	tv.sec = indexPath.meshSection;
	tv.cell = indexPath.meshCell;
	[tv setNeedsDisplay];
	tv.backgroundColor = indexPath.meshSection % 2 ? [UIColor yellowColor] : [UIColor orangeColor];
	return cell;
}

//- (CGFloat)meshView:(BAMeshView *)meshView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)meshView:(BAMeshView *)meshView heightForFooterInSection:(NSInteger)section;

- (CGSize)meshView:(BAMeshView *)meshView sizeForCellAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(70, 20 + 10 * indexPath.meshCell);
}

- (BAMeshRowLayout)meshView:(BAMeshView *)meshView rowsLayoutInSection:(NSInteger)section {
	if (section == 0) {
		return BAMeshRowLayoutSpread;
	} else if (section == 1) {
		return BAMeshRowLayoutCenter;
	} else if (section == 2) {
		return BAMeshRowLayoutAlignLeft;
	} else {
		return BAMeshRowLayoutAlignRight;
	}
}

- (BAMeshCellAlignment)meshView:(BAMeshView *)meshView alignmentForCellAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return BAMeshCellAlignmentCenter;
	} else if (indexPath.section == 1) {
		return BAMeshCellAlignmentTop;
	} else {
		return BAMeshCellAlignmentBottom;
	}
}

- (UIView *)meshView:(BAMeshView *)meshView viewForHeaderInSection:(NSInteger)section {
	UILabel *view = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	view.text = [NSString stringWithFormat:@"Section Header %d", section];
	view.font = [UIFont systemFontOfSize:13];
	view.backgroundColor = [UIColor magentaColor];
	return view;
}

- (UIView *)meshView:(BAMeshView *)meshView viewForFooterInSection:(NSInteger)section {
	UILabel *view = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	view.text = [NSString stringWithFormat:@"Section Footer %d", section];
	view.font = [UIFont boldSystemFontOfSize:13];
	view.backgroundColor = [UIColor greenColor];
	return view;
}

@end
