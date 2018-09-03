//
//  ScoreBoard.m
//  BubblePop
//
//  Created by wYm on 30/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import "ScoreBoardViewController.h"

@interface ScoreBoardViewController ()

@property NSMutableArray * scores;
@property NSMutableArray * names;

@property NSArray * reversedScores;
@property NSArray * reversedNames;

//@property NSArray * array;

@end

@implementation ScoreBoardViewController

- (void)viewDidLoad {
    
    //Read stored player names and their scores from disk.
    self.scores = [[NSMutableArray alloc] init];
    self.names = [[NSMutableArray alloc] init];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [self.scores addObjectsFromArray:(NSArray *)[user objectForKey:@"scoreboard"]];
    self.reversedScores = [[self.scores reverseObjectEnumerator] allObjects];
    [self.names addObjectsFromArray:(NSArray *)[user objectForKey:@"nameboard"]];
    self.reversedNames = [[self.names reverseObjectEnumerator] allObjects];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.reversedScores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    // Configure the cell...
    NSInteger row = indexPath.row;
    
    cell.textLabel.text = [self.reversedNames objectAtIndex:row];
    cell.detailTextLabel.text = [self.reversedScores objectAtIndex:row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
