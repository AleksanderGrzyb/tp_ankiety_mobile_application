//
//  StarQuestionVC.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/01/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface StarQuestionVC : UIViewController

@property (nonatomic, strong) Question *question;
@property (nonatomic, strong) NSNumber *questionnaireID;
@property (nonatomic) NSUInteger questionNumber;

@end
