//
//  DJTrack.m
//  DJDemocracyServer
//
//  Created by Renan Greca on 2/11/14.
//
//

#import "DJTrack.h"

@implementation DJTrack
/*
+ (id) newTrackCalled:(NSString *)title by:(NSString *)artist at:(NSString *)location
{
    DJTrack *track =  [[self alloc] init];
    track.title = [NSString stringWithString:title];
    track.artist = [NSString stringWithString:artist];
    track.location = [NSString stringWithString:location];
    track.voteCount = 0;
    return track;
}*/

+ (id) decodeTrack:(NSString *)str {
    DJTrack *track =  [[self alloc] init];
    
    NSArray *array = [str componentsSeparatedByString:@";"];
    
    track.title = [array objectAtIndex:0];
    track.artist = [array objectAtIndex:1];
    track.location = [array objectAtIndex:2];
    if (array.count > 3) {
        track.voteCount = [[array objectAtIndex:3] intValue];
    } else track.voteCount = 0;
    return track;
    
}

- (void) incVoteCount {
    self->_voteCount = self->_voteCount + 1;
}

#pragma mark Setters

- (void) writeVoteCount:(NSInteger)voteCount {
    self->_voteCount = voteCount;
}

#pragma mark Getters

- (NSInteger) getVoteCount {
    return self->_voteCount;
}

- (NSString *) getTitle {
    return self.title;
}

- (NSString *) getArtist {
    return self.artist;
}

- (NSString *) getLocation {
    return self.location;
}

- (NSString *) encodeTrack {
    NSString* str = @"";
    //current method for compacting track to message
    if (self.title.length > 0) {
        str = [str stringByAppendingString:self.title ];
    }
    str = [str stringByAppendingString:@";"];
    if (self.artist.length > 0){
        str = [str stringByAppendingString:self.artist ];
    }
    str = [str stringByAppendingString:@";"];
    if (self.location.length > 0){
        str = [str stringByAppendingString:self.getLocation];
    }
    str = [str stringByAppendingString:@";"];
    //#warning find out what to do here
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%lu",(long)self.voteCount]];
    str = [str stringByAppendingString:@";"];
    return str;
}


@end
