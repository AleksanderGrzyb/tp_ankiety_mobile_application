//
//  Question.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "Question.h"

@implementation Question

#pragma mark -
#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedAnswer = @(-1);
    }
    return self;
}

@end
