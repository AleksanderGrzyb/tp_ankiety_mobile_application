//
//  Questionnaire.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/11/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Questionnaire : NSObject

@property (strong, nonatomic) NSString *title; // eg. Transport Publiczny
@property (nonatomic) NSNumber *timeToComplete; // eg. 10 (in minutes)
@property (strong, nonatomic) NSString *author; // eg. MPK
@property (strong, nonatomic) NSArray *questions; // NSArray of NSDictionaries
@property (nonatomic) NSNumber *points; // Point for filling questionnaire

@end
