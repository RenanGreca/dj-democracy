//
//  SongViewController.m
//  DJDemocracyClient
//
//  Created by Andrew Russell on 12/17/13.
//
//

#import "SongViewController.h"

@interface SongViewController ()
@property(nonatomic, retain) NSMutableArray *songs;
@end

@implementation SongViewController

@synthesize songs = _songs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) addSong:(NSString *)message {
    NSString *name = [[message componentsSeparatedByString:@";" ] objectAtIndex:0];
    NSLog(@"Adding song %@", name);
    [self.songs addObject:name];
    NSLog(@"Count of songs: %d", self.songs.count);
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = @"Service Browser";
    self.songs = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Songs Available";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Count of songs: %d", self.songs.count);
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    NSLog(@"Something something");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.text = [self.songs objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Send the song here
    //[self.server connectToRemoteService:[self.services objectAtIndex: indexPath.row]];
}

@end
