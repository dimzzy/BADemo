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

#import "BAPagerViewController.h"

@interface BAPageAssistant : NSObject <UITableViewDataSource>

@property(retain) NSString *name;
@property(retain) UITableView *tableView;

@end


@implementation BAPageAssistant {
@private
	NSString *_name;
}

@synthesize tableView = _tableView;

- (void)dealloc {
    [_name release];
    [super dealloc];
}

- (NSString *)name {
	return _name;
}

- (void)setName:(NSString *)name {
	if (_name == name) {
		return;
	}
	[_name release];
	_name = [name retain];
	[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 32;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"page"];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									   reuseIdentifier:@"page"] autorelease];
	}
	cell.textLabel.text = self.name;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
	return cell;
}

@end


@implementation BAPagerViewController {
@private
	BAPager *_pager;
	NSMutableArray *_assistants;
}

@synthesize scrollView = _scrollView;
@synthesize label = _label;

- (void)dealloc {
    [_pager release];
	[_scrollView release];
	[_label release];
	[_assistants release];
    [super dealloc];
}

- (void)updateLabel {
	self.label.text = [NSString stringWithFormat:@"%d / %d", _pager.currentPageIndex + 1, _pager.numberOfPages];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[_assistants release];
	_assistants = [[NSMutableArray alloc] init];
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"A Page";
		[_assistants addObject:assistant];
	}
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"B Page";
		[_assistants addObject:assistant];
	}
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"C Page";
		[_assistants addObject:assistant];
	}
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"D Page";
		[_assistants addObject:assistant];
	}
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"E Page";
		[_assistants addObject:assistant];
	}
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"F Page";
		[_assistants addObject:assistant];
	}
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"G Page";
		[_assistants addObject:assistant];
	}
	{
		BAPageAssistant *assistant = [[[BAPageAssistant alloc] init] autorelease];
		assistant.name = @"H Page";
		[_assistants addObject:assistant];
	}
	
	_pager = [[BAPager alloc] init];
	_pager.scrollView = self.scrollView;
	_pager.delegate = self;
	_pager.numberOfPages = [_assistants count];
	_pager.currentPageIndex = 0;
	
	[self updateLabel];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
										 duration:(NSTimeInterval)duration
{
	[_pager layoutPages];
}

- (UIView *)pager:(BAPager *)pager pageAtIndex:(NSInteger)index {
	NSLog(@"+ page %d", index);
	UITableView *tableView = [[[UITableView alloc] initWithFrame:self.scrollView.bounds
														   style:UITableViewStylePlain] autorelease];
	BAPageAssistant *assistant = [_assistants objectAtIndex:index];
	assistant.tableView = tableView;
	tableView.dataSource = assistant;
	return tableView;
}

- (void)pager:(BAPager *)pager dropPageAtIndex:(NSInteger)index {
	NSLog(@"- page %d", index);
	BAPageAssistant *assistant = [_assistants objectAtIndex:index];
	assistant.tableView = nil;
}

- (void)pager:(BAPager *)pager currentPageDidChangeTo:(NSInteger)index {
	[self updateLabel];
}

@end
