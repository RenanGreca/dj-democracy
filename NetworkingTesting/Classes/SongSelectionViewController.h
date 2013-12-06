//
//  SongSelectionViewController.h
//  NetworkingTesting
//
//  Created by Renan Greca on 12/6/13.
//
//

#import <UIKit/UIKit.h>
#import "Server.h"

@interface SongSelectionViewController : NSObject {
    Server *_server;
	NSMutableArray *_song;
}

@property(nonatomic, retain) Server *server;

- (void)addService:(NSNetService *)song moreComing:(BOOL)moreComing;
- (void)removeService:(NSNetService *)songs moreComing:(BOOL)moreComing;

@end