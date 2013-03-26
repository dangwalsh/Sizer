//
//  SizeView.m
//  Sizer
//
//  Created by Daniel Walsh on 3/23/13.
//  Copyright (c) 2013 Daniel Walsh. All rights reserved.
//

#import "SizeView.h"

@implementation SizeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];

        CGSize s = CGSizeMake(150, 50);
        
        CGRect f1 = CGRectMake((frame.size.width - s.width) / 2,
                               (frame.size.height - s.height) / 6,
                               s.width,
                               s.height);
        self.small = [[UILabel alloc] init];
        self.small.text = @"Small";
        self.small.textAlignment = kCTTextAlignmentCenter;
        self.small.textColor = [UIColor whiteColor];
        self.small.backgroundColor = [UIColor clearColor];
        self.small.opaque = NO;
        self.small.userInteractionEnabled = YES;
        UITapGestureRecognizer *smallTap = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(makeSmall:)];
        [self.small addGestureRecognizer:smallTap];
        self.small.frame = f1;
        [self addSubview:self.small];
        CGRect f2 = CGRectMake((frame.size.width - s.width) / 2,
                               ((frame.size.height - s.height) / 6) * 2,
                               s.width,
                               s.height);
        self.medium = [[UILabel alloc] init];
        self.medium.text = @"Medium";
        self.medium.textAlignment = kCTTextAlignmentCenter;
        self.medium.textColor = [UIColor whiteColor];
        self.medium.backgroundColor = [UIColor clearColor];
        self.medium.opaque = NO;
        self.medium.userInteractionEnabled = YES;
        self.medium.frame = f2;
        self.medium.userInteractionEnabled = YES;
        UITapGestureRecognizer *mediumTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(makeMedium:)];
        [self.medium addGestureRecognizer:mediumTap];
        [self addSubview:self.medium];
        CGRect f3 = CGRectMake((frame.size.width - s.width) / 2,
                               ((frame.size.height - s.height) / 6) * 3,
                               s.width,
                               s.height);
        self.large = [[UILabel alloc] init];
        self.large.text = @"Large";
        self.large.textAlignment = kCTTextAlignmentCenter;
        self.large.textColor = [UIColor whiteColor];
        self.large.backgroundColor = [UIColor clearColor];
        self.large.opaque = NO;
        self.large.userInteractionEnabled = YES;
        self.large.frame = f3;
        self.large.userInteractionEnabled = YES;
        UITapGestureRecognizer *largeTap = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(makeLarge:)];
        [self.large addGestureRecognizer:largeTap];
        [self addSubview:self.large];
        CGRect f4 = CGRectMake((frame.size.width - s.width) / 2,
                               ((frame.size.height - s.height) / 6) * 4,
                               s.width,
                               s.height);
        self.custom = [[UISlider alloc]initWithFrame:f4];
        self.custom.minimumValue = 1;
        self.custom.maximumValue = 99;
        self.custom.value = (self.custom.maximumValue + self.custom.minimumValue) / 2;
        self.custom.continuous = YES;
        self.custom.backgroundColor = [UIColor clearColor];
        self.custom.minimumTrackTintColor = [UIColor whiteColor];
        self.custom.maximumTrackTintColor = [UIColor clearColor];
        self.custom.opaque = NO;
        UITapGestureRecognizer *customTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(makeCustom:)];
        [self.custom addGestureRecognizer:customTap];
        [self addSubview:self.custom];
        /*
        self.center = CGPointMake(-self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self.view addSubview:self.sizeView];
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{ self.sizeView.center = CGPointMake(self.sizeView.bounds.size.width / 2, self.sizeView.bounds.size.height / 2); }
                         completion:NULL
         ];
         */
    }
    return self;
}

- (void) makeSmall: (id)sender
{
    [self.delegate makeSmall];
}

- (void) makeMedium: (id)sender
{
    [self.delegate makeMedium];
}

- (void) makeLarge: (id)sender
{
    [self.delegate makeLarge];
}

- (void) makeCustom: (id)sender
{
    [self.delegate makeCustom];
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
