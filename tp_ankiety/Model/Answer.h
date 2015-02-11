//
//  Answer.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 10/02/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (strong, nonatomic) NSNumber *index;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSNumber *value;

@end
