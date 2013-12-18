//
//  AppDelegate.h
//  DJDemocracyClient
//
//  Created by Andrew Russell on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@class ServerViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, ServerDelegate> {
    Server *_server;
    NSArray *servers;
    NSArray *playlist;
    UIWindow *window;
    UINavigationController *navigationController;
    IBOutlet ServerViewController *serverViewController;
    //IBOutlet ServerRunningViewController *serverRunningVC;
    //IBOutlet SongSelectionViewController *songSelectionVC;
}


@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;


@end
