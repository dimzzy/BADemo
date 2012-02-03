//
//  BASeparatedTableViewController.m
//  BADemo
//
//  Created by Stadnik Dmitry on 2/3/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

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
