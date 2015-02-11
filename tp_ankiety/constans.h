//
//  constans.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 19/01/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#ifndef tp_ankiety_constans_h
#define tp_ankiety_constans_h

#define kBaseURL @"http://test.pleaserespond.me/"

#define kStarType @"ST"
#define kSingleChoiceType @"SC"
#define kMultipleChoiceType @"MC"
#define kRankType @"RK"

#define kAnswerIndex 0
#define kAnswerText 1
#define kAnswerValue 1

#define kAnswerIndexKey @"Index"
#define kAnswerValueKey @"Value"
#define kQuestionIDKey @"QuestionID"
#define kQuestionAnswersKey @"QuestionAnswers"

#define kInitialKey @"Initial"

#import <UIKit/UIKit.h>

@interface Constans : NSObject

+ (NSString *)userID;

@end

#endif
