//
//  ComposeViewController.m
//  twitter
//
//  Created by Abigail Shilts on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "stringsList.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

// closes compose window
- (IBAction)closeTap:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

// calls APIManager function to add tweet to API
- (IBAction)postTweet:(UIBarButtonItem *)sender {
    [[APIManager shared]postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(composeError, error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
