//
//  AppDelegate.m
//  DJDemocracyServer
//
//  Created by Mauricio Molina on 12/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.message = @"Message";
	connectedRow = -1;
	self.services = [[NSMutableArray alloc] init];
	
	/*NSString *type = @"TestingProtocol";
    
	_server = [[Server alloc] initWithProtocol:type];
    _server.delegate = self;
    
    NSError *error = nil;
    if(![_server start:&error]) {
        NSLog(@"error = %@", error);
    }*/
    
    [self showPlaylists];
    
    
}

- (void)showPlaylists; {
    EyeTunes *eyetunes = [EyeTunes sharedInstance];
    
    self.playlists = [[NSMutableArray alloc] init];
    self.playlists = [eyetunes userPlaylists]
    ;
    if (!self.playlists)
        return;
    
    //NSLog(self.playlists);
    
    /*NSLog(@"List of playlists:");
    for (id playlist in self.playlists) {
        //[self.playlists addObject:playlist];
        NSLog(@"Playlist: %@",[playlist name]);
    }*/
    
    //playlistTable = [[NSTableView alloc] init];
    
    selectedPlaylist = -1;
    
    [playlistTable reloadData];
    
    showingSongs = FALSE;
    
    /*NSLog(@"Track: %@",[currentTrack name]);
     NSLog(@"Artist: %@",[currentTrack albumArtist]);*/

}

- (void)showSongs; {
    //EyeTunes *eyetunes = [EyeTunes sharedInstance];
    
    //ETPlaylist *playlist = [self.playlists objectAtIndex:selectedPlaylist];

    //ETPlaylist *library = [eyetunes playlists];
    
    //ETTrack *track = [playlist.tracks firstObject];
    
    //NSLog([track getPropertyAsPathForDesc:pETTrackLocation]);
    
    //NSString *urlString = [NSString stringWithFormat:@"%@", [track getPropertyAsPathForDesc:pETTrackLocation]];
    //NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //[eyetunes addTrack:url toPlaylist:playlist];
    
    //[eyetunes playTrack:track];
    
    self.playlists = [[self.playlists objectAtIndex:selectedPlaylist] tracks];
    
    [playlistTable reloadData];
    
    showingSongs = TRUE;
    
    /*for (ETTrack *track in playlist.tracks) {
        
    }*/
    
}

/*- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self->inoutTrack = [decoder decodeObjectForKey:@"track"];
    }
    return self->inoutTrack;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self->inoutTrack forKey:@"track"];
}*/


- (IBAction)connectToService:(id)sender;
{
    NSLog(@"%d", (int) self.playlists.count);
	//[self.server connectToRemoteService:[self.services objectAtIndex:selectedRow]];
}

- (IBAction)sendText:(id)sender;
{
	NSData *data = [textToSend dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	[self.server sendData:data error:&error];
	
    //[self.server s ]
}

- (IBAction)sendSongs:(NSInteger)service; {
    EyeTunes *eyetunes = [EyeTunes sharedInstance];
    
    ETPlaylist *library = [eyetunes libraryPlaylist];
    NSError *error = nil;

    for (ETTrack *track in [library tracks]) {
        NSData *data = [[self encodeTrack:track] dataUsingEncoding:NSUTF8StringEncoding];
        
        
        //[encoder encodeObject:self->inoutTrack forKey:@"track"];
        //[NSKeyedArchiver archivedDataWithRootObject:track];
        
        //[[track name] dataUsingEncoding:NSUTF8StringEncoding];
        
        
        [self.server sendData:data error:&error];
    }
    
}

// Decodes a string into an ETTrack object we can use
- (ETTrack *)decodeTrack:(NSString *)str; {
    ETTrack *track = nil;
    
    NSArray *array = [str componentsSeparatedByString:@";"];
    
    track.name = [array objectAtIndex:0];
    track.artist = [array objectAtIndex:1];
    //track.location =
    
    return track;
    
}

// Encodes track title, artist and location into a string so we can send it to the client
- (NSString *)encodeTrack:(ETTrack *)track; {
    NSString *str = @"";
    
    str = [[str stringByAppendingString:track.name] stringByAppendingString:@";"];
    str = [[str stringByAppendingString:track.artist] stringByAppendingString:@";"];
    str = [[str stringByAppendingString:[track getPropertyAsPathForDesc:pETTrackLocation]] stringByAppendingString:@";"];
    
    return str;
}


- (IBAction)startServer:(id)sender; {
    if (selectedPlaylist == -1) {
        NSLog(@"Please select a playlist");
        return;
    }
    
    NSString *type = @"TestingProtocol";
    
    _server = [[Server alloc] initWithProtocol:type];
    _server.delegate = self;
    
    NSError *error = nil;
    if(![_server start:&error]) {
        NSLog(@"error = %@", error);
    }
    
    NSLog(@"Server started!");
    
}



#pragma mark -
#pragma mark Server delegate methods

- (void)serverRemoteConnectionComplete:(Server *)server
{
    NSLog(@"Connected to service");
	
	self.isConnectedToService = YES;
    
	connectedRow = selectedRow;
	[deviceTable reloadData];
    
    [self sendSongs:connectedRow];
}

- (void)serverStopped:(Server *)server
{
    NSLog(@"Disconnected from service");
    
	self.isConnectedToService = NO;
    
	connectedRow = -1;
	[deviceTable reloadData];
}

- (void)server:(Server *)server didNotStart:(NSDictionary *)errorDict
{
    NSLog(@"Server did not start %@", errorDict);
}

- (void)server:(Server *)server didAcceptData:(NSData *)data
{
    NSLog(@"Server did accept data %@", data);
    NSString *message = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    if(nil != message || [message length] > 0) {
        self.message = message;
        //NSLog(message);
    } else {
        self.message = @"no data received";
    }
}

- (void)server:(Server *)server lostConnection:(NSDictionary *)errorDict
{
	NSLog(@"Lost connection");
	
	self.isConnectedToService = NO;
	connectedRow = -1;
	[deviceTable reloadData];
}

- (void)serviceAdded:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Added a service: %@", [service name]);
	
    [self.services addObject:service];
    if(!more) {
        [deviceTable reloadData];
    }
}

- (void)serviceRemoved:(NSNetService *)service moreComing:(BOOL)more
{
	NSLog(@"Removed a service: %@", [service name]);
	
    [self.services removeObject:service];
    if(!more) {
        [deviceTable reloadData];
    }
}

#pragma mark -
#pragma mark NSTableView delegate methods

/*- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	if (rowIndex == connectedRow)
		[aCell setTextColor:[NSColor redColor]];
	else
		[aCell setTextColor:[NSColor blackColor]];
}*/

/*- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex
{
	return [[self.playlists objectAtIndex:rowIndex] name];
}*/

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (aTableView == playlistTable) {
        //NSLog(@"Count: %lu", (unsigned long)[self.playlists count]);
        return (int) [self.playlists count];
    }
    return (int) [self.services count];
    
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification;
{
    //NSLog([[aNotification object] identifier]);
    if ([[[aNotification object] identifier] isEqualToString:@"PlaylistsTable"] && !showingSongs) {
        //NSLog(@"Here2");
        selectedPlaylist = [[aNotification object] selectedRow];
        [self showSongs];
    }
	selectedRow = [[aNotification object] selectedRow];
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex {
    return YES;
}

/*- (NSString *)tableView:(NSTableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"title");
    return [[self.playlists sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}*/

- (NSTableCellView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    //NSLog(@"Here");
    //NSLog(@"%ld", (long)row);
    //NSLog([self.playlists firstObject]);
    //[self.playlists firstObject];
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    //[cellView setTitle:[array objectAtIndex:row]];
   
    //NSTextField *field;
    
    //[field setStringValue:[self.playlists objectAtIndex:row]];
    
    //[cellView setTextField:field];

    //return Nil;
    
    //NSLog(tableColumn.identifier);
    
    if( [tableColumn.identifier isEqualToString:@"Playlists"] )
    {
        cellView.textField.stringValue = [[self.playlists objectAtIndex:row] name ];
        return cellView;
    }
    
    if ( [tableColumn.identifier isEqualToString:@"Devices"] ) {
        cellView.textField.stringValue = [[self.services objectAtIndex:row] name];
        return cellView;
    }
    
    //cellView.textField.stringValue = [[self.playlists objectAtIndex:row] name ];
    return cellView;
}


@synthesize server = _server;
@synthesize services = _services;
@synthesize message = _message;
@synthesize isConnectedToService;

@end
