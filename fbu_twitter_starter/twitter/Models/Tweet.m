//
//  Tweet.m
//  twitter
//
//  Created by Abigail Shilts on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DateTools.h"
#import "stringsList.h"
#import "Tweet.h"
#import "User.h"

@implementation Tweet
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        NSDictionary *originalTweet = dictionary[retweetStatus];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[userStr];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[id_Str];
        self.text = dictionary[textStr];
        self.favoriteCount = [dictionary[favCount] intValue];
        self.favorited = [dictionary[isFav] boolValue];
        self.retweetCount = [dictionary[retweetCount] intValue];
        self.retweeted = [dictionary[hasRetweet] boolValue];

        // initialize user
        NSDictionary *user = dictionary[userStr];
        self.user = [[User alloc] initWithDictionary:user];        
        // Format createdAt date string
        NSString *createdAtOriginalString = dictionary[whenCreated];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = formatOfDate;
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        self.createdAtString = [date shortTimeAgoSinceNow];
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}
@end
