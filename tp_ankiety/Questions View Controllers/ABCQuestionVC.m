//
//  ABCQuestionVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "ABCQuestionVC.h"

@interface ABCQuestionVC ()
@property (weak, nonatomic) IBOutlet UILabel *bodyTextLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *answerSC;
@end

@implementation ABCQuestionVC

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bodyTextLabel.text = self.question.bodyText;
    [self.answerSC removeAllSegments];
    for (NSString *answer in self.question.answers) {
        [self.answerSC insertSegmentWithTitle:answer atIndex:[self.question.answers indexOfObject:answer] animated:NO];
    }
    [self.answerSC setSelectedSegmentIndex:UISegmentedControlNoSegment];
}


#pragma mark -
#pragma mark Setters

- (void)setQuestion:(Question *)question
{
    self.bodyTextLabel.text = question.bodyText;
    [self.answerSC removeAllSegments];
    for (NSString *answer in question.answers) {
        [self.answerSC insertSegmentWithTitle:answer atIndex:[question.answers indexOfObject:answer] animated:NO];
    }
    _question = question;
}

@end
