//
//  GameOverViewController.m
//  BubblePop
//
//  Created by wYm on 07/05/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@property NSMutableArray * scores;
@property NSMutableArray * names;

@end

@implementation GameOverViewController

- (void)viewDidLoad {
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"playername"]) {
        self.exchangeName2 = [user objectForKey:@"playername"];
    }
    if([self.exchangeName2 isEqual: @""])
        self.exchangeName2 = @"Unknow Player";
    self.scoreLb.text = [NSString stringWithFormat:@"Score: %@", self.exchangeScore];
    self.nameLb.text = [NSString stringWithFormat:@"Player: %@", self.exchangeName2];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    
    //Store player name and scores.
    self.scores = [[NSMutableArray alloc] init];
    self.names = [[NSMutableArray alloc] init];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"scoreboard"]) {
        [self.scores addObjectsFromArray:(NSArray *)[user objectForKey:@"scoreboard"]];
    }
    if ([user objectForKey:@"nameboard"]) {
        [self.names addObjectsFromArray:(NSArray *)[user objectForKey:@"nameboard"]];
    }
    [self.names addObject:[NSString stringWithFormat:@"%@", self.exchangeName2]];
    [[NSUserDefaults standardUserDefaults] setValue:self.names forKey:@"nameboard"];
    [self.scores addObject:[NSString stringWithFormat:@"%@", self.exchangeScore]];
    [[NSUserDefaults standardUserDefaults] setValue:self.scores forKey:@"scoreboard"];

    [[NSUserDefaults standardUserDefaults] synchronize];

    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
