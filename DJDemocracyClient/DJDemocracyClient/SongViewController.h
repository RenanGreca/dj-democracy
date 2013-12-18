//
//  SongViewController.h
//  DJDemocracyClient
//
//  Created by Andrew Russell on 12/17/13.
//
//

#import <UIKit/UIKit.h>

@class Server;

@interface SongViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *_songs;
}

- (void) addSong:(NSString*) message;

//@property (strong, nonatomic) NSMutableArray *songs;



@end
