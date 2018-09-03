//
//  ViewController.h
//  BubblePop
//
//  Created by wYm on 28/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property int score1;
@property int score2;
@property CGPoint speed;
@property (weak, nonatomic) IBOutlet UIImageView *bubble;
@property (weak, nonatomic) IBOutlet UIButton *bubble1;
@property (weak, nonatomic) IBOutlet UIButton *bubble2;
@property (weak, nonatomic) IBOutlet UIButton *bubble3;
@property (weak, nonatomic) IBOutlet UIButton *bubble4;
@property (weak, nonatomic) IBOutlet UIButton *bubble5;
@property (weak, nonatomic) IBOutlet UIButton *bubble6;
@property (weak, nonatomic) IBOutlet UIButton *bubble7;
@property (weak, nonatomic) IBOutlet UIButton *bubble8;
@property (weak, nonatomic) IBOutlet UIButton *bubble9;
@property (weak, nonatomic) IBOutlet UIButton *bubble10;
@property (weak, nonatomic) IBOutlet UIButton *bubble11;
@property (weak, nonatomic) IBOutlet UIButton *bubble12;
@property (weak, nonatomic) IBOutlet UIButton *bubble13;
@property (weak, nonatomic) IBOutlet UIButton *bubble14;
@property (weak, nonatomic) IBOutlet UIButton *bubble15;

@property (weak, nonatomic) IBOutlet UILabel *pointsLb;

@property (weak, nonatomic) IBOutlet UILabel *timeCountDownLb;

@property (weak, nonatomic) NSString * exchangeTime;
@property (weak, nonatomic) NSString * exchangeBubbleNum;
@property (weak, nonatomic) NSString * exchangeName;
@property (weak, nonatomic) IBOutlet UILabel *numberLb;

@end

