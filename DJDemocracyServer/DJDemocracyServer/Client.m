//
//  Client.m
//  DJDemocracyServer
//
//  Created by Mari Bennett on 4/23/14.
//
//

#import "Client.h"


@implementation Client

@synthesize currentService = _currentService;
@synthesize inputStream = _inputStream;
@synthesize outputStream = _outputStream;

- (id) initwithInput:(NSInputStream*) input andOutput: (NSOutputStream*) output{
    self = [super init];
    if(nil != self) {
        self.inputStream = input;
        self.outputStream = output;
        
    }
    return self;
};


@end
