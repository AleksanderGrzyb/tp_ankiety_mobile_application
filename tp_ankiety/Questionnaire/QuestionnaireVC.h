//
//  QuestionnaireVC.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "ViewPagerController.h"
#import "Questionnaire.h"

@protocol QuestionnaireVCDelegate <NSObject>

- (void)deleteQuestionnaireFromModel:(Questionnaire *)questionnaire;

@end

@interface QuestionnaireVC : ViewPagerController

@property (strong, nonatomic) Questionnaire *questionnaire;
@property (weak, nonatomic) id <QuestionnaireVCDelegate> delegateSecond;

@end
