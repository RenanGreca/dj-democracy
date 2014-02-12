//
//  DJTrack.h
//  DJDemocracyServer
//
//  Created by Renan Greca on 2/11/14.
//
//

#import <EyeTunes/EyeTunes.h>

@interface DJTrack : ETTrack {
    NSInteger voteCount;
}

- (id) initWithDescriptor:(AEDesc *)desc;

@end
