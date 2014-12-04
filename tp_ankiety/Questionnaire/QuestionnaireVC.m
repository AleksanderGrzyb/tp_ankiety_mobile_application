//
//  QuestionnaireVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "QuestionnaireVC.h"
#import "YNQuestionVC.h"
#import "Question.h"

@interface QuestionnaireVC () <ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation QuestionnaireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    label.text = [NSString stringWithFormat:@"Pytanie %lu", (unsigned long)index];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    YNQuestionVC *questionVC = [[YNQuestionVC alloc] init];
    Question *question = [self.questionnaire.questions objectAtIndex:index];
    questionVC.bodyText = question.bodyText;
    return questionVC;
}


@end
