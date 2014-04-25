//
//  OverviewViewController.h
//  DJDemocracyClient
//
//  Created by Oliver Seifert on 2/24/14.
//
//

#import <UIKit/UIKit.h>
#include "DJTrack.h"
#include "Server.h"

@interface OverviewViewController : UITableViewController

@property (nonatomic, retain) Server *server;
@property (nonatomic, retain) IBOutlet UILabel *tableTitle;

@property (readwrite) BOOL canVote;
@property (readwrite) BOOL showAll;

- (IBAction)unwindToOverview:(UIStoryboardSegue *)segue;
- (IBAction)showAllSongs:(id)sender;
- (void) addSong:(NSString *)message;
- (void) flushList;
- (void) setCanVote;
@end
