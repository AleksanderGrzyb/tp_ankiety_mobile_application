//
//  QuestionnairesTVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/11/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "QuestionnairesTVC.h"
#import "QuestionnairesTVCell.h"

@interface QuestionnairesTVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation QuestionnairesTVC

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
    return 1.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionnairesTVCell *questionnairesCell = [tableView dequeueReusableCellWithIdentifier:@"questionnairescell"];
    return questionnairesCell;
}

@end
