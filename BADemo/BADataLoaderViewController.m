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

#import "BADataLoaderViewController.h"

@implementation BADataLoaderViewController {
@private
	BADataLoader *_loader;
}

@synthesize linkView = _linkView, logView = _logView;

- (void)dealloc {
	[_loader release];
	self.linkView = nil;
	self.logView = nil;
	[super dealloc];
}

- (void)log:(NSString *)msg {
	NSUInteger len = [self.logView.text length];
	self.logView.text = [[self.logView.text stringByAppendingString:@"\n"] stringByAppendingString:msg];
	if ([msg length] > 0) {
		[self.logView scrollRangeToVisible:NSMakeRange(len, 1)];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.logView.text = @"";
}

- (IBAction)load {
	[self.linkView resignFirstResponder];
	self.logView.text = @"";
	NSURL *URL = [NSURL URLWithString:self.linkView.text];
	[self log:[NSString stringWithFormat:@"# load: %@", URL]];
	NSURLRequest *request = [BADataLoader GETRequestWithURL:URL];
	[_loader release];
	_loader = [[BADataLoader alloc] initWithRequest:request];
	_loader.delegate = self;
	[_loader startIgnoreCache:NO];
}

- (IBAction)reload {
	[self.linkView resignFirstResponder];
	self.logView.text = @"";
	NSURL *URL = [NSURL URLWithString:self.linkView.text];
	[self log:[NSString stringWithFormat:@"# reload: %@", URL]];
	NSURLRequest *request = [BADataLoader GETRequestWithURL:URL];
	[_loader release];
	_loader = [[BADataLoader alloc] initWithRequest:request];
	_loader.delegate = self;
	[_loader startIgnoreCache:YES];
}

- (IBAction)stopLoading {
	[self.linkView resignFirstResponder];
	[_loader release];
	_loader = nil;
}

- (void)loader:(BADataLoader *)loader didFinishLoadingData:(NSData *)data fromCache:(BOOL)fromCache {
	NSString *text = [[[NSString alloc] initWithData:data encoding:loader.dataEncoding] autorelease];
	[self log:[NSString stringWithFormat:@"# finished (from cache %d)\n%@", (int)fromCache, text]];
}

- (void)loader:(BADataLoader *)loader didFailWithError:(NSError *)error {
	[self log:[NSString stringWithFormat:@"# failed: %@", error]];
}

- (void)loaderDidReceiveResponse:(BADataLoader *)loader {
	[self log:[NSString stringWithFormat:@"# response received: %d", loader.HTTPResponse.statusCode]];
	[self log:[NSString stringWithFormat:@"Text encoding: %@", loader.HTTPResponse.textEncodingName]];
	[self log:[NSString stringWithFormat:@"MIME Type: %@", loader.HTTPResponse.MIMEType]];
}

- (void)loaderDidReceiveData:(BADataLoader *)loader {
	[self log:[NSString stringWithFormat:@"# data received (%d/%d)", loader.receivedBytesCount, loader.expectedBytesCount]];
}

@end
