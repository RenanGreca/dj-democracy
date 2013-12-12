//
//  AppDelegate.h
//  DJDemocracyClient
//
//  Created by Andrew Russell on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Server *_server;
@property (strong, nonatomic) NSArray *servers;
@property (strong, nonatomic) NSArray *playlist;
@property (strong, nonatomic) ViewController *serverViewController;

@end
