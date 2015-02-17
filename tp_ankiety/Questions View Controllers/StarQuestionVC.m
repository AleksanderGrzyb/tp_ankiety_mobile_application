//
//  StarQuestionVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/01/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "StarQuestionVC.h"
#import "SAMStarListView.h"
#import "Answer.h"
#import "constans.h"

@interface StarQuestionVC () <SAMStarListViewDelegate>
@property (weak, nonatomic) UILabel *questionLabel;
@property (strong, nonatomic) NSString *questionText;
@property (weak, nonatomic) SAMStarListView *starListView;
@end

@implementation StarQuestionVC

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadView
{
    [super loadView];
    
    // Check how many stars to display
    unsigned int countOfStars = [self countOfStars];
    
    // Loading from model how many stars were selected before
    unsigned int countOfSelectedStars = [self countOfSelectedStars];
    
    // Initializing views
    SAMStarListView *starListView = [[SAMStarListView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 300, self.view.frame.size.width * 0.5, 40) count:countOfStars countOfSelected:countOfSelectedStars withStrokeColor:[UIColor colorWithRed:0.69 green:0.61 blue:0.28 alpha:1]];
    self.starListView = starListView;
    self.starListView.delegate = self;
    self.starListView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.starListView];
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - 100, 100)];
    self.questionLabel = questionLabel;
    self.questionLabel.text = self.questionText;
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    self.questionLabel.numberOfLines = 0;
    [self.view addSubview:self.questionLabel];
}

- (unsigned int)countOfStars
{
    if (self.question.answers.count <= 5 && self.question.answers.count > 0) {
        return (unsigned int)self.question.answers.count;
    }
    else {
        return 5;
    }
}

- (unsigned int)countOfSelectedStars
{
    for (Answer *answer in self.question.answers) {
        if ([answer.value isEqualToNumber:@(1)]) {
            if ([answer.index intValue] >= 0 && [answer.index intValue] < 5) {
                return [answer.index intValue] + 1;
            }
            else {
                return 0;
            }
        }
    }
    return 0;
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
#pragma mark SAMStarListView Delegate

- (void)wasTouched
{
    unsigned int countOfSelectedStars = (unsigned int)self.starListView.countOfSelected;
    
    if (countOfSelectedStars > 0 && countOfSelectedStars <= 5) {
        
        for (Answer *answer in self.question.answers) {
            if ([answer.index intValue] == countOfSelectedStars - 1) {
                answer.value = @(1);
            }
            else {
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
}

@end
