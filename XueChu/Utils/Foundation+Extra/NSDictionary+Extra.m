//
//  NSDictionary+Extra.m
//  BaihuaAuthor
//
//  Created by Lin on 15/11/3.
//  Copyright © 2015年 KuGou. All rights reserved.
//

#import "NSDictionary+Extra.h"




@implementation NSDictionary (Extra)

- (id)objectForKeyWithoutNull:(id)aKey
{
    id result = [self objectForKey:aKey];
    
    if ([result isKindOfClass:[NSNull class]])
    {
        result = nil;
    }
    
    return result;
}

- (NSString *)jsonStringValue
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (jsonData == nil)
    {
        NSLog(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end



@implementation NSMutableDictionary (Extra)

- (void)setObjectExtra:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject && aKey)
    {
        [self setObject:anObject forKey:aKey];
    }
}

- (id)objectForKeyWithoutNull:(id)aKey
{
    id result = [self objectForKey:aKey];
    
    if ([result isKindOfClass:[NSNull class]])
    {
        result = nil;
    }
    
    return result;
}

- (NSString *)jsonStringValue
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (jsonData == nil)
    {
        NSLog(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end


