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
#import "BAProgressViewController.h"
#import "BAActivityViewController.h"
#import "BAGradientViewController.h"
#import "BAFormViewController.h"
#import "BAViewCookieViewController.h"

@implementation BADemoViewController

- (void)dealloc {
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	}
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Page Control";
			break;
		case 1:
			cell.textLabel.text = @"Progress View";
			break;
		case 2:
			cell.textLabel.text = @"Activity View";
			break;
		case 3:
			cell.textLabel.text = @"Gradient View";
			break;
		case 4:
			cell.textLabel.text = @"Form";
			break;
		case 5:
			cell.textLabel.text = @"View's Cookie";
			break;
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	NSString *title = cell.textLabel.text;
	switch (indexPath.row) {
		case 0: {
			BAPageControlViewController *controller = [[[BAPageControlViewController alloc] initWithNibName:@"BAPageControlViewController"
																									 bundle:nil] autorelease];
			controller.navigationItem.title = title;
			[self.navigationController pushViewController:controller animated:YES];
			break;
		}
		case 1: {
			BAProgressViewController *controller = [[[BAProgressViewController alloc] initWithNibName:@"BAProgressViewController"
																							   bundle:nil] autorelease];
			controller.navigationItem.title = title;
			[self.navigationController pushViewController:controller animated:YES];
			break;
		}
		case 2: {
			BAActivityViewController *controller = [[[BAActivityViewController alloc] initWithNibName:@"BAActivityViewController"
																							   bundle:nil] autorelease];
			controller.navigationItem.title = title;
			[self.navigationController pushViewController:controller animated:YES];
			break;
		}
		case 3: {
			BAGradientViewController *controller = [[[BAGradientViewController alloc] initWithNibName:@"BAGradientViewController"
																							   bundle:nil] autorelease];
			controller.navigationItem.title = title;
			[self.navigationController pushViewController:controller animated:YES];
			break;
		}
		case 4: {
			BAFormViewController *controller = [[[BAFormViewController alloc] initWithNibName:@"BAFormViewController"
																					   bundle:nil] autorelease];
			controller.navigationItem.title = title;
			[self.navigationController pushViewController:controller animated:YES];
			break;
		}
		case 5: {
			BAViewCookieViewController *controller = [[[BAViewCookieViewController alloc] initWithNibName:@"BAViewCookieViewController"
																					   bundle:nil] autorelease];
			controller.navigationItem.title = title;
			[self.navigationController pushViewController:controller animated:YES];
			break;
		}
	}
}

@end
