//
//  ABCQuestionVC.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface ABCQuestionVC : UIViewController

@property (nonatomic, strong) Question *question;
@property (nonatomic, strong) NSNumber *questionnaireID;
@property (nonatomic) NSUInteger questionNumber;

@end
