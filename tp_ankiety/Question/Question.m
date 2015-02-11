//
//  Question.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "Question.h"
#import "Answer.h"

@implementation Question

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = @"";
        self.idNumber = @(0);
        self.bodyText = @"";
        self.answers = [NSArray array];
    }
    return self;
}

- (NSString *)description
{
    NSString *description = [NSString stringWithFormat:@"Type: %@, ID: %@, Text: %@", self.type, [self.idNumber description], self.bodyText];
    for (Answer *answer in self.answers) {
        description = [description stringByAppendingString:@"\n"];
        description = [description stringByAppendingString:[answer description]];
    }
    return description;
}

@end
