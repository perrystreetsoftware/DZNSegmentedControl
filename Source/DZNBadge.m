//
//  DZNBadge.m
//  Sample
//
//  Created by Eric Silverberg on 11/13/14.
//  Copyright (c) 2014 Epic Peaks GmbH. All rights reserved.
//

#import "DZNBadge.h"

@interface DZNBadge()
@property (nonatomic, strong) UILabel *labelView;

@end

@implementation DZNBadge

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.labelView.font = [UIFont boldSystemFontOfSize:11.f];
        self.labelView.textColor = [UIColor whiteColor];
        [self addSubview:self.labelView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setBadgeCount:(NSInteger)count {
    if (count > 9) {
        self.labelView.text = @"9+";
    } else if (count > 0) {
        self.labelView.text = [NSString stringWithFormat:@"%ld", (long)count];
    } else {
        self.labelView.text = @"";
    }
    [self setNeedsDisplay];
}

- (void)sizeToFit {
    [super sizeToFit];
    
    NSDictionary *fontAtts = @{NSFontAttributeName : self.labelView.font};
    CGRect rect = [self.labelView.text boundingRectWithSize:self.frame.size
                                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                 attributes:fontAtts
                                                    context:nil];

    CGFloat maxDimension = MAX(rect.size.width, rect.size.height);
    self.frame = CGRectMake(0, 0, maxDimension + 5.f, maxDimension + 5.f);
}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSDictionary *fontAtts = @{NSFontAttributeName : self.labelView.font};
    CGRect rect = [self.labelView.text boundingRectWithSize:self.frame.size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:fontAtts
                                      context:nil];
    
    CGFloat yOffset = (self.frame.size.height - ceil(rect.size.height)) / 2.0f;
    CGFloat xOffset = (self.frame.size.width - ceil(rect.size.width)) / 2.0f;
    self.labelView.frame = CGRectMake(xOffset, yOffset, ceil(rect.size.width), ceil(rect.size.height));
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextSetLineWidth(context, 4.0);
//    CGContextSetStrokeColorWithColor(context,
//                                     [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);
//    CGContextStrokePath(context);
    
}

@end
