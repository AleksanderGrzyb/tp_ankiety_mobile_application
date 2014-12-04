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

- (void)setPoints:(NSUInteger)points
{
    self.pointsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)points];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setAuthor:(NSString *)author
{
    self.authorLabel.text = [NSString stringWithFormat:@"Opublikowany przez: %@", author];
}

- (void)setTimeToComplete:(NSUInteger)timeToComplete
{
    self.timeToCompleteLabel.text = [NSString stringWithFormat:@"Szacowany czas ukończenia: %lu min", (unsigned long)timeToComplete];
}

@end
