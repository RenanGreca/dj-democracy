//
//  AppDelegate.h
//  DJDemocracyServer
//
//  Created by Mauricio Molina on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Server.h"
#import <EyeTunes/EyeTunes.h>


@interface AppDelegate : NSObject <NSApplicationDelegate, ServerDelegate> {
    IBOutlet NSTableView *playlistTable;
    IBOutlet NSTableView *deviceTable;
    NSWindow *window;
    Server *_server;
    NSMutableArray *_playlists;
    NSMutableArray *_services;
    NSString *textToSend, *_message;
	NSInteger selectedRow, connectedRow;
	BOOL isConnectedToService;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) Server *server;
@property (nonatomic, retain) NSMutableArray *playlists;
@property (nonatomic, retain) NSMutableArray *services;
@property(readwrite, copy) NSString *message;
@property(readwrite, nonatomic) BOOL isConnectedToService;



- (IBAction)connectToService:(id)sender;
- (IBAction)sendSongs:(id)sender;


@end
