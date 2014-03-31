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
@property (readwrite) BOOL canVote;

- (IBAction)unwindToOverview:(UIStoryboardSegue *)segue;
- (void) addSong:(NSString *)message;


NSInteger voteSort(id num1, id num2, void *context);

@end
