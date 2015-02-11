//
//  Answer.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 10/02/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "Answer.h"

@implementation Answer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.value = @(0);
        self.text = @"";
        self.index = @(0);
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Index: %@, Text: %@, Value: %@", self.index, self.text, self.value];
}

@end
