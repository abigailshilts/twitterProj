//
//  DetailsViewController.h
//  twitter
//
//  Created by Abigail Shilts on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface DetailsViewController : UIViewController

@property Tweet *tweet;
@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
