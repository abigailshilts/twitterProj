//
//  TweetCell.h
//  twitter
//
//  Created by Abigail Shilts on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetCellDelegate

- (void)didTweet:(Tweet *)tweet;
- (void)unTweet;

@end

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *retweetBut;
@property (weak, nonatomic) IBOutlet UIButton *favBut;
@property (weak, nonatomic) IBOutlet UIImageView *profPic;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *acctName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@property (nonatomic, strong) Tweet *tweet;
@property int isFavorite;
- (void)setTweet;

@end

NS_ASSUME_NONNULL_END
