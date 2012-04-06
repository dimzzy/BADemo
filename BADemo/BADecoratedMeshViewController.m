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

#import "BADecoratedMeshViewController.h"

@interface BADecoratedMeshTestView : UIView

@end


@implementation BADecoratedMeshTestView

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	[[UIColor blackColor] set];
	[[UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 0.5, 0.5)] stroke];
}

@end

@implementation BADecoratedMeshViewController {
@private
	NSMutableDictionary *_meshDecorationViews; // { section index:NSNumber -> decoration view:UIView }
}

@synthesize meshView = _meshView;

- (void)dealloc {
	self.meshView = nil;
	[_meshDecorationViews release];
    [super dealloc];
}

- (void)dumpSubviews:(UIView *)view withOffset:(NSString *)offset {
	NSMutableString *s = [NSMutableString string];
	[s appendString:offset];
	[s appendString:NSStringFromClass([view class])];
	[s appendString:@" : "];
//	[s appendString:NSStringFromCGRect(view.frame)];
	[s appendString:NSStringFromCGPoint(view.frame.origin)];
	NSLog(@"%@", s);
	for (UIView *subview in view.subviews) {
		[self dumpSubviews:subview withOffset:[offset stringByAppendingString:@"    "]];
	}
}

- (void)dumpContentViews1 {
	[self dumpSubviews:self.meshView withOffset:@""];
	NSLog(@"total: %d", [self.meshView.subviews count]);
}

- (void)dumpContentViews {
	[self.meshView reloadData];
	[self performSelector:@selector(dumpContentViews1) withObject:nil afterDelay:2];
}

- (UIView *)makeMeshDecorationView {
	UIImage *image = [UIImage imageNamed:@"mesh-decoration.png"];
	UIImageView *view = [[[UIImageView alloc] initWithImage:image] autorelease];
	return view;
}

- (void)updateMeshDecorationViews {
	if (!_meshDecorationViews) {
		_meshDecorationViews = [[NSMutableDictionary alloc] init];
	}
	NSIndexSet *visibleSections = [self.meshView indexesOfVisibleSections];
	[[_meshDecorationViews allKeys] enumerateObjectsUsingBlock:^(id sectionNumber, NSUInteger idx, BOOL *stop) {
		NSInteger section = [sectionNumber intValue];
		if (![visibleSections containsIndex:section]) {
			UIView *decorationView = [_meshDecorationViews objectForKey:sectionNumber];
			[decorationView removeFromSuperview];
			[_meshDecorationViews removeObjectForKey:sectionNumber];
		}
	}];
	[visibleSections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL *stop) {
		NSNumber *sectionNumber = [NSNumber numberWithInt:section];
		UIView *decorationView = [_meshDecorationViews objectForKey:sectionNumber];
		if (!decorationView) {
			decorationView = [self makeMeshDecorationView];
			[self.view insertSubview:decorationView aboveSubview:self.meshView];
			[_meshDecorationViews setObject:decorationView forKey:sectionNumber];
		}
		CGRect sectionRect = [self.meshView rectForSection:section];
		CGRect decorationFrame = decorationView.frame;
		decorationFrame.origin.x = sectionRect.origin.x + self.meshView.contentInset.left;
		decorationFrame.origin.y = sectionRect.origin.y - self.meshView.contentOffset.y;
		decorationView.frame = decorationFrame;
	}];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self updateMeshDecorationViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Dump"
//																			   style:UIBarButtonItemStylePlain
//																			  target:self
//																			  action:@selector(dumpContentViews)] autorelease];
	self.meshView = [[[BAMeshView alloc] initWithFrame:self.view.bounds] autorelease];
	self.meshView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.meshView.cellSize = CGSizeMake(40, 40);
	self.meshView.sectionHeaderHeight = 50;
	self.meshView.sectionFooterHeight = 50;
	self.meshView.backgroundColor = [UIColor grayColor];
	UILabel *headerLabel = [[[UILabel alloc] init] autorelease];
	headerLabel.font = [UIFont boldSystemFontOfSize:15];
	headerLabel.text = @"Mesh Header";
	self.meshView.meshHeaderView = headerLabel;
	UILabel *footerLabel = [[[UILabel alloc] init] autorelease];
	footerLabel.font = [UIFont boldSystemFontOfSize:15];
	footerLabel.text = @"Mesh Footer";
	self.meshView.meshFooterView = footerLabel;
	self.meshView.dataSource = self;
	self.meshView.delegate = self;
	[self.view addSubview:self.meshView];
	self.meshView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
	[self updateMeshDecorationViews];
}

- (NSInteger)numberOfSectionsInMeshView:(BAMeshView *)meshView {
	return 5;
}

- (NSInteger)meshView:(BAMeshView *)meshView numberOfCellsInSection:(NSInteger)section {
	return 15;
}

- (BAMeshViewCell *)meshView:(BAMeshView *)meshView cellAtIndexPath:(NSIndexPath *)indexPath {
	CGRect f = CGRectMake(0, 0, 80, 80);
	BADecoratedMeshTestView *tv = nil;
	BAMeshViewCell *cell = [meshView dequeueReusableCellWithIdentifier:@"ACell"];
	if (!cell) {
		cell = [[[BAMeshViewCell alloc] initWithReuseIdentifier:@"ACell"] autorelease];
		cell.frame = f;
		tv = [[[BADecoratedMeshTestView alloc] initWithFrame:f] autorelease];
		tv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		tv.contentMode = UIViewContentModeRedraw;
		[cell.contentView addSubview:tv];
	} else {
		tv = [cell.contentView.subviews objectAtIndex:0];
	}
	cell.frame = f;
	[tv setNeedsDisplay];
	tv.backgroundColor = indexPath.meshSection % 2 ? [UIColor yellowColor] : [UIColor orangeColor];
	return cell;
}

//- (CGFloat)meshView:(BAMeshView *)meshView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)meshView:(BAMeshView *)meshView heightForFooterInSection:(NSInteger)section;

- (BAMeshRowLayout)meshView:(BAMeshView *)meshView rowsLayoutInSection:(NSInteger)section {
	return BAMeshRowLayoutSpreadLeft;
}

//- (UIEdgeInsets)meshView:(BAMeshView *)meshView rowsInsetsInSection:(NSInteger)section {
//	return UIEdgeInsetsMake(0, 10, 0, 30);
//}

- (BAMeshCellAlignment)meshView:(BAMeshView *)meshView alignmentForCellAtIndexPath:(NSIndexPath *)indexPath {
	return BAMeshCellAlignmentCenter;
}

- (UIView *)meshView:(BAMeshView *)meshView viewForHeaderInSection:(NSInteger)section {
	UILabel *view = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	view.textAlignment = UITextAlignmentRight;
	view.text = [NSString stringWithFormat:@"Section Header %d", section];
	view.font = [UIFont boldSystemFontOfSize:15];
	view.backgroundColor = [UIColor magentaColor];
	return view;
}

- (UIView *)meshView:(BAMeshView *)meshView viewForFooterInSection:(NSInteger)section {
	UILabel *view = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
	view.textAlignment = UITextAlignmentRight;
	view.text = [NSString stringWithFormat:@"Section Footer %d", section];
	view.font = [UIFont boldSystemFontOfSize:15];
	view.backgroundColor = [UIColor greenColor];
	return view;
}

- (NSIndexPath *)meshView:(BAMeshView *)meshView willSelectCellAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (void)meshView:(BAMeshView *)meshView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"%d/%d", indexPath.meshSection, indexPath.meshCell);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end
