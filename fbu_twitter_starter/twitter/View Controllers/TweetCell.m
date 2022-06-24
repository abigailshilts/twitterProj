//
//  TweetCell.m
//  twitter
//
//  Created by Abigail Shilts on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "stringsList.h"
#import "Tweet.h"
#import "TimelineViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// if the retweet button is tapped then either retweet or un retweet along with appropriate actions
- (IBAction)didTapRetweet:(id)sender {
    
    // for if the tweet was already retweeted, decrement retweet count, update API and update cell, delete retweet
    if (self.tweet.retweeted == YES) {
        self.tweet.retweetCount -= 1;
        self.tweet.retweeted = NO;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(unretweetError, error.localizedDescription);
            }
            else{
                NSLog(unretweetSuccess, tweet.text);
            }
        }];
        [self setTweet];
        [self.delegate unTweet];
        [self setTweet];
    }
    // for if the tweet wasn't already retweeted, increment retweet count, update API, update cellm retweet the tweet
    else {
        self.tweet.retweetCount += 1;
        self.tweet.retweeted = YES;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(retweetError, error.localizedDescription);
            }
            else{
                NSLog(retweetSuccess, tweet.text);
            }
        }];
        [self.delegate didTweet:self.tweet];
        [self setTweet];
    }
    
}

// Favorites or unfavorites a tweet
- (IBAction)didTapFavorite:(id)sender {
    
    // if tweet was already favorited, decrements count and updates API, along with updating cell
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
    }
    // if tweet wasn't already favorited, increments count and updates API, along with updating cell
    else {
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
    }
    
    [self setTweet];
}

// loads cell properties with tweet property values
- (void)setTweet {
    self.screenName.text = self.tweet.user.name;
    self.acctName.text = [aatt stringByAppendingString:self.tweet.user.screenName];
    self.tweetDate.text = self.tweet.createdAtString;
    self.tweetContent.text = self.tweet.text;
    self.retweetCount.text = [NSString stringWithFormat:intToStringFormat, self.tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:intToStringFormat, self.tweet.favoriteCount];
    
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profPic setImageWithURL:url];
    
    if (self.tweet.favorited == YES) {
        UIImage *btnImage = [UIImage imageNamed:iconFavorited];
        [self.favBut setImage:btnImage forState:UIControlStateNormal];
    }
    else {
        UIImage *btnImage = [UIImage imageNamed:iconNotFavorited];
        [self.favBut setImage:btnImage forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted == YES) {
        UIImage *btnImage = [UIImage imageNamed:iconRetweeted];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];
    }
    else {
        UIImage *btnImage = [UIImage imageNamed:iconNotRetweeted];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];
    }
}

@end
