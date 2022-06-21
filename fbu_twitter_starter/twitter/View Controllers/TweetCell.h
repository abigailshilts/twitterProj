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

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profPic;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *acctName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (nonatomic) Tweet *tweet;
- (IBAction)replyBut:(UIButton *)sender;
- (IBAction)retweetBut:(UIButton *)sender;
- (IBAction)likeBut:(UIButton *)sender;
- (IBAction)messageBut:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
