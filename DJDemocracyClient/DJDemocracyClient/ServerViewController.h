//
//  ViewController.h
//  DJDemocracyClient
//
//  Created by Andrew Russell on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@interface ServerViewController : UITableViewController {
    Server *_server;
    NSMutableArray *_services;
}

@property (nonatomic, retain) Server *server;
//@property (nonatomic, retain) NSMutableArray *services;

- (void)addServer:(NSNetService *)service moreComing:(BOOL)moreComing;
- (void)removeServer:(NSNetService *)service moreComing:(BOOL)moreComing;

@end