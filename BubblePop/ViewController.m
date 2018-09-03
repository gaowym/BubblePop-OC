//
//  ViewController.m
//  BubblePop
//
//  Created by wYm on 28/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "ViewController.h"
#import "GameOverViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@property NSTimer * countdownTimer;

@property NSTimer * speedTimer;

@property NSTimer * gameTimer;

@property NSArray * bubbles;

@property UIColor * lastBubbleColor;

@property float count;

@property int time;

@property int time3s;

@property int screenWidth;

@property int screenHeight;

@property BOOL active;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //get current screen width and height inorder to init bubbles later.
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [self playBeepSound];
    
    //set the flashing count down 3, 2, 1 start at the beginning of play.
    self.time3s = 3;
    self.active = NO;
    self.bubbles = [NSArray arrayWithObjects: self.bubble1, self.bubble2, self.bubble3, self.bubble4, self.bubble5, self.bubble6, self.bubble7, self.bubble8, self.bubble9, self.bubble10, self.bubble11, self.bubble12, self.bubble13, self.bubble14, self.bubble15, nil];
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:0.8/1.0
                                                       target:self
                                                     selector:@selector(activeTimer)
                                                     userInfo:nil
                                                      repeats:YES];
}
    // Do any additional setup after loading the view, typically from a nib.

/*
 * Make the bubbles moving from top of the scren to bottom.
 */
- (void)animate {
    
    for (int i=0; i<[self.exchangeBubbleNum intValue]; i++) {
        UIButton * bubble0 = self.bubbles[i];
        int gameSpeed;
        
        if (self.time < [self.exchangeTime intValue]/10)
            gameSpeed = 3;
        else if (self.time < [self.exchangeTime intValue]/5)
            gameSpeed = 3;
        else if (self.time < [self.exchangeTime intValue]/3)
            gameSpeed = 2;
        else if (self.time < [self.exchangeTime intValue]/2)
            gameSpeed = 2;
        else if (self.time < [self.exchangeTime intValue]/1.5)
            gameSpeed = 1;
        else
            gameSpeed = 0;
            
            bubble0.frame = CGRectOffset(bubble0.frame, 0, self.speed.y + gameSpeed);
        if (!CGRectIntersectsRect(self.view.frame, bubble0.frame)) {
            int width = self.screenWidth - 60;
            int r = (arc4random() % width);
            bubble0.center = CGPointMake(r+30, -20);
            
            bubble0.hidden = NO;
            bubble0.layer.cornerRadius = 28;
            
            [self randomColor:bubble0];
            
            if (i < [self.exchangeBubbleNum intValue] - 1) {
                UIButton * lastBubble = self.bubbles[i+1];
                if(fabs(bubble0.center.x - lastBubble.center.x) < 50) {
                    if(bubble0.center.x < self.screenWidth/2){
                        bubble0.center = CGPointMake(bubble0.center.x + 100, bubble0.center.y);
                    } else {
                        bubble0.center = CGPointMake(bubble0.center.x - 100, bubble0.center.y);
                    }
                }
            } else {
                UIButton * lastBubble = self.bubbles[0];
                if(fabs(bubble0.center.x - lastBubble.center.x) < 50) {
                    if(bubble0.center.x < self.screenWidth/2){
                        bubble0.center = CGPointMake(bubble0.center.x + 100, bubble0.center.y);
                    } else {
                        bubble0.center = CGPointMake(bubble0.center.x - 100, bubble0.center.y);
                    }
                }
            }
        }
    }
}

/*
 * Control the flashing count down, active two timers and do some inits after the flashing count down.
 */
- (void)activeTimer {
    if (!self.active) {
        if (self.time3s > 1) {
            --self.time3s;
            
            [self playBeepSound];
            
            self.numberLb.text = [NSString stringWithFormat:@"%d",self.time3s];
        } else {
            self.active = YES;
            [self initBubbles];
            
            AudioServicesPlaySystemSound(1521);
            [self playSound];
            
            self.numberLb.hidden = YES;
            self.timeCountDownLb.hidden = NO;
            self.pointsLb.hidden = NO;
            self.pointsLb.text = [NSString stringWithFormat:@"%.1f",self.count];
            self.count = 0;
            self.speed = CGPointMake(3.0, 3.0);
            self.score1 = 0;
            self.time = [self.exchangeTime intValue];
            self.timeCountDownLb.text = [NSString stringWithFormat:@"%ds",self.time];
            self.speedTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0
                                                               target:self
                                                             selector:@selector(animate)
                                                             userInfo:nil
                                                              repeats:YES];
            self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1.0
                                                              target:self
                                                            selector:@selector(countDown)
                                                            userInfo:nil
                                                             repeats:YES];
        }
    } else {
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
    }
}

/*
 * Control the game time.
 */
- (void)countDown {
    if (self.time < 1) {
        for (int i=0; i<[self.exchangeBubbleNum intValue]; ++i) {
            UIButton * bubble0 = self.bubbles[i];
            bubble0.hidden = YES;
        }
        UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GameOverViewController * des = [mainStoryBoard instantiateViewControllerWithIdentifier:@"GameOverViewController"];
        des.exchangeScore = [NSString stringWithFormat:@"%.1f",self.count];
        des.exchangeName2 = self.exchangeName;
        [self.navigationController pushViewController:des animated:NO];
    } else if (self.time < 7){
        --self.time;
        [self playBeepSound];
        self.timeCountDownLb.textColor = [UIColor redColor];
        self.timeCountDownLb.text = [NSString stringWithFormat:@"%ds",self.time];
    } else {
        --self.time;
        self.timeCountDownLb.text = [NSString stringWithFormat:@"%ds",self.time];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    for (int i=0; i<[self.exchangeBubbleNum intValue]; ++i) {
        UIButton * bubble0 = self.bubbles[i];
        bubble0.hidden = YES;
    }
    self.time = 0;
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
 * Hide the bubbles when player press on them and add scores according to the colour.
 */
- (IBAction)bubble1Touched:(id)sender {
    UIButton * bubble0 = sender;
    bubble0.hidden = YES;
    
    [self playBubbleSound];
    
    float combo = 1;

    if (bubble0.layer.borderColor == CFBridgingRetain(self.lastBubbleColor))
        combo = 1.5;
    
    if (bubble0.layer.borderColor == [UIColor redColor].CGColor)
        self.count += 1 * combo;
    else if (bubble0.layer.borderColor == [UIColor blackColor].CGColor)
        self.count += 10 * combo;
    else if (bubble0.layer.borderColor == [UIColor greenColor].CGColor)
        self.count += 5 * combo;
    else if (bubble0.layer.borderColor == [UIColor blueColor].CGColor)
        self.count += 8 * combo;
    else
        self.count += 2 * combo;
    
    self.lastBubbleColor = CFBridgingRelease(bubble0.layer.borderColor);
    self.pointsLb.text = [NSString stringWithFormat:@"%.1f",self.count];
}

/*
 * Rearrange bubbles when orientation is changed.
 */
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    //get the screen width and height after the orientation changed.
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [self initBubbles];
}

/*
 * Init bubbles.
 */
-(void)initBubbles {
    int pos = -30;
    for (int i=0; i<[self.exchangeBubbleNum intValue]; i++) {
        UIButton * bubble0 = self.bubbles[i];
        int width = self.screenWidth - 60;
        int r = (arc4random() % width);
        bubble0.center = CGPointMake(r+30, pos);
        //bubble0.hidden = NO;
        bubble0.layer.cornerRadius = 28;
        
        [self randomColor:bubble0];
        
        if (i > 0) {
            UIButton * lastBubble = self.bubbles[i-1];
            if(fabs(bubble0.center.x - lastBubble.center.x) < 50) {
                if(bubble0.center.x < self.screenWidth/2){
                    bubble0.center = CGPointMake(bubble0.center.x + 100, bubble0.center.y);
                } else {
                    bubble0.center = CGPointMake(bubble0.center.x - 100, bubble0.center.y);
                }
            }
        } else {
            UIButton * lastBubble = self.bubbles[[self.exchangeBubbleNum intValue]-1];
            if(fabs(bubble0.center.x - lastBubble.center.x) < 50) {
                if(bubble0.center.x < self.screenWidth/2){
                    bubble0.center = CGPointMake(bubble0.center.x + 100, bubble0.center.y);
                } else {
                    bubble0.center = CGPointMake(bubble0.center.x - 100, bubble0.center.y);
                }
            }
        }
        
        if (self.screenHeight == 320)
            pos+=25;
        else if (self.screenHeight == 375)
            pos+=30;
        else if (self.screenHeight == 414)
            pos+=32;
        else if (self.screenHeight == 480)
            pos+=34;
        else if (self.screenHeight == 568)
            pos+=40;
        else if (self.screenHeight == 667)
            pos+=45;
        else if (self.screenHeight == 736)
            pos+=48;
        else if (self.screenHeight == 768)
            pos+=50;
        else if (self.screenHeight == 812) // iPhone X
            pos+=56;
        else
            pos+=70; // 7.9" & 9.7" iPad
    }
}

/*
 * set the colour to each bubble.
 */
-(void)randomColor:(UIButton *)bubble0 {
    int color = (arc4random() % 100);
    if (color <= 40)
        bubble0.layer.borderColor = [UIColor redColor].CGColor;
    else if (color <= 70)
        bubble0.layer.borderColor = [UIColor magentaColor].CGColor;
    else if (color <= 85)
        bubble0.layer.borderColor = [UIColor greenColor].CGColor;
    else if (color <= 95)
        bubble0.layer.borderColor = [UIColor blueColor].CGColor;
    else
        bubble0.layer.borderColor = [UIColor blackColor].CGColor;
    bubble0.layer.borderWidth = 3.5;
}

- (void) playBubbleSound {
    AudioServicesPlaySystemSound(1519);
    SystemSoundID soundFileObj;
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"wav"];
    NSURL *sourceUrl = [NSURL fileURLWithPath:sourcePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(sourceUrl), &soundFileObj);
    AudioServicesPlaySystemSound(soundFileObj);
}

- (void) playBeepSound {
    AudioServicesPlaySystemSound(1521);
    SystemSoundID soundFileObj;
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"];
    NSURL *sourceUrl = [NSURL fileURLWithPath:sourcePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(sourceUrl), &soundFileObj);
    AudioServicesPlaySystemSound(soundFileObj);
}

- (void) playSound {
    SystemSoundID soundFileObj;
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"wav"];
    NSURL *sourceUrl = [NSURL fileURLWithPath:sourcePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(sourceUrl), &soundFileObj);
    AudioServicesPlaySystemSound(soundFileObj);
}

@end
