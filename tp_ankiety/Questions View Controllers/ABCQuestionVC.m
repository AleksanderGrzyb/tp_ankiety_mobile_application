//
//  ABCQuestionVC.m
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 04/12/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import "ABCQuestionVC.h"

@interface ABCQuestionVC ()
@property (weak, nonatomic) UILabel *questionLabel;
@property (strong, nonatomic) NSString *questionText;
@end

@implementation ABCQuestionVC

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, self.view.frame.size.width - 50, 200)];
    self.questionLabel = questionLabel;
    self.questionLabel.text = self.questionText;
    self.questionLabel.numberOfLines = 0;
    [self.view addSubview:self.questionLabel];
    
}


#pragma mark -
#pragma mark Setters

- (void)setQuestion:(Question *)question
{
    self.questionText = question.bodyText;
    self.questionLabel.text = self.questionText;
    _question = question;
}

@end
