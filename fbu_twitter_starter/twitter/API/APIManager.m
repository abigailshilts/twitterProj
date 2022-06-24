//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "stringsList.h"
#import "Tweet.h"

static NSString * const baseURLString = apiLinkBase;

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:keys ofType:plist];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString *key = [dict objectForKey:consumerKey];
    NSString *secret = [dict objectForKey:consumerSecret];
    
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:consumerKey]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:consumerKey];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:consumerSecret]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:consumerSecret];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

// Loads in tweets from API GET
- (void)getHomeTimelineWithCompletion:(NSString *)idNum completion:(void(^)(NSArray *tweets, NSError *error))completion {
    NSDictionary *parameters;
    if (idNum == nil) {
        parameters = nil;
    }
    else {
        parameters = @{maxId: idNum};
    }
    [self GET:homeTimeLineJson
       parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
           // Success
           NSMutableArray *tweets = [Tweet tweetsWithArray:tweetDictionaries];
           completion(tweets, nil);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           // There was a problem
           completion(nil, error);
    }];
}

// APIManager.m
- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion {
    NSString *urlString = statusesUpdateJson;
    NSDictionary *parameters = @{status: text};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

// Adds a favorite to the API
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion {

    NSString *urlString = favoritesCreateJson;
    NSDictionary *parameters = @{idStr: tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}
// adds a retweet to the API
- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion {

    NSString *urlStringBegin = retweetJson;
    NSString *end = json;
    NSString *urlString = [urlStringBegin stringByAppendingString:tweet.idStr];
    urlString = [urlString stringByAppendingString:end];
    NSDictionary *parameters = @{idStr: tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

// removes a retweet from the API
- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion {

    NSString *urlStringBegin = unretweetJson;
    NSString *end = json;
    NSString *urlString = [urlStringBegin stringByAppendingString:tweet.idStr];
    urlString = [urlString stringByAppendingString:end];
    NSDictionary *parameters = @{idStr: tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

// removes a favorite from the API
- (void)unFavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion {

    NSString *urlString = favoritesDestroyJson;
    NSDictionary *parameters = @{idStr: tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

@end
