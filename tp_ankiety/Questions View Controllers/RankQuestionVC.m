//
//  RankQuestionVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 11/02/15.
//  Copyright (c) 2015 Aleksander Grzyb. All rights reserved.
//

#import "RankQuestionVC.h"
#import "Answer.h"
#import "constans.h"

@interface RankQuestionVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UILabel *questionLabel;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *questionText;
@property (nonatomic) BOOL initialMove;
@end

@implementation RankQuestionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - 100, 100)];
    self.questionLabel = questionLabel;
    self.questionLabel.text = self.questionText;
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    self.questionLabel.numberOfLines = 0;
    [self.view addSubview:self.questionLabel];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, 44 * self.question.answers.count)];
    self.tableView = tableView;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.editing = YES;
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (Answer *answer in self.question.answers) {
        if ([answer.value isEqualToNumber:@(0)]) {
            answer.value = @([self.question.answers indexOfObject:answer] + 1);
        }
    }
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
#pragma mark Table View Delegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    for (Answer *answer in self.question.answers) {
        if ([answer.value intValue] != sourceIndexPath.row + 1) {
            if (destinationIndexPath.row - sourceIndexPath.row > 0) {
                
                // Swipe from up to down
                if ([answer.value intValue] > sourceIndexPath.row + 1 && [answer.value intValue] <= destinationIndexPath.row + 1) {
                    answer.value = @([answer.value intValue] - 1);
                }
            }
            else {
                
                // Swipe from down to up
                if ([answer.value intValue] >= destinationIndexPath.row + 1 && [answer.value intValue] < sourceIndexPath.row + 1) {
                    answer.value = @([answer.value intValue] + 1);
                }
            }
        }
        else {
            answer.value = @(destinationIndexPath.row + 1);
        }
    }
    [self.tableView reloadData];
    [self saveModel];
}

#pragma mark -
#pragma mark Model

- (void)saveModel
{
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

#pragma mark -
#pragma mark Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRows = 0;
    for (Answer *answer in self.question.answers) {
        if (![answer.text isEqualToString:@""]) {
            numberOfRows++;
        }
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"RankCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        
    }
    
    for (Answer *answer in self.question.answers) {
        if (indexPath.row + 1 == [answer.value intValue]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@", indexPath.row + 1, answer.text];
        }
    }
    
    return cell;
}

@end
