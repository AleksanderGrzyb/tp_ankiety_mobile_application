//
//  QuestionnairesTVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/11/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "QuestionnairesTVC.h"
#import "QuestionnaireVC.h"
#import "QuestionnairesTVCell.h"
#import "Questionnaire.h"
#import "Question.h"

@interface QuestionnairesTVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *questionnaires;
@end

@implementation QuestionnairesTVC

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addFakeData];
}

#pragma mark -
#pragma mark Getters

- (NSMutableArray *)questionnaires
{
    if (!_questionnaires) {
        _questionnaires = [[NSMutableArray alloc] init];
    }
    return _questionnaires;
}

#pragma mark -
#pragma mark Private Methods

- (void)addFakeData
{
    Questionnaire *questionnarie1 = [[Questionnaire alloc] init];
    questionnarie1.title = @"Nibh Ligula";
    questionnarie1.timeToComplete = 10;
    questionnarie1.author = @"Justo";
    questionnarie1.points = 24;
    NSMutableArray *questionnarie1Questions = [[NSMutableArray alloc] init];
    Question *question1 = [[Question alloc] init];
    question1.bodyText = @"Maecenas faucibus mollis interdum. Maecenas sed diam eget risus varius blandit sit amet non magna. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.";
    question1.type = 0;
    Question *question2 = [[Question alloc] init];
    question2.bodyText = @"Nullam quis risus eget urna mollis ornare vel eu leo. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.";
    question2.type = 0;
    [questionnarie1Questions addObject:question1];
    [questionnarie1Questions addObject:question2];
    questionnarie1.questions = [questionnarie1Questions copy];
    
    Questionnaire *questionnarie2 = [[Questionnaire alloc] init];
    questionnarie2.title = @"Sem Inceptos Fringilla";
    questionnarie2.timeToComplete = 15;
    questionnarie2.author = @"Lorem Dolor";
    questionnarie2.points = 5;
    NSMutableArray *questionnarie2Questions = [[NSMutableArray alloc] init];
    Question *question11 = [[Question alloc] init];
    question11.bodyText = @"Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Curabitur blandit tempus porttitor. Nullam quis risus eget urna mollis ornare vel eu leo. Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    question11.type = 0;
    Question *question22 = [[Question alloc] init];
    question22.bodyText = @"Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum.";
    question22.type = 0;
    [questionnarie2Questions addObject:question11];
    [questionnarie2Questions addObject:question22];
    questionnarie2.questions = [questionnarie2Questions copy];
    
    [self.questionnaires addObject:questionnarie1];
    [self.questionnaires addObject:questionnarie2];
}

#pragma mark -
#pragma mark Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questionnaires count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionnairesTVCell *questionnairesCell = [tableView dequeueReusableCellWithIdentifier:@"questionnairescell"];
    Questionnaire *questionnaire = [self.questionnaires objectAtIndex:indexPath.row];
    questionnairesCell.author = questionnaire.author;
    questionnairesCell.timeToComplete = questionnaire.timeToComplete;
    questionnairesCell.title = questionnaire.title;
    questionnairesCell.points = questionnaire.points;
    
    return questionnairesCell;
}

#pragma mark -
#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"questionnaire"]) {
        QuestionnaireVC *questionnaireVC = (QuestionnaireVC *)segue.destinationViewController;
        questionnaireVC.questionnaire = [self.questionnaires objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

@end
