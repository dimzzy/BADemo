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

#import "BAFormViewController.h"

@implementation BAFormViewController

@synthesize tableView = _tableView;

- (void)dealloc {
	self.tableView = nil;
	[_provider release];
	[super dealloc];
}

- (void)viewDidUnload {
	self.tableView = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.provider.model setObject:@"Janitor Junior" forKey:@"role"];
	self.tableView.dataSource = self.provider;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	_keyboardTracker = [[BAKeyboardTracker alloc] init];
	_keyboardTracker.scrollView = self.tableView;
}

- (void)viewDidDisappear:(BOOL)animated {
	[_keyboardTracker release];
	_keyboardTracker = nil;
	[super viewDidDisappear:animated];
}

- (BAFormProvider *)provider {
	if (!_provider) {
		_provider = [[BAFormProvider alloc] init];
		_provider.delegate = self;
		BAFormSectionDescriptor *sd1 = [[[BAFormSectionDescriptor alloc] init] autorelease];
		sd1.header = @"User";
		[_provider.sectionDescriptors addObject:sd1];
		BAFormSectionDescriptor *sd2 = [[[BAFormSectionDescriptor alloc] init] autorelease];
		sd2.header = @"Data";
		sd2.footer = @"Made with BaseAppKit";
		[_provider.sectionDescriptors addObject:sd2];
		{
			BAFormFieldDescriptor *fd = [[[BAFormFieldDescriptor alloc] init] autorelease];
			fd.identifier = @"fname";
			fd.name = @"First Name:";
			fd.placeholder = @"John";
			fd.type = BAFormFieldTypeText;
			[sd1.fieldDescriptors addObject:fd];
		}
		{
			BAFormFieldDescriptor *fd = [[[BAFormFieldDescriptor alloc] init] autorelease];
			fd.identifier = @"lname";
			fd.name = @"Last Name:";
			fd.placeholder = @"Smith";
			fd.type = BAFormFieldTypeText;
			[sd1.fieldDescriptors addObject:fd];
		}
		{
			BAFormFieldDescriptor *fd = [[[BAFormFieldDescriptor alloc] init] autorelease];
			fd.identifier = @"role";
			fd.name = @"Role:";
			fd.type = BAFormFieldTypeLabel;
			[sd1.fieldDescriptors addObject:fd];
		}
		{
			BAFormFieldDescriptor *fd = [[[BAFormFieldDescriptor alloc] init] autorelease];
			fd.identifier = @"note";
			fd.name = @"Note:";
			fd.type = BAFormFieldTypeText;
			[sd2.fieldDescriptors addObject:fd];
		}
		{
			BAFormFieldDescriptor *fd = [[[BAFormFieldDescriptor alloc] init] autorelease];
			fd.identifier = @"action";
			fd.name = @"Action:";
			fd.placeholder = @"Run";
			fd.type = BAFormFieldTypeButton;
			[sd2.fieldDescriptors addObject:fd];
		}
	}
	return _provider;
}

- (void)action {
	[[[[UIAlertView alloc] initWithTitle:@"Action"
								 message:@"Form Action"
								delegate:nil
					   cancelButtonTitle:@"OK"
					   otherButtonTitles:nil] autorelease] show];
}

- (void)decorateButtonFieldCell:(BAFormButtonFieldCell *)cell
					 descriptor:(BAFormFieldDescriptor *)descriptor
					  tableView:(UITableView *)tableView
{
	UIImage *image = [[UIImage imageNamed:@"form-button.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
	[cell.fieldButton setBackgroundImage:image forState:UIControlStateNormal];
	cell.fieldButton.titleLabel.textColor = [UIColor whiteColor];
	[cell.fieldButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
}

@end
