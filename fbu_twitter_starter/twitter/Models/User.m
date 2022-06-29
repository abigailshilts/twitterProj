//
//  User.m
//  twitter
//
//  Created by Abigail Shilts on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//
#import "stringsList.h"
#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[nameStr];
        self.screenName = dictionary[screenNameStr];
        self.profilePicture = dictionary[profileImgUrl];
    }
    return self;
}

@end
