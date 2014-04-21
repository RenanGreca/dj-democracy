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
    /*[self.songs addObject:[DJTrack newTrackCalled:@"Bohemian Rhapsody" by:@"Queen" at:@"..."]];
    [self.songs addObject:[DJTrack newTrackCalled:@"Let It Be" by:@"The Beatles" at:@"..."]];
    [self.songs addObject:[DJTrack newTrackCalled:@"Smoke on the Water" by:@"Deep Purple" at:@"..."]];
    [self.songs addObject:[DJTrack newTrackCalled:@"Hey Jude" by:@"The Beatles" at:@"..."]];
    [self.songs addObject:[DJTrack newTrackCalled:@"Lucy In The Sky With Diamonds" by:@"The Beatles" at:@"..."]];
    */
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
    self.canVote = YES;
    self.songs = [[NSMutableArray alloc] init];
    self.showAll = FALSE;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) addSong:(NSString *)message {
    DJTrack *track = [DJTrack decodeTrack:message];
    NSLog(@"Adding song %@", [track getTitle]);
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
 /*   if (section == 0) {
        if ([self.songs count] < 5)
            return [self.songs count];
        return [self.songs count];
    } */
    if (self.showAll == TRUE) {
        return [self.songs count];
    }else {
        
        return MIN([self.songs count], 5); //magic number
        };
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 60;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.canVote == NO) {
        [tableView deselectRowAtIndexPath:indexPath animated: NO];
    } else {
        NSError *error = nil;
        DJTrack *track = [self.songs objectAtIndex:indexPath.row];
        NSString* str = @"";
        
        [track incVoteCount];
        /*current method for compacting track to message
        str = [str stringByAppendingString:[track getTitle]];
        str = [str stringByAppendingString:@";"];
        str = [str stringByAppendingString:[track getArtist]];
        str = [str stringByAppendingString:@";"];
        str = [str stringByAppendingString:[track getLocation]];
        str = [str stringByAppendingString:@";"];
        //#warning find out what to do here
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%lu",(long)[track voteCount]]];
        str = [str stringByAppendingString:@";"]; */
    
        str = [track encodeTrack];
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
        NSLog(@"sending data %@", data);
        // where is the server?
        self.songs = [[NSMutableArray alloc] init];
    
        [tableView deselectRowAtIndexPath:indexPath animated: NO];
        [self.server sendData:data error:&error];
        self.canVote = NO;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SongCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    UILabel *voteCounter = (UILabel*) [cell viewWithTag:1];
    UILabel *trackTitle = (UILabel*) [cell viewWithTag:2];
    UILabel *artistName = (UILabel*) [cell viewWithTag:3];
    
    if ([self.songs count] > 0) {
    
        DJTrack *track = [self.songs objectAtIndex:indexPath.row];
        
        
        if (indexPath.section == 0) {
            //[voteCounter setText:[NSString stringWithFormat:@"%lu",(long)[track voteCount]]];
            //[trackTitle setText:[track title]];
            //[artistName setText:[track artist]];
            
            [voteCounter setText:[NSString stringWithFormat:@"%lu",(long)[track voteCount]]];
            [trackTitle setText:[track title]];
            [artistName setText:[track artist]];
            
            //cell.textLabel.text = [self.songs objectAtIndex:indexPath.row];
            //cell.detailTextLabel.text = @"Artist Name";
        
        } /*else {
            
            [voteCounter setText:@"0"];
            [trackTitle setText:@"Current Song"];
            [artistName setText:@"Artist Name"];
            cell.detailTextLabel.text = @"Artist Name";
             
        } */
    }
    
    
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
} */

- (void)setCanVote {
    self.canVote = TRUE;
}

- (IBAction)showAllSongs:(id)sender {
    UIButton *button = (UIButton*)sender;
    
    if (self.showAll == FALSE){
        [button setTitle:@"Top 5" forState:UIControlStateNormal];
        self.showAll = TRUE;
        self.tableTitle.text = @"All Songs";
        [self.tableView reloadData];
        
    }else {
        [button setTitle:@"All Songs" forState:UIControlStateNormal];
        self.showAll = FALSE;
        self.tableTitle.text = @"Top 5 Songs";
        [self.tableView reloadData];
    }
}

- (void)dealloc {
    [UITableView release];
    [super dealloc];
}
@end
