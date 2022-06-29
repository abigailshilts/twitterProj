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
@property (weak, nonatomic) IBOutlet UILabel *charCount;

@end

@implementation ComposeViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.charCount.text = twoEighty;
    self.textView.delegate = self;
}

// closes compose window
- (IBAction)closeTap:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

// calls APIManager function to add tweet to API
- (IBAction)postTweet:(UIBarButtonItem *)sender {
    [[APIManager shared]postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(composeError, error.localizedDescription);
        } else {
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];

}

- (void)setCount:(int)charLength {
    int numLeft = 280 - charLength;
    self.charCount.text = [NSString stringWithFormat:intToStringFormat, numLeft];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    int characterLimit = 280;
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];
    [self setCount:newText.length];
    return newText.length < characterLimit;
}

@end
