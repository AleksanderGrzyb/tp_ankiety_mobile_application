//
//  StarQuestionVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/01/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "StarQuestionVC.h"
#import "SAMStarListView.h"

@interface StarQuestionVC () <SAMStarListViewDelegate>
@property (weak, nonatomic) UILabel *bodyTextLabel;
@property (weak, nonatomic) SAMStarListView *starListView;
@end

@implementation StarQuestionVC

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![self.question.selectedAnswer isEqual:@(-1)]) {
        self.starListView.countOfSelected = [self.question.selectedAnswer intValue];
    }
}

- (void)loadView
{
    [super loadView];
    SAMStarListView *starListView = [[SAMStarListView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 300, self.view.frame.size.width * 0.5, 40) count:5 countOfSelected:0 withStrokeColor:[UIColor colorWithRed:0.69 green:0.61 blue:0.28 alpha:1]];
    self.starListView = starListView;
    self.starListView.delegate = self;
    self.starListView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    [self.view addSubview:self.starListView];
    
    UILabel *bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 100, self.view.frame.size.width * 0.5, 200)];
    self.bodyTextLabel = bodyTextLabel;
    self.bodyTextLabel.numberOfLines = 0;
    self.bodyTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bodyTextLabel.text = self.question.bodyText;
    [self.bodyTextLabel sizeToFit];
    self.bodyTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.bodyTextLabel];
}

#pragma mark -
#pragma mark SAMStarListView Delegate

- (void)wasTouched
{
    self.question.selectedAnswer = @(self.starListView.countOfSelected);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *answersArray = [userDefaults arrayForKey:[NSString stringWithFormat:@"%d", [self.questionnaireID intValue]]];
    if (answersArray) {
        NSMutableArray *mutableAnswers = [answersArray mutableCopy];
        mutableAnswers[self.questionNumber] = @(self.starListView.countOfSelected);
        [userDefaults setObject:[mutableAnswers copy] forKey:[NSString stringWithFormat:@"%d", [self.questionnaireID intValue]]];
    }
    [userDefaults synchronize];
}

@end
