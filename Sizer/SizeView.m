//
//  SizeView.m
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import "SizeView.h"

@implementation SizeView

- (id)initWithFrame:(CGRect)frame controller:(SizeViewController *)c
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
        self.userInteractionEnabled = YES;
        self.opaque = NO;
        self.delegate = c;
        
        CGSize s = CGSizeMake(100, 50);
        CGRect f1 = CGRectMake((frame.size.width - s.width) / 2,
                               (frame.size.height - s.height) / 4,
                               s.width,
                               s.height);
        self.small = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.small.frame = f1;
        [self.small addTarget:self action:@selector(processImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.small];
        CGRect f2 = CGRectMake((frame.size.width - s.width) / 2,
                               ((frame.size.height - s.height) / 4) * 2,
                               s.width,
                               s.height);
        self.medium = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.medium.frame = f2;
        [self.medium addTarget:self action:@selector(processImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.medium];
        CGRect f3 = CGRectMake((frame.size.width - s.width) / 2,
                               ((frame.size.height - s.height) / 4) * 3,
                               s.width,
                               s.height);
        self.large = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.large.frame = f3;
        [self.large addTarget:self action:@selector(processImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.large];
    }
    return self;
}

- (void) processImage:(id)sender
{
    [self.delegate dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
