//
//  BADataLoaderViewController.m
//  BADemo
//
//  Created by Stadnik Dmitry on 1/13/12.
//  Copyright (c) 2012 BaseAppKit. All rights reserved.
//

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
