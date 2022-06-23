//
//  TweetCell.m
//  twitter
//
//  Created by Abigail Shilts on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "TimelineViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {
        self.tweet.retweetCount -= 1;
        self.tweet.retweeted = NO;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        [self setTweet];
        [self.delegate unTweet];
        [self setTweet];
    } else {
        self.tweet.retweetCount += 1;
        self.tweet.retweeted = YES;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        [self.delegate didTweet:self.tweet];
        [self setTweet];
    }
    
}
- (IBAction)didTapFavorite:(id)sender {
    //fix so not need
    if (self.tweet.favorited){
        self.isFavorite = 1;
    }
    else {
        self.isFavorite = 0;
    }
    
    if (self.isFavorite == 1) {
        self.isFavorite = 0;
        self.tweet.favoriteCount -= 1;
        self.tweet.favorited = NO;
        
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        self.isFavorite = 1;
        self.tweet.favoriteCount += 1;
        self.tweet.favorited = YES;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self setTweet];
}

- (void)setTweet {
    if (self.tweet.favorited){
        self.isFavorite = 1;
    }
    else {
        self.isFavorite = 0;
    }
    self.screenName.text = self.tweet.user.name;
    self.acctName.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetDate.text = self.tweet.createdAtString;
    self.tweetContent.text = self.tweet.text;
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profPic setImageWithURL:url];
    
    if (self.isFavorite == 1) {
        UIImage *btnImage = [UIImage imageNamed:@"favor-icon-red"];
        [self.favBut setImage:btnImage forState:UIControlStateNormal];
    }
    else {
        UIImage *btnImage = [UIImage imageNamed:@"favor-icon"];
        [self.favBut setImage:btnImage forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted == YES) {
        UIImage *btnImage = [UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];
    }
    else {
        UIImage *btnImage = [UIImage imageNamed:@"retweet-icon"];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];
    }
}
//
//- (void)callSetTweet {
//    [self setTweet];
//}

@end
