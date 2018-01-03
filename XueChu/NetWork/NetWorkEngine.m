//
//  NetWorkEngine.m
//  XueChu
//
//  Created by eddy on 2018/1/3.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "NetWorkEngine.h"

@implementation NetWorkEngine

#pragma mark - ******** 单例
static NetWorkEngine *instance;

static NSString * const signkey = @"3D49257E25A04D16D97A3F024AA718A1";

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        instance=  [[NetWorkEngine alloc] init];
        //        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        //        [instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        instance.requestSerializer.timeoutInterval = 30;    // 请求超时时间
    });
    
    return instance;
}


- (NSDictionary *)addCommonParam:(NSDictionary *)paramDic
{
    NSMutableDictionary *params = paramDic.mutableCopy;
    [params setObject:@"wish_iphone" forKey:@"app_name"];
    [params setObject:currentVersion() forKey:@"app_version"];
    
    NSArray *keys = [params allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *sign = [NSMutableString string];
    
    for (NSString *categoryId in sortedArray)
    {
        [sign appendString:[NSString stringWithFormat:@"%@",[params objectForKey:categoryId]]];
    }
    
    [sign appendString:signkey];
    
    NSString *md5Sign = md5Encode(sign.copy);
    
    [params setObjectExtra:md5Sign forKey:@"sign"];
    
    return params.copy;
}

- (void)requestInterfaceWithURL:(NSString *)URLStr
                        baseURL:(NSString *)baseURLStr
                          param:(NSDictionary *)paramDic
                  requestMethod:(HttpRequestMethod)requestMethod
              completionHandler:(CompletionHandler)completionHandler
{
    paramDic = [self addCommonParam:paramDic];
    
    void (^requestSuccess)(NSURLSessionDataTask *, NSDictionary *) = nil;
    void (^requestFailure)(NSURLSessionDataTask *, NSError *) = nil;
    
    if (completionHandler != nil)
    {
        requestSuccess = ^(NSURLSessionDataTask *task, NSDictionary *responseDic) {
            
            //日志输出
            if([task.response isKindOfClass:[NSHTTPURLResponse class]])
            {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSInteger httpStatusCode = response.statusCode;
                BLTLog(@"\n============================== Requst info=================================");
                BLTLog(@"请求头: %@", response.allHeaderFields);
                BLTLog(@"HTTP状态码: %ld", httpStatusCode);
            }
            
            NSString *jsonString = [self jsonString:responseDic];
            
            if(requestMethod == HttpRequestMethodPost)
            {
                BLTLog(@"\n===================== BLT LOG STARET=======================\nURL:%@%@\nparams: %@\nresponse : %@\n=========================== END ==========================\n",baseURLStr, URLStr, paramDic, !IsStrEmpty(jsonString)?jsonString:responseDic);
            }
            else
            {
                NSMutableArray *keyValues = [NSMutableArray array];
                for(NSString *key in paramDic.allKeys)
                {
                    id value = paramDic[key];
                    
                    [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
                }
                
                NSString *paramString = [keyValues componentsJoinedByString:@"&"];
                
                BLTLog(@"\n===================== BLT LOG STARET=======================\nURL: %@%@?%@\nresponse: %@\n=========================== END ==========================\n",baseURLStr, URLStr, URLEncodedString(paramString), !IsStrEmpty(jsonString)?jsonString:responseDic);
                
            }
            
            // 以下用到的key均为与服务器约定的key，可根据情况修改
            NSNumber *resultStatusCode = responseDic[@"code"];
            
            if (resultStatusCode.integerValue == 200 || resultStatusCode.integerValue == 8000/*注册状态码*/)
            {
                id resultObject = responseDic[@"data"];
                
                completionHandler(paramDic, nil, resultObject);
            }
            else
            {
                
                NSNumber *resultCode = responseDic[@"code"] ? : responseDic[@"code"];
                NSString *errorMessage = responseDic[@"msg"];
                
                if ([errorMessage isKindOfClass:[NSNull class]]
                    || errorMessage == nil
                    || errorMessage.length == 0)
                {
                    errorMessage = @"";
                }
                
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage
                                                                     forKey:NSLocalizedDescriptionKey];
                
                NSError *error = [NSError errorWithDomain:errorMessage code:resultCode.integerValue userInfo:userInfo];
                
                
                completionHandler(paramDic, error, nil);
            }
        };
        
        requestFailure = ^(NSURLSessionDataTask *task, NSError *error) {
            
            BLTLog(@"\n===================== BLT LOG START=======================\nresponse: %@============================END===========================\n",error);
            
            completionHandler(paramDic, error, nil);
        };
    }
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@", baseURLStr, URLStr];
    
    if (requestMethod == HttpRequestMethodGet)
    {
        [self GET:URLString parameters:paramDic progress:nil success:requestSuccess failure:requestFailure];
    }
    else if (requestMethod == HttpRequestMethodPost)
    {
        [self POST:URLString parameters:paramDic progress:nil success:requestSuccess failure:requestFailure];
    }
}


- (void)requestInterfaceWithURL:(NSString *)URLStr
                        baseURL:(NSString *)baseURLStr
                          param:(NSDictionary *)paramDic
                  requestMethod:(HttpRequestMethod)requestMethod
                  customHandler:(void(^)(NSDictionary *requestParam, NSError *error, id responseResult , id responseOriginData))completionHandler
{
    paramDic = [self addCommonParam:paramDic];
    
    void (^requestSuccess)(NSURLSessionDataTask *, NSDictionary *) = nil;
    void (^requestFailure)(NSURLSessionDataTask *, NSError *) = nil;
    
    if (completionHandler != nil)
    {
        requestSuccess = ^(NSURLSessionDataTask *task, NSDictionary *responseDic) {
            
            //日志输出
            if([task.response isKindOfClass:[NSHTTPURLResponse class]])
            {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSInteger httpStatusCode = response.statusCode;
                BLTLog(@"\n============================== Requst info=================================");
                BLTLog(@"请求头: %@", response.allHeaderFields);
                BLTLog(@"HTTP状态码: %ld", httpStatusCode);
            }
            
            NSString *jsonString = [self jsonString:responseDic];
            
            if(requestMethod == HttpRequestMethodPost)
            {
                BLTLog(@"\n===================== BLT LOG STARET=======================\nURL:%@%@\nparams: %@\nresponse : %@\n=========================== END ==========================\n",baseURLStr, URLStr, paramDic, !IsStrEmpty(jsonString)?jsonString:responseDic);
            }
            else
            {
                NSMutableArray *keyValues = [NSMutableArray array];
                for(NSString *key in paramDic.allKeys)
                {
                    id value = paramDic[key];
                    
                    [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
                }
                
                NSString *paramString = [keyValues componentsJoinedByString:@"&"];
                
                BLTLog(@"\n===================== BLT LOG STARET=======================\nURL: %@%@?%@\nresponse: %@\n=========================== END ==========================\n",baseURLStr, URLStr, URLEncodedString(paramString), !IsStrEmpty(jsonString)?jsonString:responseDic);
                
            }
            
            // 以下用到的key均为与服务器约定的key，可根据情况修改
            NSNumber *resultStatusCode = responseDic[@"code"];
            
            if (resultStatusCode.integerValue == 200 || resultStatusCode.integerValue == 8000/*注册状态码*/)
            {
                id resultObject = responseDic[@"data"];
                
                
                completionHandler(paramDic, nil, resultObject , responseDic);
            }
            else
            {
                
                NSNumber *resultCode = responseDic[@"code"] ? : responseDic[@"code"];
                NSString *errorMessage = responseDic[@"msg"];
                
                if ([errorMessage isKindOfClass:[NSNull class]]
                    || errorMessage == nil
                    || errorMessage.length == 0)
                {
                    errorMessage = @"";
                }
                
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage
                                                                     forKey:NSLocalizedDescriptionKey];
                
                NSError *error = [NSError errorWithDomain:errorMessage code:resultCode.integerValue userInfo:userInfo];
                
                
                completionHandler(paramDic, error, nil  , responseDic);
            }
        };
        
        requestFailure = ^(NSURLSessionDataTask *task, NSError *error) {
            
            BLTLog(@"\n===================== BLT LOG START=======================\nresponse: %@============================END===========================\n",error);
            
            completionHandler(paramDic, error, nil  , nil);
        };
    }
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@", baseURLStr, URLStr];
    
    if (requestMethod == HttpRequestMethodGet)
    {
        [self GET:URLString parameters:paramDic progress:nil success:requestSuccess failure:requestFailure];
    }
    else if (requestMethod == HttpRequestMethodPost)
    {
        [self POST:URLString parameters:paramDic progress:nil success:requestSuccess failure:requestFailure];
    }
}


- (void)requestUpLoadInterfaceWithURL:(NSString *)URLStr
                              baseURL:(NSString *)baseURLStr
                                param:(NSDictionary *)paramDic
                                image:(UIImage *)image
                             fileName:(NSString *)fileName
                        progressBlock:(void(^)(NSProgress *uploadProgress))progressBlock
                    completionHandler:(CompletionHandler)completionHandler
{
    NSString *URLString = [NSString stringWithFormat:@"%@%@", baseURLStr, URLStr];
    NSMutableString *appendStr = [NSMutableString string];
    NSArray *allKey = [paramDic allKeys];
    for (int i = 0; i < allKey.count; i++) {
        NSString *key = allKey[i];
        if (i == allKey.count - 1) {
            [appendStr appendFormat:@"%@=%@", key, paramDic[key]];
        } else {
            [appendStr appendFormat:@"%@=%@&", key, paramDic[key]];
        }
        
    }
    URLString = [URLString stringByAppendingFormat:@"?%@", appendStr];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *fileData = UIImageJPEGRepresentation(image, 0.6);
        
        [formData appendPartWithFileData:fileData name:@"upload_file" fileName:fileName mimeType:@"image/jpeg"];
        
    } error:nil];
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress)
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  progressBlock(uploadProgress);
                                              });
                                              
                                          } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionHandler(nil, error, responseObject);
                                              });
                                              
                                          }];
    
    [uploadTask resume];
}


- (void)cancelAllRequest
{
    for (NSURLSessionDataTask *dataTask in self.dataTasks)
    {
        [dataTask cancel];
    }
}

- (void)cancelRequestByPath:(NSString *)path
{
    NSURLSessionDataTask *currentTask = nil;
    
    for(NSURLSessionDataTask *task in self.tasks)
    {
        NSString *curRequestUrl = task.currentRequest.URL.absoluteString;
        
        //路径可以不用写全，一般服务器地址会单独配置，传后面的路径宏就行
        if([curRequestUrl containsString:path])
        {
            currentTask = task;
        }
    }
    
    if(currentTask && currentTask.state != NSURLSessionTaskStateCanceling)
    {
        [currentTask cancel];
    }
}

//unicode转中文
- (NSString *)jsonString:(id)object
{
    NSError *error = nil;
    @try {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        if(!error)
        {
            NSString *result = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            return result;
        }
    } @catch (NSException *exception) {
        BLTLog(@"%@", exception);
    }
    
    return @"";
}

@end
