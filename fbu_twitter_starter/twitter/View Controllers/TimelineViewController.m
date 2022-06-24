//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "AppDelegate.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "LoginViewController.h"
#import "stringsList.h"
#import "TimelineViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

//delete detailsveiwcontrollerdelegate is apart of an attempt to get retweet/unretweet functions to work from details view, will come back to if there is time
@interface TimelineViewController () <DetailsViewControllerDelegate, TweetCellDelegate, ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIRefreshControl*refreshControl;
@property (nonatomic, strong) NSMutableArray<Tweet *> *arrayOfTweets;

@end

@implementation TimelineViewController

// Called to load tweets into tableView
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;


    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self loadTweets];
    
    // creates and controls refresh icon
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

// Accesses uses APIManager and API to GET tweets
-(void) loadTweets {
    // Get timeline
    NSString *idNum = self.arrayOfTweets[self.arrayOfTweets.count-1].idStr;
    
    [[APIManager shared] getHomeTimelineWithCompletion:idNum completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            // if statement to accont for when arrayOfTweets is nil
            if (self.arrayOfTweets == nil){
                self.arrayOfTweets = tweets;
            } else {
                self.arrayOfTweets = [self.arrayOfTweets arrayByAddingObjectsFromArray:tweets];
            }
        } else {
            NSLog(homeTimeLineError, error.localizedDescription);
        }
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

// adds new user generated tweet to the timeline
// doesn't add the retweet to the API
- (void)didTweet:(Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

// removes new user generated tweet to the timeline
// bug where if most recent tweet is not the one that was retweeted it removes the wrong tweet from feed
// better way could be using idStr?
- (void)unTweet {
    [self.arrayOfTweets removeObjectAtIndex:0];
    [self.tableView reloadData];
}

// logs user out by sending back to sign in screen
- (IBAction)logoutAct:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:main bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:loginViewControllerStr];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// calls methods on TweetCell to populate tableView cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:tweetIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    cell.tweet = tweet;
    [cell setTweet];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

// Causes detailsView page to pop up when tweet is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *dViewController = [self.storyboard instantiateViewControllerWithIdentifier:detailsViewControllerStr];
    dViewController.delegate = self;
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    dViewController.tweet = tweet;
    [self.navigationController pushViewController: dViewController animated:YES];
}


#pragma mark - Navigation

// keeps track of next cell to be displayed so that table can be expanded when scrolling -> infinite scroll
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == (self.arrayOfTweets.count - 2)){
        [self loadTweets];
    }
}

@end
