//
//  DetailsViewController.m
//  twitter
//
//  Created by Abigail Shilts on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "TimelineViewController.h"
#import "APIManager.h"

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
    self.username.text = [@"@" stringByAppendingString:self.tweet.user.name];
    self.tweetContents.text = self.tweet.text;
    self.tweetDate.text = self.tweet.createdAtString;
    NSString *likeCount = @" Likes";
    self.likeCount.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:likeCount];
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profPic setImageWithURL:url];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapFav:(id)sender {
    
    if (self.tweet.favorited == YES) {
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
        UIImage *btnImage = [UIImage imageNamed:@"favor-icon"];
        [self.favoriteBut setImage:btnImage forState:UIControlStateNormal];
    } else {
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
        
        UIImage *btnImage = [UIImage imageNamed:@"favor-icon-red"];
        [self.favoriteBut setImage:btnImage forState:UIControlStateNormal];
    }
    NSString *likeCount = @" Likes";
    self.likeCount.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:likeCount];
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
        
        UIImage *btnImage = [UIImage imageNamed:@"retweet-icon"];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];

    } else {
        self.tweet.retweetCount += 1;
        self.tweet.retweeted = YES;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self.delegate didTweet:self.tweet];
            }
        }];
        
        UIImage *btnImage = [UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetBut setImage:btnImage forState:UIControlStateNormal];
    }
    
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
