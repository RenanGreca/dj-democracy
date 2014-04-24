//
//  Client.h
//  DJDemocracyServer
//
//  Created by Mari Bennett on 4/23/14.
//
//

#import <Foundation/Foundation.h>

@interface Client : NSObject{
    NSNetService *_currentService;
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
    
}

@property(nonatomic, retain) NSNetService *currentService;
@property(nonatomic, retain) NSInputStream *inputStream;
@property(nonatomic, retain) NSOutputStream *outputStream;


- (id) initwithInput:(NSInputStream*) input andOutput: (NSOutputStream*) output;

@end
