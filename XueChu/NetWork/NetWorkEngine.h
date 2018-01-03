//
//  NetWorkEngine.h
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetWorkEngine : AFHTTPSessionManager

typedef NS_ENUM(NSUInteger, HttpRequestMethod)
{
    HttpRequestMethodGet,
    HttpRequestMethodPost,
};

typedef void(^CompletionHandler)(NSDictionary *requestParam, NSError *error, id responseResult);

+ (instancetype)sharedInstance;

- (void)requestInterfaceWithURL:(NSString *)URLStr
                        baseURL:(NSString *)baseURLStr
                          param:(NSDictionary *)paramDic
                  requestMethod:(HttpRequestMethod)requestMethod
              completionHandler:(CompletionHandler)completionHandler;


//可以拿到返回的原始数据
- (void)requestInterfaceWithURL:(NSString *)URLStr
                        baseURL:(NSString *)baseURLStr
                          param:(NSDictionary *)paramDic
                  requestMethod:(HttpRequestMethod)requestMethod
                  customHandler:(void(^)(NSDictionary *requestParam, NSError *error, id responseResult , id responseOriginData))completionHandler;

- (void)requestUpLoadInterfaceWithURL:(NSString *)URLStr
                              baseURL:(NSString *)baseURLStr
                                param:(NSDictionary *)paramDic
                                image:(UIImage *)image
                             fileName:(NSString *)fileName
                        progressBlock:(void(^)(NSProgress *uploadProgress))progressBlock
                    completionHandler:(CompletionHandler)completionHandler;

//取消所有网络请求
- (void)cancelAllRequest;

//根据请求的url，取消单个网络请求
- (void)cancelRequestByPath:(NSString *)path;

@end
