//
//  TPAnkietyTVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/11/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "TPAnkietyTVC.h"
#import "TPAnkietyTVCell.h"

@interface TPAnkietyTVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TPAnkietyTVC

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
    TPAnkietyTVCell *ankietyCell = [tableView dequeueReusableCellWithIdentifier:@"ankietycell"];
    return ankietyCell;
}

@end
