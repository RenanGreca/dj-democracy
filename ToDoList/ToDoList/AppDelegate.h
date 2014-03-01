//
//  AppDelegate.h
//  ToDoList
//
//  Created by Renan Greca on 11/30/13.
//  Copyright (c) 2013 Renan Greca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"
#import "ToDoListViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, ServerDelegate> {
    Server *_server;
    NSArray *servers;
    NSArray *playlist;
    UIStoryboard *main;
    ToDoListViewController *toDoListViewController;
}

@property (strong, nonatomic) UIWindow *window;

@end
