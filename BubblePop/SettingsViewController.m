//
//  Settings.m
//  BubblePop
//
//  Created by wYm on 29/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int bubbleNum = self.bubbleNumSl.value;
    int time = self.timeSl.value;
    self.bubbleNumLb.text = [NSString stringWithFormat:@"%d",bubbleNum];
    self.timeLb.text = [NSString stringWithFormat:@"%ds",time];
    
    AudioServicesPlaySystemSound(1520);
    
    [self.bubbleNumSl addTarget:self action:@selector(updateValueNum:) forControlEvents:UIControlEventValueChanged];
    [self.timeSl addTarget:self action:@selector(updateValueTime:) forControlEvents:UIControlEventValueChanged];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"time"]) {
        self.timeSl.value = [[user objectForKey:@"time"] intValue];
        self.timeLb.text = [user objectForKey:@"time"];
    }
    if ([user objectForKey:@"num"]) {
        self.bubbleNumSl.value = [[user objectForKey:@"num"] intValue];
        self.bubbleNumLb.text = [user objectForKey:@"num"];
    }
    
    // Do any additional setup after loading the view.
}

- (void)updateValueNum:(UISlider*)bubbleNumSl {
    [self storeSettings];

    int bubbleNum = self.bubbleNumSl.value;
    if ([NSString stringWithFormat:@"%d",bubbleNum] != self.bubbleNumLb.text) {
        self.bubbleNumLb.text = [NSString stringWithFormat:@"%d",bubbleNum];
        AudioServicesPlaySystemSound(1520);
    }
}

- (void)updateValueTime:(UISlider*)timeSl {
    [self storeSettings];
    int time = self.timeSl.value;
    if ([NSString stringWithFormat:@"%ds",time] != self.timeLb.text) {
        self.timeLb.text = [NSString stringWithFormat:@"%ds",time];
        AudioServicesPlaySystemSound(1519);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    [self storeSettings];
    AudioServicesPlaySystemSound(1520);
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController * des = segue.destinationViewController;
    des.exchangeTime = [NSString stringWithFormat:@"%f",self.timeSl.value];
    des.exchangeBubbleNum = [NSString stringWithFormat:@"%f",self.bubbleNumSl.value];
    des.exchangeName = self.nameTf.text;
    //[ViewController setValue:textField1.textforKey:@"exchangeString"];
    
}
//- (IBAction)backBtn:(UIButton *)sender {
//    [self dismissViewControllerAnimated:true completion:nil];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didEnd:(id)sender {
    [self.nameTf resignFirstResponder];
}

- (IBAction)playBtn:(id)sender {
    [self storeSettings];
    }

/*
 * Store current slider value.
 */
-(void)storeSettings {
    [[NSUserDefaults standardUserDefaults] setValue:self.timeLb.text forKey:@"time"];
    [[NSUserDefaults standardUserDefaults] setValue:self.bubbleNumLb.text forKey:@"num"];
    [[NSUserDefaults standardUserDefaults] setValue:self.nameTf.text forKey:@"playername"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
