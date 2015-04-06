//
//  SecondViewController.m
//  SampleApp
//
//  Created by Krishnan Sriram Rama on 4/5/15.
//  Copyright (c) 2015 Krishnan Sriram Rama. All rights reserved.
//

#import "SecondViewController.h"
#import "OmniBackgroundView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)loadView
{
    [super loadView];
    [self setView:[[OmniBackgroundView alloc] initWithBGImage:@"demo-bg"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 40)];
    [label setText:@"Sample Label"];
    [label setTextColor:[UIColor whiteColor]];
    [[self view] addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
