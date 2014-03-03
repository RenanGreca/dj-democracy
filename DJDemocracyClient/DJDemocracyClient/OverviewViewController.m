//
//  OverviewViewController.m
//  DJDemocracyClient
//
//  Created by Oliver Seifert on 2/24/14.
//
//

#import "OverviewViewController.h"

@interface OverviewViewController ()

@property NSMutableArray *songs;

@end

@implementation OverviewViewController

- (void)loadInitialData {
    NSString *item1 = @"Bohemian Rhapsody";
    [self.songs addObject:item1];
    NSString *item2 = @"Let it Be";
    [self.songs addObject:item2];
    NSString *item3 = @"Smoke on the Water";
    [self.songs addObject:item3];
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Loading Overview");
    
    [super viewDidLoad];
    
    self.songs = [[NSMutableArray alloc] init];

    //[self loadInitialData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) addSong:(NSString *)message {
    NSArray *array = [message componentsSeparatedByString:@";" ];
    DJTrack *track = [DJTrack newTrackCalled:[array objectAtIndex:0] by:[array objectAtIndex:1] at:[array objectAtIndex:2]];
    [track setVoteCount:[[array objectAtIndex:3] intValue]];
    NSLog(@"Adding song %@", [track title]);
    
    [self.songs addObject:track];
    //NSLog(@"Count of songs: %d", self.songs.count);
    [self.tableView reloadData];
}

- (IBAction)unwindToOverview:(UIStoryboardSegue *)segue{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        if ([self.songs count] < 5)
            return [self.songs count];
        return 5;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Filling TableView");
    
    static NSString *CellIdentifier = @"SongCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    UILabel *voteCounter = (UILabel*) [cell viewWithTag:1];
    UILabel *trackTitle = (UILabel*) [cell viewWithTag:2];
    UILabel *artistName = (UILabel*) [cell viewWithTag:3];
    
    //if ([self.songs count] > 0) {
    
        DJTrack *track = [self.songs objectAtIndex:indexPath.row];
        
        
        if (indexPath.section == 0) {
            [voteCounter setText:[NSString stringWithFormat:@"%lu",(long)[track voteCount]]];
            [trackTitle setText:[track title]];
            [artistName setText:[track artist]];
            //cell.textLabel.text = [self.songs objectAtIndex:indexPath.row];
            //cell.detailTextLabel.text = @"Artist Name";
        
        } else {
            [voteCounter setText:@"1"];
            [trackTitle setText:@"Random Song"];
            [artistName setText:@"Artist Name"];
            cell.detailTextLabel.text = @"Artist Name";
        }
    //}
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)dealloc {
    [UITableView release];
    [super dealloc];
}
@end
