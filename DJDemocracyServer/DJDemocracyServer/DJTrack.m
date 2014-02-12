//
//  DJTrack.m
//  DJDemocracyServer
//
//  Created by Renan Greca on 2/11/14.
//
//

#import "DJTrack.h"

@implementation DJTrack

- (id) initWithDescriptor:(AEDesc *)desc
{
    self = [super initWithDescriptor:desc];
    self->voteCount = 0;
    return self;
}

@end
