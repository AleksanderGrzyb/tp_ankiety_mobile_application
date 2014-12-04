//
//  QuestionnairesTVCell.h
//  tp_ankiety
//
//  Created by Aleksander Grzyb on 26/11/14.
//  Copyright (c) 2014 Aleksander Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionnairesTVCell : UITableViewCell

@property (strong, nonatomic) NSString *title; // eg. Transport Publiczny
@property (nonatomic) NSUInteger timeToComplete; // eg. 10 (in minutes)
@property (strong, nonatomic) NSString *author; // eg. MPK
@property (nonatomic) NSUInteger points; // Point for filling questionnaire

@end
