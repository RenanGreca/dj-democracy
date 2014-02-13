//
//  DJTrack.h
//  DJDemocracyServer
//
//  Created by Renan Greca on 2/11/14.
//
//

#import <Foundation/Foundation.h>
#import <EyeTunes/EyeTunes.h>

@interface DJTrack : NSObject

@property NSString *title;
@property NSString *artist;
@property NSString *location;
@property NSInteger voteCount;

- (id) newTrackCalled:(NSString *)title by:(NSString *)artist at:(NSString *)location;

- (NSInteger) getVoteCount;

- (void) setVoteCount:(NSInteger)voteCount;

@end
