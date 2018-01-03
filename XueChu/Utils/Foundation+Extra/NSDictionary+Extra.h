//
//  NSDictionary+Extra.h
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface NSDictionary (Extra)

- (id)objectForKeyWithoutNull:(id)aKey;

- (NSString *)jsonStringValue;

@end



@interface NSMutableDictionary (Extra)

/**
 *  插入的值为nil或者key为nil时不做操作
 */
- (void)setObjectExtra:(id)anObject forKey:(id <NSCopying>)aKey;

- (id)objectForKeyWithoutNull:(id)aKey;

- (NSString *)jsonStringValue;

@end

