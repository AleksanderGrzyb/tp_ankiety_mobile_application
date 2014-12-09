//
//  QuestionnaireVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "QuestionnaireVC.h"
#import "ABCQuestionVC.h"
#import "Question.h"
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
    NSURL *baseURL = [NSURL URLWithString:@"http://10.42.0.1:8000"];
    NSDictionary *completedQuestionnaire = [self createJSON];
    NSLog(@"%@", [completedQuestionnaire description]);
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:@"/polls/QWERTY/submitpoll/" parameters:completedQuestionnaire success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Networking Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSDictionary *)createJSON
{
    NSMutableDictionary *answeredQuestionnaire = [NSMutableDictionary dictionary];
    NSMutableArray *answeredQuestions = [NSMutableArray array];
    for (Question *question in self.questionnaire.questions) {
        NSMutableDictionary *answeredQuestion = [NSMutableDictionary dictionary];
        [answeredQuestion setValue:question.idNumber forKey:@"id"];
        [answeredQuestion setValue:question.selectedAnswer forKey:@"answer"];
        [answeredQuestions addObject:answeredQuestion];
    }
    [answeredQuestionnaire setValue:[answeredQuestions copy] forKey:@"questions"];
    [answeredQuestionnaire setValue:self.questionnaire.idNumber forKey:@"id"];
    return [answeredQuestionnaire copy];
}

#pragma mark -
#pragma mark View Pager Data Source

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    return [self.questionnaire.questions count];
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
    ABCQuestionVC *questionVC = [[ABCQuestionVC alloc] init];
    Question *question = [self.questionnaire.questions objectAtIndex:index];
    questionVC.question = question;
    questionVC.questionnaireID = self.questionnaire.idNumber;
    questionVC.questionNumber = index;
    return questionVC;
}

#pragma mark -
#pragma mark Actions

- (void)sendPressed
{
    int numberOfQuestionsAnswered = 0;
    for (Question *question in self.questionnaire.questions) {
        if (![question.selectedAnswer isEqual: @(-1)]) {
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
