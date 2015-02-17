//
//  NSObject+constans.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/01/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "constans.h"

@implementation Constans

+ (NSString *)userID
{
    NSString *userID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    return [userID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return @"3";
}

@end
