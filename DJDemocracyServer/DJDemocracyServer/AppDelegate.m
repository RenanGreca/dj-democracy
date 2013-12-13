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
    
    [self showPlaylists];
    
    
}

- (void)showPlaylists; {
    EyeTunes *eyetunes = [EyeTunes sharedInstance];
    NSArray *playlists = [eyetunes playlists];
    if (!playlists)
        return;
    
    NSLog(@"List of playlists:");
    for (id playlist in playlists) {
        [self.playlists addObject:playlist];
        NSLog(@"Playlist: %@",[playlist name]);
    }
    
    [playlistTable reloadData];
    
    /*NSLog(@"Track: %@",[currentTrack name]);
     NSLog(@"Artist: %@",[currentTrack albumArtist]);*/

}


- (IBAction)connectToService:(id)sender;
{
	[self.server connectToRemoteService:[self.services objectAtIndex:selectedRow]];
}

- (IBAction)sendText:(id)sender;
{
	NSData *data = [textToSend dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	[self.server sendData:data error:&error];
	
    //[self.server s ]
}

- (IBAction)sendSongs:(id)sender; {
    
}

#pragma mark -
#pragma mark Server delegate methods

- (void)serverRemoteConnectionComplete:(Server *)server
{
    NSLog(@"Connected to service");
	
	self.isConnectedToService = YES;
    
	connectedRow = selectedRow;
	[deviceTable reloadData];
}

- (void)serverStopped:(Server *)server
{
    NSLog(@"Disconnected from service");
    
	self.isConnectedToService = NO;
    
	connectedRow = -1;
	[deviceTable reloadData];
}

- (void)server:(Server *)server didNotStart:(NSDictionary *)errorDict
{
    NSLog(@"Server did not start %@", errorDict);
}

- (void)server:(Server *)server didAcceptData:(NSData *)data
{
    NSLog(@"Server did accept data %@", data);
    //NSString *message = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    /*if(nil != message || [message length] > 0) {
        self.message = message;
    } else {
        self.message = @"no data received";
    }*/
}

- (void)server:(Server *)server lostConnection:(NSDictionary *)errorDict
{
	NSLog(@"Lost connection");
	
	self.isConnectedToService = NO;
	connectedRow = -1;
	[deviceTable reloadData];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Added a service: %@", [service name]);
	
    [self.services addObject:service];
    if(!more) {
        [deviceTable reloadData];
    }
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Removed a service: %@", [service name]);
	
    [self.services removeObject:service];
    if(!more) {
        [deviceTable reloadData];
    }
}

@end
