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

#import "BADemoViewController.h"
#import "BAPageControlViewController.h"
#import "BAGroupedPageControlViewController.h"
#import "BAProgressViewController.h"
#import "BAActivityViewController.h"
#import "BAGradientViewController.h"
#import "BAFormViewController.h"
#import "BAViewCookieViewController.h"
#import "BASimpleEditableTableViewController.h"
#import "BALabelViewController.h"
#import "BASequenceControlViewController.h"
#import "BADaysViewController.h"
#import "BADataLoaderViewController.h"
#import "BAMeshViewController.h"
#import "BARefreshHeaderViewController.h"
#import "BASeparatedTableViewController.h"

@implementation BADemoViewController {
@private
	NSMutableArray *_labels;
	NSMutableArray *_controllerClasses;
}

- (void)dealloc {
	[_labels release];
	[_controllerClasses release];
    [super dealloc];
}

- (void)setupContent {
	_labels = [[NSMutableArray alloc] init];
	_controllerClasses = [[NSMutableArray alloc] init];

	[_labels addObject:@"Days"];
	[_controllerClasses addObject:@"BADaysViewController"];
	[_labels addObject:@"Data Loader"];
	[_controllerClasses addObject:@"BADataLoaderViewController"];
	[_labels addObject:@"Label"];
	[_controllerClasses addObject:@"BALabelViewController"];
	[_labels addObject:@"Refresh Header View"];
	[_controllerClasses addObject:@"BARefreshHeaderViewController"];
	[_labels addObject:@"Progress View"];
	[_controllerClasses addObject:@"BAProgressViewController"];
	[_labels addObject:@"Activity View"];
	[_controllerClasses addObject:@"BAActivityViewController"];
	[_labels addObject:@"Gradient View"];
	[_controllerClasses addObject:@"BAGradientViewController"];
	[_labels addObject:@"Mesh View"];
	[_controllerClasses addObject:@"BAMeshViewController"];
	[_labels addObject:@"Sequence Control"];
	[_controllerClasses addObject:@"BASequenceControlViewController"];
	[_labels addObject:@"Page Control"];
	[_controllerClasses addObject:@"BAPageControlViewController"];
	[_labels addObject:@"Grouped Page Control"];
	[_controllerClasses addObject:@"BAGroupedPageControlViewController"];
	[_labels addObject:@"View's Cookie"];
	[_controllerClasses addObject:@"BAViewCookieViewController"];
	[_labels addObject:@"Form"];
	[_controllerClasses addObject:@"BAFormViewController"];
	[_labels addObject:@"Separated Table"];
	[_controllerClasses addObject:@"BASeparatedTableViewController"];
	[_labels addObject:@"Editable Table"];
	[_controllerClasses addObject:@"BASimpleEditableTableViewController"];
}

- (NSArray *)labels {
	if (!_labels) {
		[self setupContent];
	}
	return _labels;
}

- (NSArray *)controllerClasses {
	if (!_controllerClasses) {
		[self setupContent];
	}
	return _controllerClasses;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self labels] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:@"Cell"] autorelease];
	}
	cell.textLabel.text = [[self labels] objectAtIndex:indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	NSString *title = cell.textLabel.text;
	NSString *controllerClassName = [[self controllerClasses] objectAtIndex:indexPath.row];
	Class controllerClass = NSClassFromString(controllerClassName);
	UIViewController *controller = [[[controllerClass alloc] initWithNibName:controllerClassName bundle:nil] autorelease];
	controller.navigationItem.title = title;
	[self.navigationController pushViewController:controller animated:YES];
}

@end
