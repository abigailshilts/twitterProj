//
//  DetailsViewController.m
//  twitter
//
//  Created by Abigail Shilts on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "stringsList.h"
#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profPic;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *tweetContents;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetBut;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBut;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName.text = self.tweet.user.screenName;
    self.username.text = [aatt stringByAppendingString:self.tweet.user.name];
    self.tweetContents.text = self.tweet.text;
    self.tweetDate.text = self.tweet.createdAtString;
    NSString *likeCount = likes;
    self.likeCount.text = [[NSString stringWithFormat:intToStringFormat, self.tweet.favoriteCount]
        stringByAppendingString:likeCount];
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profPic setImageWithURL:url];
    // Do any additional setup after loading the view.
}

// Updates favorite aspect similarily to didTapFavorite in TweetCell
- (IBAction)didTapFav:(id)sender {
    
    if (self.tweet.favorited == YES) {
        self.tweet.favoriteCount -= 1;
        self.tweet.favorited = NO;
        
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(unfavoriteError, error.localizedDescription);
            }
            else{
                NSLog(unfavoriteSuccess, tweet.text);
            }
        }];
        UIImage *btnImage = [UIImage imageNamed:iconNotFavorited];
        [self.favoriteBut setImage:btnImage forState:UIControlStateNormal];
    } else {
        self.tweet.favoriteCount += 1;
        self.tweet.favorited = YES;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(favoriteError, error.localizedDescription);
            }
            else{
                NSLog(favoriteSuccess, tweet.text);
            }
        }];
        
        UIImage *btnImage = [UIImage imageNamed:iconFavorited];
        [self.favoriteBut setImage:btnImage forState:UIControlStateNormal];
    }
    NSString *likeCount = likes;
    self.likeCount.text = [[NSString stringWithFormat:intToStringFormat, self.tweet.favoriteCount]
        stringByAppendingString:likeCount];
}

// attempt to update retweet aspect similarily to didTapFavorite in TweetCell
// very buggy currently a work in progress
- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {
        self.tweet.retweetCount -= 1;
        self.tweet.retweeted = NO;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(unretweetError, error.localizedDescription);
            } else {
                NSLog(unretweetSuccess, tweet.text);
            }
        }];
        
        UIImage *btnImage = [UIImage imageNamed:iconNotRetweeted];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];

    } else {
        self.tweet.retweetCount += 1;
        self.tweet.retweeted = YES;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(retweetError, error.localizedDescription);
            } else {
                NSLog(retweetSuccess, tweet.text);
                [self.delegate didTweet:self.tweet];
            }
        }];
        
        UIImage *btnImage = [UIImage imageNamed:iconRetweeted];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];
    }
    
}

@end
