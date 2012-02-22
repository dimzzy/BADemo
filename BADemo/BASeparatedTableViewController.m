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

#import "BASeparatedTableViewController.h"

@implementation BASeparatedTableViewController {
@private
	BASeparatedTableProvider *_provider;
}

@synthesize tableView = _tableView;

- (void)dealloc {
	self.tableView = nil;
	[_provider release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	_provider = [[BASeparatedTableProvider alloc] init];
	_provider.delegate = self;
	self.tableView.dataSource = _provider;
	self.tableView.delegate = _provider;
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Separators

- (BACellSeparatorPositions)tableView:(UITableView *)tableView separatorPositionsForRow:(NSIndexPath *)indexPath {
	return BACellSeparatorPositionBottom | BACellSeparatorPositionTop;
}

- (UITableViewCell *)tableView:(UITableView *)tableView topSeparatorCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyTopCell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:cellIdentifier] autorelease];
		cell.contentView.backgroundColor = [UIColor redColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView bottomSeparatorCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyBottomCell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:cellIdentifier] autorelease];
		cell.contentView.backgroundColor = [UIColor greenColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForTopSeparatorRowAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath.row + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForBottomSeparatorRowAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath.row + 1;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:cellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

@end
