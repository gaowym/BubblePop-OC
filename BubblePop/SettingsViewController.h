//
//  Settings.h
//  BubblePop
//
//  Created by wYm on 29/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *bubbleNumLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UISlider *bubbleNumSl;
@property (weak, nonatomic) IBOutlet UISlider *timeSl;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
- (IBAction)didEnd:(id)sender;

@end
