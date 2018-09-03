//
//  GameOverViewController.h
//  BubblePop
//
//  Created by wYm on 07/05/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController

@property (weak, nonatomic) NSString * exchangeScore;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) NSString * exchangeName2;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;


@end
