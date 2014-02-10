//
//  ToDoItem.h
//  ToDoList
//
//  Created by Renan Greca on 2/6/14.
//  Copyright (c) 2014 Renan Greca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;

@property BOOL completed;

@property (readonly) NSDate *creationDate;

@end
