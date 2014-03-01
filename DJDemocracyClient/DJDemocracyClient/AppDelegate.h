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
@class SongViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, ServerDelegate> {
    Server *_server;
    NSArray *servers;
    NSArray *playlist;
    UIStoryboard *mainStoryboard;
    ServerViewController *serverViewController;
    UINavigationController *navController;
    //UIWindow *window;
    //UINavigationController *navigationController;
    //IBOutlet ServerViewController *serverViewController;
    //IBOutlet SongViewController *songViewController;
    //IBOutlet SongSelectionViewController *songSelectionVC;
}

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) IBOutlet UIWindow *window;
//@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;


@end
