//
//  CustomTextAttachment.m
//  Baihua
//
//  Created by Hayashisama on 15/12/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import "CustomTextAttachment.h"

@implementation CustomTextAttachment

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _position = CGPointMake(0, - 6);
    }
    
    return self;
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer
                      proposedLineFragment:(CGRect)lineFrag
                             glyphPosition:(CGPoint)position
                            characterIndex:(NSUInteger)charIndex
{
    CGRect attachmentBounds = [super attachmentBoundsForTextContainer:textContainer
                                                 proposedLineFragment:lineFrag
                                                        glyphPosition:position
                                                       characterIndex:charIndex];
    
    return CGRectMake(_position.x, _position.y, attachmentBounds.size.width, attachmentBounds.size.height);
}

@end
