//
//  Question.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic) NSUInteger type;
@property (nonatomic, strong) NSString *bodyText;

@end
