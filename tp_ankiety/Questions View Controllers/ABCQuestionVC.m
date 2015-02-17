//
//  ABCQuestionVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "ABCQuestionVC.h"
#import "constans.h"
#import "Answer.h"

@interface ABCQuestionVC ()
@property (weak, nonatomic) UILabel *questionLabel;
@property (strong, nonatomic) NSString *questionText;
@property (strong, nonatomic) NSMutableDictionary *buttonsStates;
@end

@implementation ABCQuestionVC

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - 100, 100)];
    self.questionLabel = questionLabel;
    self.questionLabel.text = self.questionText;
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    self.questionLabel.numberOfLines = 0;
    [self.view addSubview:self.questionLabel];
    
    int offset = 0;
    for (Answer *answer in self.question.answers) {
        if (![answer.text isEqualToString:@""]) {
            UIImage *buttonImageUnmarked = [UIImage imageNamed:@"unmarked_choice"];
            UIImage *buttonImageMarked = [UIImage imageNamed:@"marked_choice"];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 120 + offset * 70, buttonImageUnmarked.size.width, buttonImageUnmarked.size.height)];
            [button setImage:buttonImageUnmarked forState:UIControlStateNormal];
            [button setImage:buttonImageMarked forState:UIControlStateSelected];
            button.tag = [answer.index integerValue];
            [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            [self.buttonsStates setObject:answer forKey:@(button.tag)];
            if ([answer.value isEqualToNumber:@(1)]) {
                button.selected = YES;
            }
            else {
                button.selected = NO;
            }
            
            UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(70 + buttonImageUnmarked.size.width, 120 + offset * 70, self.view.frame.size.width - (70 + buttonImageUnmarked.size.width), buttonImageUnmarked.size.height)];
            answerLabel.text = answer.text;
            [self.view addSubview:answerLabel];
            offset++;
        }
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadView
{
    [super loadView];
}

#pragma mark - 
#pragma mark Getters

- (NSMutableDictionary *)buttonsStates
{
    if (!_buttonsStates) {
        _buttonsStates = [NSMutableDictionary dictionary];
    }
    return _buttonsStates;
}

#pragma mark -
#pragma mark Setters

- (void)setQuestion:(Question *)question
{
    self.questionText = question.bodyText;
    self.questionLabel.text = self.questionText;
    _question = question;
}

#pragma mark - 
#pragma mark Actions

- (void)buttonSelected:(UIButton *)button
{
    NSInteger currentButtonTag = button.tag;
    if ([self.question.type isEqualToString:kSingleChoiceType]) {
        __weak ABCQuestionVC *weakSelf = self;
        [self.buttonsStates enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            Answer *answer = (Answer *)obj;
            NSNumber *tag = (NSNumber *)key;
            if ([answer.value integerValue] == 1) {
                for (UIView *view in weakSelf.view.subviews) {
                    if ([view isKindOfClass:[UIButton class]] && view.tag == [tag integerValue] && view.tag != currentButtonTag) {
                        UIButton *button = (UIButton *)view;
                        [button setSelected:NO];
                        answer.value = @(0);
                    }
                }
            }
        }];
        if (!button.selected) {
            [button setSelected:YES];
            Answer *answer = [self.buttonsStates objectForKey:@(currentButtonTag)];
            answer.value = @(1);
        }
    }
    else {
        if (!button.selected) {
            [button setSelected:YES];
            Answer *answer = [self.buttonsStates objectForKey:@(currentButtonTag)];
            answer.value = @(1);
        }
        else {
            [button setSelected:NO];
            Answer *answer = [self.buttonsStates objectForKey:@(currentButtonTag)];
            answer.value = @(0);
        }
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *questionsUD = [userDefaults arrayForKey:[NSString stringWithFormat:@"%d", [self.questionnaireID intValue]]];
    if (questionsUD) {
        NSMutableArray *newQuestionsUD = [NSMutableArray array];
        for (NSDictionary *questionUD in questionsUD) {
            if ([self.question.idNumber isEqualToNumber:[questionUD objectForKey:kQuestionIDKey]]) {
                NSMutableDictionary *newQuestionUD = [NSMutableDictionary dictionary];
                [newQuestionUD setObject:self.question.idNumber forKey:kQuestionIDKey];
                NSMutableArray *newAnswersUD = [NSMutableArray array];
                for (Answer *answer in self.question.answers) {
                    NSDictionary *newAnswerUD = @{kAnswerIndexKey : answer.index,
                                                  kAnswerValueKey : answer.value};
                    [newAnswersUD addObject:newAnswerUD];
                }
                [newQuestionUD setObject:newAnswersUD forKey:kQuestionAnswersKey];
                [newQuestionsUD addObject:newQuestionUD];
            }
            else {
                [newQuestionsUD addObject:questionUD];
            }
        }
        [userDefaults setObject:newQuestionsUD forKey:[NSString stringWithFormat:@"%d", [self.questionnaireID intValue]]];
    }
    [userDefaults synchronize];
}


@end
