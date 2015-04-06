//
//  OmniBackgroundView.m
//  SampleApp
//
//  Created by Krishnan Sriram Rama on 4/5/15.
//  Copyright (c) 2015 Krishnan Sriram Rama. All rights reserved.
//

#import "OmniBackgroundView.h"

@interface OmniBackgroundView ()
@property (nonatomic, copy) NSString *bgImageName;
@end

@implementation OmniBackgroundView

- (instancetype)init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

- (instancetype)initWithBGImage:(NSString*)imageName {
    self = [super init];
    if(self) {
        [self setBgImageName:imageName];
    }
    
    return self;
}

- (void)layoutSubviews {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    UIImageView *bgView = nil;
    if([[self bgImageName] length] > 0)
    {
        bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self bgImageName]]];
    }
    else
    {
        bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo-bg"]];
    }
    
    [bgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bgView setContentMode:UIViewContentModeScaleAspectFill];
    [bgView addSubview:blurView];
    
    [self addSubview:bgView];
    [self sendSubviewToBack:bgView];
    [blurView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *imageDictionary = NSDictionaryOfVariableBindings(blurView);
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[blurView]-0-|" options:0 metrics:nil
                                                                     views:imageDictionary]];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[blurView]-0-|" options:0 metrics:nil views:imageDictionary]];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(bgView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bgView]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bgView]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    
    NSLog(@"%@", blurView);
}

@end
