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

#import "BARefreshHeaderViewController.h"

@implementation BARefreshHeaderViewController {
@private
	BARefreshHeaderView *_refreshHeaderView;
	BOOL _loading;
	BOOL _error;
}

@synthesize tableView = _tableView;

- (void)dealloc {
	self.tableView = nil;
	[_refreshHeaderView release];
	_refreshHeaderView = nil;
    [super dealloc];
}

- (void)contentDidChange:(NSTimer *)timer {
	_loading = NO;
	_error = !_error;
	[self.tableView reloadData];
	if (_error) {
		_refreshHeaderView.errorText = @"Network or service is unavailable.\nCheck settings and try again.";
		[_refreshHeaderView dataSourceDidFail:self.tableView];
	} else {
		_refreshHeaderView.errorText = nil;
		[_refreshHeaderView dataSourceDidFinishLoading:self.tableView];
	}
}

- (void)reload {
	_loading = YES;
	[NSTimer scheduledTimerWithTimeInterval:3
									 target:self
								   selector:@selector(contentDidChange:)
								   userInfo:nil
									repeats:NO];
}

- (void)extReload {
	[_refreshHeaderView dataSourceDidStartLoading:self.tableView];
	[self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
	[self reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	CGRect headerFrame = CGRectMake(0,
									0 - self.tableView.bounds.size.height,
									self.view.frame.size.width,
									self.tableView.bounds.size.height);
	_refreshHeaderView = [[BARefreshHeaderView alloc] initWithFrame:headerFrame];
	_refreshHeaderView.delegate = self;
	[self.tableView addSubview:_refreshHeaderView];
	_refreshHeaderView.backgroundColor = self.tableView.backgroundColor;
	_refreshHeaderView.lastUpdatedLabel.textColor = [UIColor grayColor];
	_refreshHeaderView.statusLabel.textColor = [UIColor blackColor];
	_refreshHeaderView.arrowImageLayer.contents = (id)[UIImage imageNamed:@"ba-refresh-black.png"].CGImage;
	_refreshHeaderView.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	[_refreshHeaderView refreshLastUpdatedDate];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
																							target:self
																							action:@selector(extReload)] autorelease];
}

#pragma mark -
#pragma mark Refresh Header Callbacks

- (void)refreshHeaderDidTriggerRefresh:(BARefreshHeaderView *)view {
	[self reload];
}

- (BOOL)refreshHeaderDataSourceLoading:(BARefreshHeaderView *)view {
	return _loading;
}

- (NSDate *)refreshHeaderDataSourceLastUpdated:(BARefreshHeaderView *)view {
	return [NSDate date];
}

#pragma mark -
#pragma mark Scroll View Callbacks

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[_refreshHeaderView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_refreshHeaderView scrollViewDidEndDragging:scrollView willDecelerate:(BOOL)decelerate];
}

#pragma mark -
#pragma mark Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }

	cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
	
    return cell;
}

@end
