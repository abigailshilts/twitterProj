//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"

//delete detailsveiwcontrollerdelegatestuff
@interface TimelineViewController () <DetailsViewControllerDelegate, TweetCellDelegate, ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIRefreshControl*refreshControl;
@property (nonatomic, strong) NSMutableArray<Tweet *> *arrayOfTweets;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;


    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self loadTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

-(void) loadTweets {
    // Get timeline
    NSString *idNum = self.arrayOfTweets[self.arrayOfTweets.count-1].idStr;
    
    [[APIManager shared] getHomeTimelineWithCompletion:idNum completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            if (self.arrayOfTweets == nil){
                self.arrayOfTweets = tweets;
            } else {
                self.arrayOfTweets = [self.arrayOfTweets arrayByAddingObjectsFromArray:tweets];
            }
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)didTweet:(Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (void)unTweet {
    [self.arrayOfTweets removeObjectAtIndex:0];
    [self.tableView reloadData];
}

- (IBAction)logoutAct:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)refreshData {
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    cell.delegate = self;
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
//    cell.screenName.text = tweet.user.name;
//    cell.acctName.text = tweet.user.screenName;
//    cell.tweetDate.text = tweet.createdAtString;
//    cell.tweetContent.text = tweet.text;
//    cell.retweetCount.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
//    cell.favoriteCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
//    
//    NSString *URLString = tweet.user.profilePicture;
//    NSURL *url = [NSURL URLWithString:URLString];
//    //NSData *urlData = [NSData dataWithContentsOfURL:url];
//    [cell.profPic setImageWithURL:url];
    cell.tweet = tweet;
    [cell setTweet];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *dViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    dViewController.delegate = self;
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    dViewController.tweet = tweet;
    [self.navigationController pushViewController: dViewController animated:YES];
}


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    UINavigationController *navigationController = [segue destinationViewController];
//       ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
//       composeController.delegate = self;
//
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == (self.arrayOfTweets.count - 2)){
        [self loadTweets];
    }
}

@end
