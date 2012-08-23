//
//  BANetworkReachabilityViewController.m
//  BADemo
//
//  Created by Dmitry Stadnik on 8/23/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

#import "BANetworkReachabilityViewController.h"
#import "BANetworkReachability.h"
#include <arpa/inet.h>

@interface BANetworkReachabilityViewController ()

@property(nonatomic, readonly) BANetworkReachability *nameReachability;
@property(nonatomic, readonly) BANetworkReachability *addrReachability;
@property(nonatomic, readonly) BANetworkReachability *inetReachability;
@property(nonatomic, readonly) BANetworkReachability *wifiReachability;

@end

@implementation BANetworkReachabilityViewController {
	BANetworkReachability *_nameReachability;
	BANetworkReachability *_addrReachability;
	BANetworkReachability *_inetReachability;
	BANetworkReachability *_wifiReachability;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:BANetworkReachabilityDidChangeNotification object:nil];
	[_nameReachability release];
	[_addrReachability release];
	[_inetReachability release];
	[_wifiReachability release];
    [_tableView release];
    [super dealloc];
}

- (BANetworkReachability *)nameReachability {
	if (!_nameReachability) {
		_nameReachability = [[BANetworkReachability reachabilityWithHostName:@"www.dimzzy.com"] retain];
		if ([_nameReachability start]) {
			NSLog(@"Started name reachability");
		}
	}
	return _nameReachability;
}

- (BANetworkReachability *)addrReachability {
	if (!_addrReachability) {
		struct sockaddr_in addr;
		bzero(&addr, sizeof(addr));
		addr.sin_len = sizeof(addr);
		addr.sin_family = AF_INET;
		inet_pton(AF_INET, "8.8.8.8", &addr.sin_addr);
		_addrReachability = [[BANetworkReachability reachabilityWithAddress:&addr] retain];
		if ([_addrReachability start]) {
			NSLog(@"Started addr reachability");
		}
	}
	return _addrReachability;
}

- (BANetworkReachability *)inetReachability {
	if (!_inetReachability) {
		_inetReachability = [[BANetworkReachability reachabilityForInternetConnection] retain];
		if ([_inetReachability start]) {
			NSLog(@"Started inet reachability");
		}
	}
	return _inetReachability;
}

- (BANetworkReachability *)wifiReachability {
	if (!_wifiReachability) {
		_wifiReachability = [[BANetworkReachability reachabilityForLocalWiFi] retain];
		if([_wifiReachability start]) {
			NSLog(@"Started wifi reachability");
		}
	}
	return _wifiReachability;
}

- (void)networkReachabilityDidChange:(NSNotification *)notification {
	if ([self isViewLoaded]) {
		[self.tableView reloadData];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(networkReachabilityDidChange:)
												 name:BANetworkReachabilityDidChangeNotification
											   object:nil];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:BANetworkReachabilityDidChangeNotification object:nil];
	self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		   cellForReachability:(BANetworkReachability *)reachability
						 label:(NSString *)label
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BANRCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BANRCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.detailTextLabel.font = [UIFont fontWithName:@"Courier" size:15];
	}
	NSMutableString *status = [NSMutableString string];
	[status appendString:label];
	[status appendString:@" ["];
	switch (reachability.currentStatus) {
		case BANetworkNotReachable:
			[status appendString:@"N/R"];
			break;
		case BANetworkReachableViaWiFi:
			[status appendString:@"WiFi"];
			break;
		case BANetworkReachableViaWWAN:
			[status appendString:@"WWAN"];
			break;
	}
	if (reachability.connectionRequired) {
		[status appendString:@" *"];
	}
	[status appendString:@"]"];
	cell.textLabel.text = status;
	cell.detailTextLabel.text = [reachability flagsString];
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		return [self tableView:tableView cellForReachability:self.nameReachability label:@"www.dimzzy.com"];
	} else if (indexPath.row == 1) {
		return [self tableView:tableView cellForReachability:self.addrReachability label:@"8.8.8.8"];
	} else if (indexPath.row == 2) {
		return [self tableView:tableView cellForReachability:self.inetReachability label:@"Internet"];
	} else if (indexPath.row == 3) {
		return [self tableView:tableView cellForReachability:self.wifiReachability label:@"Local WiFi"];
	} else {
		return nil;
	}
}

@end
