//
//  TPAnkietyTVCell.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/11/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "QuestionnairesTVCell.h"

@interface QuestionnairesTVCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeToCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@end

@implementation QuestionnairesTVCell

- (void)setPoints:(NSNumber *)points
{
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", [points intValue]];
    _points = points;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    _title = title;
}

- (void)setAuthor:(NSString *)author
{
    self.authorLabel.text = [NSString stringWithFormat:@"Opublikowany przez: %@", author];
    _author = author;
}

- (void)setTimeToComplete:(NSNumber *)timeToComplete
{
    self.timeToCompleteLabel.text = [NSString stringWithFormat:@"Szacowany czas ukończenia: %d min", [timeToComplete intValue]];
    _timeToComplete = timeToComplete;
}

@end
