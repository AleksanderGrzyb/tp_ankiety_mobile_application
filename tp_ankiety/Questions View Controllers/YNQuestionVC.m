//
//  YNQuestionVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "YNQuestionVC.h"

@interface YNQuestionVC ()
@property (weak, nonatomic) IBOutlet UILabel *bodyTextLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *answerSC;
@end

@implementation YNQuestionVC

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bodyTextLabel.text = self.bodyText;
    [self.answerSC setSelectedSegmentIndex:UISegmentedControlNoSegment];
}


#pragma mark -
#pragma mark Setters

- (void)setBodyText:(NSString *)bodyText
{
    self.bodyTextLabel.text = bodyText;
    _bodyText = bodyText;
}

@end
