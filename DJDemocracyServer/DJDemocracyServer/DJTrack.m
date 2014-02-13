//
//  DJTrack.m
//  DJDemocracyServer
//
//  Created by Renan Greca on 2/11/14.
//
//

#import "DJTrack.h"

@implementation DJTrack

- (id) newTrackCalled:(NSString *)title by:(NSString *)artist at:(NSString *)location
{
    DJTrack *track =  [[self alloc] init];
}

#pragma mark Setters

- (void) setVoteCount:(NSInteger)voteCount {
    self->_voteCount = voteCount;
}

#pragma mark Getters

- (NSInteger) getVoteCount {
    return self->_voteCount;
}

@end
