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

#import "BASimpleEditableTableViewController.h"
#import "BACommon.h"
#import "BAEditableCell.h"

@implementation BASimpleEditableTableViewController

@synthesize tableView, email, password;

- (void)unloadViews {
	self.tableView = nil;
}

- (void)dealloc {
	[self unloadViews];
	self.email = nil;
	self.password = nil;
	[super dealloc];
}

- (void)viewDidUnload {
	[self unloadViews];
    [super viewDidUnload];
}

+ (BOOL)validEmail:(NSString *)email {
	NSRegularExpression *regexpObject = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
																				  options:0
																					error:NULL];
	NSRange range = [regexpObject rangeOfFirstMatchInString:email
													options:0
													  range:NSMakeRange(0, [email length])];
	if (range.location == NSNotFound || range.length != [email length]) {
		return NO;
	}
	return YES;
}

- (BOOL)validateForm {
	if (!self.email || [self.email length] == 0) {
		BAAlert(@"Error", @"Email is not specified.");
		return NO;
	}
	if (![[self class] validEmail:self.email]) {
		BAAlert(@"Error", @"Email is not valid.");
		return NO;
	}
	if (!self.password || [self.password length] == 0) {
		BAAlert(@"Error", @"Password is not specified.");
		return NO;
	}
	return YES;
}

- (void)doLogin {
	[BAEditableCell stopEditing:self.tableView];
	if ([self validateForm]) {
		NSString *msg = [NSString stringWithFormat:@"%@ / %@", self.email, self.password];
		BAAlert(@"", msg);
	}
}

- (void)textDidChange:(UITextField *)textField {
	if (textField.tag == 0) {
		self.email = textField.text;
	} else if (textField.tag == 1) {
		self.password = textField.text;
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Login";
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																							target:self
																							action:@selector(doLogin)] autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewA {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableViewA numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Account Information";
}

- (UITableViewCell *)tableView:(UITableView *)tableViewA cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	BAEditableCell *cell = (BAEditableCell *)[tableViewA dequeueReusableCellWithIdentifier:@"LoginCell"];
	if (!cell) {
		cell = [[[BAEditableCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:@"LoginCell"] autorelease];
	}
	cell.textField.delegate = self;
	[cell.textField removeTarget:nil action:NULL forControlEvents:UIControlEventEditingChanged];
	[cell.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Email";
		cell.detailTextLabel.text = nil;
		cell.textField.placeholder = @"Your Email";
		cell.textField.text = self.email;
		cell.textField.secureTextEntry = NO;
		cell.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
		cell.textField.tag = indexPath.row;
	} else if (indexPath.row == 1) {
		cell.textLabel.text = @"Password";
		cell.detailTextLabel.text = nil;
		cell.textField.placeholder = @"Your Password";
		cell.textField.text = self.password;
		cell.textField.secureTextEntry = YES;
		cell.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		cell.textField.keyboardType = UIKeyboardTypeDefault;
		cell.textField.tag = indexPath.row;
	}
	return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

@end
