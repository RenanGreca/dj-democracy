//
//  AppDelegate.m
//  DJDemocracyServer
//
//  Created by Mauricio Molina on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.message = @"Message";
	connectedRow = -1;
	self.services = [[NSMutableArray alloc] init];
	
	NSString *type = @"TestingProtocol";
    
	_server = [[Server alloc] initWithProtocol:type];
    _server.delegate = self;
    
    NSError *error = nil;
    if(![_server start:&error]) {
        NSLog(@"error = %@", error);
    }
}

@end
