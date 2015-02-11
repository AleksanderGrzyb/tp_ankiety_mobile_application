//
//  QuestionnaireVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "QuestionnaireVC.h"
#import "ABCQuestionVC.h"
#import "StarQuestionVC.h"
#import "Question.h"
#import "constans.h"
#import "Answer.h"
#import <AFNetworking.h>

@interface QuestionnaireVC () <ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation QuestionnaireVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Wyślij" style:UIBarButtonItemStylePlain target:self action:@selector(sendPressed)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Private Methods

- (void)sendQuestionnaire
{
    NSURL *baseURL = [NSURL URLWithString:kBaseURL];
    NSDictionary *completedQuestionnaire = [self createJSON];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *postString = [NSString stringWithFormat:@"polls/%@/submitpoll/", [Constans userID]];
    [manager POST:postString parameters:completedQuestionnaire success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Networking Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [self.delegateSecond deleteQuestionnaireFromModel:self.questionnaire];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSDictionary *)createJSON
{
    NSMutableDictionary *answeredQuestionnaire = [NSMutableDictionary dictionary];
    [answeredQuestionnaire setObject:self.questionnaire.idNumber forKey:@"poll_id"];
    NSMutableArray *answeredQuestions = [NSMutableArray array];
    
    for (Question *question in self.questionnaire.questions) {
        NSMutableDictionary *answeredQuestion = [NSMutableDictionary dictionary];
        [answeredQuestion setObject:question.idNumber forKey:@"id"];
    
        NSMutableArray *answeredAnswers = [NSMutableArray array];
        
        int valueSum = 0;
        for (Answer *answer in question.answers) {
            valueSum += [answer.value intValue];
        }
        
        for (Answer *answer in question.answers) {
            NSMutableArray *answeredAnswer = [NSMutableArray array];
            answeredAnswer[kAnswerIndex] = answer.index;
            double correctValue = (double)[answer.value intValue] / (double)valueSum;
            answeredAnswer[kAnswerValue] = @(correctValue);
            [answeredAnswers addObject:[answeredAnswer copy]];
        }
        [answeredQuestion setObject:[answeredAnswers copy] forKey:@"answers"];
        
        [answeredQuestions addObject:[answeredQuestion copy]];
    }
    
    [answeredQuestionnaire setObject:[answeredQuestions copy] forKey:@"questions"];
    return [answeredQuestionnaire copy];
}

#pragma mark -
#pragma mark View Pager Data Source

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    return self.questionnaire.questions.count;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"Pytanie %lu", (unsigned long)index + 1];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    Question *question = [self.questionnaire.questions objectAtIndex:index];
    if ([question.type isEqualToString:kStarType]) {
        StarQuestionVC *questionVC = [[StarQuestionVC alloc] init];
        questionVC.question = question;
        questionVC.questionnaireID = self.questionnaire.idNumber;
        questionVC.questionNumber = index;
        return questionVC;
    }
    else {
        ABCQuestionVC *questionVC = [[ABCQuestionVC alloc] init];
        questionVC.question = question;
        questionVC.questionnaireID = self.questionnaire.idNumber;
        questionVC.questionNumber = index;
        return questionVC;
    }
}

#pragma mark -
#pragma mark Actions

- (void)sendPressed
{
    int numberOfQuestionsAnswered = 0;
    for (Question *question in self.questionnaire.questions) {
        BOOL answerCompleted = false;
        for (Answer *answer in question.answers) {
            if (![answer.value isEqualToNumber:@(0)]) {
                answerCompleted = true;
            }
        }
        if (answerCompleted) {
            numberOfQuestionsAnswered++;
        }
    }
    if (numberOfQuestionsAnswered == [self.questionnaire.questions count]) {
        [self sendQuestionnaire];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nie ukończono!" message:@"Odpowiedz na wszystkie pytania w ankiecie!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
