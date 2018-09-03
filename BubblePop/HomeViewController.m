//
//  BubbleView.m
//  BubblePop
//
//  Created by wYm on 29/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ImageSpring];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ImageSpring {
    [UIView animateWithDuration:2 animations:^{
        _logoImg.frame = CGRectMake(_logoImg.frame.origin.x, _logoImg.frame.origin.y-30, 240, 240);
    }];
    
    [UIView animateWithDuration:2 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _logoImg.frame = CGRectMake(_logoImg.frame.origin.x, _logoImg.frame.origin.y+30, 240, 240);
    } completion:^(BOOL finished) {
        [self ImageSpring];
    }];
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
