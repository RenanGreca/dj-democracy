//
//  AppDelegate.h
//  DJDemocracyServer
//
//  Created by Mauricio Molina on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Server.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, ServerDelegate> {
    IBOutlet NSTableView *tableView;
    NSWindow *window;
    Server *_server;
    NSMutableArray *_playlists;
    NSMutableArray *_services;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) Server *server;
@property (nonatomic, retain) NSMutableArray *playlists;
@property (nonatomic, retain) NSMutableArray *services;

- (IBAction)connectToService:(id)sender;
- (IBAction)sendSongs:(id)sender;


@end
