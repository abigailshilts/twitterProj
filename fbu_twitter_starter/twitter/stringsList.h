//
//  stringsList.h
//  twitter
//
//  Created by Abigail Shilts on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef stringsList_h
#define stringsList_h

static const NSString *const aatt = @"@";
static const NSString *const apiLinkBase = @"https://api.twitter.com";
static const NSString *const consumerKey = @"consumer_Key";
static const NSString *const composeError = @"Error composing Tweet: %@";
static const NSString *const consumerSecret = @"consumer_Secret";
static const NSString *const detailsViewControllerStr = @"DetailsViewController";
static const NSString *const favCount = @"favorite_count";
static const NSString *const favoriteError = @"Error favoriting tweet: %@";
static const NSString *const favoritesCreateJson = @"1.1/favorites/create.json";
static const NSString *const favoritesDestroyJson = @"1.1/favorites/destroy.json";
static const NSString *const favoriteSuccess = @"Successfully favorited the following Tweet: %@";
static const NSString *const formatOfDate = @"E MMM d HH:mm:ss Z y";
static const NSString *const hasRetweet = @"retweeted";
static const NSString *const homeTimeLineError = @"Error getting home timeline: %@";
static const NSString *const homeTimeLineJson = @"1.1/statuses/home_timeline.json";
static const NSString *const iconFavorited = @"favor-icon-red";
static const NSString *const iconNotFavorited = @"favor-icon";
static const NSString *const iconNotRetweeted = @"retweet-icon";
static const NSString *const iconRetweeted = @"retweet-icon-green";
static const NSString *const idStr = @"id";
static const NSString *const id_Str = @"id_str";
static const NSString *const intToStringFormat = @"%d";
static const NSString *const isFav = @"favorited";
static const NSString *const json = @".json";
static const NSString *const keys = @"Keys";
static const NSString *const likes = @" Likes";
static const NSString *const loginSegue = @"loginSegue";
static const NSString *const loginViewControllerStr = @"LoginViewController";
static const NSString *const main = @"Main";
static const NSString *const maxId = @"max_id";
static const NSString *const nameStr = @"name";
static const NSString *const plist = @"plist";
static const NSString *const profileImgUrl = @"profile_image_url_https";
static const NSString *const retweetCount = @"retweet_count";
static const NSString *const retweetError = @"Error retweeting: %@";
static const NSString *const retweetJson = @"1.1/statuses/retweet/";
static const NSString *const retweetStatus = @"retweeted_status";
static const NSString *const retweetSuccess = @"Successfully retweeted the following Tweet: %@";
static const NSString *const screenNameStr = @"screen_name";
static const NSString *const status = @"status";
static const NSString *const statusesUpdateJson = @"1.1/statuses/update.json";
static const NSString *const textStr = @"text";
static const NSString *const tweetIdentifier = @"tweetCell";
static const NSString *const unfavoriteError = @"Error favoriting tweet: %@";
static const NSString *const unfavoriteSuccess = @"Successfully favorited the following Tweet: %@";
static const NSString *const unretweetError = @"Error unretweeting: %@";
static const NSString *const unretweetJson = @"1.1/statuses/unretweet/";
static const NSString *const unretweetSuccess = @"Successfully unretweeted the following Tweet: %@";
static const NSString *const userStr = @"user";
static const NSString *const whenCreated = @"created_at";

#endif /* stringsList_h */
