//
//  ViewController.h
//  DJDemocracyClient
//
//  Created by Andrew Russell on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@protocol UITableViewSource @end

@interface ViewController : UIViewController

@property (nonatomic, strong) Server *server;
@property (nonatomic, strong) NSMutableArray *services;

- (void)addServer:(NSNetService *)service moreComing:(BOOL)moreComing;
- (void)removeServer:(NSNetService *)service moreComing:(BOOL)moreComing;



@end