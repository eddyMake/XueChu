//
//  CommonUtility.h
//  SandBayCinema
//
//  Created by Rayco on 12-11-1.
//  Copyright (c) 2012年 Apps123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"

#pragma mark - base

CG_INLINE NSInteger decimalwithFormat(NSString *numberFormate, CGFloat formaterValue)
{
    if (numberFormate == nil)
    {
        numberFormate = @"0";
    }
    
    //格式话小数 四舍五入类型
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:numberFormate];
    
    NSString *score = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:formaterValue]];
    
    return  score.integerValue;
}

CG_INLINE NSString *currentVersion()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if (appVersion == nil)
    {
        return @"1.0";
    }
    
    return appVersion;
}

CG_INLINE NSString *toUTF8String(NSString* str) {
    NSData *responseData = [NSData dataWithBytes:[str UTF8String] length:str.length];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *resultStr = [[NSString alloc] initWithData:responseData encoding:enc];
    return resultStr;
}


//CG_INLINE BOOL isValueSet(id obj) {
//    if (!obj) {
//        return NO;
//    }
//    if ([obj isKindOfClass:NSClassFromString(@"NSArray")] || [obj isKindOfClass:NSClassFromString(@"NSMutableArray")]) {
//        if ([obj count] > 0) {
//            return YES;
//        }
//    }
//    else if ([obj isKindOfClass:NSClassFromString(@"NSDictionary")] || [obj isKindOfClass:NSClassFromString(@"NSMutableDictionary")]) {
//        if ([obj count] > 0) {
//            return YES;
//        }
//    }
//    else if ([obj isKindOfClass:NSClassFromString(@"NSString")]) {
//        if ([obj length] > 0) {
//            return YES;
//        }
//    }
//    return NO;
//}

CG_INLINE BOOL validateAccount(id obj) {
    if (!obj) {
        return NO;
    }
    
    NSString *userNameRegex = @"^[A-Za-z0-9_]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:obj];
    
    return B;
}

CG_INLINE BOOL isValidString(id obj) {
    if (!obj) {
        return NO;
    }
    if ([obj isKindOfClass:NSClassFromString(@"NSString")]) {
        NSString *str = (NSString *)obj;
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([str length] > 0) {
            return YES;
        }
    }
    return NO;
}

CG_INLINE BOOL isValidArray(id obj) {
    if (!obj) {
        return NO;
    }
    if ([obj isKindOfClass:NSClassFromString(@"NSArray")] || [obj isKindOfClass:NSClassFromString(@"NSMutableArray")]) {
        if ([obj count] > 0) {
            return YES;
        }
    }
    return NO;
}

CG_INLINE BOOL isValidDictionary(id obj) {
    if (!obj) {
        return NO;
    }
    if ([obj isKindOfClass:NSClassFromString(@"NSDictionary")] || [obj isKindOfClass:NSClassFromString(@"NSMutableDictionary")]) {
        if ([obj count] > 0) {
            return YES;
        }
    }
    return NO;
}



CG_INLINE NSString *getString(id obj) {
    return [NSString stringWithFormat:@"%@",obj];
}

CG_INLINE NSString *md5Encode(NSString *input)
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}



CG_INLINE NSString* getRandomStrings(int length) {
    if (length <= 0) {
        return @"0";
    }
    NSString *str = @"";
    for (int i = 0; i < length; i++) {
        int r = arc4random() % 10; //随机生成0-9 的数字
        str = [str stringByAppendingFormat:@"%d",r];
    }
    return str;
}

CG_INLINE NSString *getCachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

#pragma mark - image
//纠正图片的方向
CG_INLINE UIImage* adjustPhotoOrientation(UIImage  *aImage) {
    
    if (aImage == nil)
    {
        return nil;
    }
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient) {
        case UIImageOrientationUp: //EXIF = 1
        {
            transform = CGAffineTransformIdentity;
            break;
        }
        case UIImageOrientationUpMirrored: //EXIF = 2
        {
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        }
        case UIImageOrientationDown: //EXIF = 3
        {
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        }
        case UIImageOrientationDownMirrored: //EXIF = 4
        {
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        }
        case UIImageOrientationLeftMirrored: //EXIF = 5
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationLeft: //EXIF = 6
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationRightMirrored: //EXIF = 7
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        }
        case UIImageOrientationRight: //EXIF = 8
        {
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        }
        default:
        {
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
        }
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    } else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}


//保存压缩后的图像，更适合网络传输.返回Document路径
CG_INLINE NSString* saveAndResizeImage(UIImage *_image,NSString *_sName,float with) {
    CGSize newSize = CGSizeMake(with, with * _image.size.height / _image.size.width);
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    
    UIImage *newImage = tmpImage;//adjustPhotoOrientation(tmpImage);
    
    //保存新图片到Document
    NSData *data;
    if (UIImagePNGRepresentation(newImage) == nil) {
        data = UIImageJPEGRepresentation(newImage, 0.5);
    } else {
        data = UIImagePNGRepresentation(newImage);
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString* imgSavePath = [getCachePath() stringByAppendingPathComponent:_sName];
    if ([fm fileExistsAtPath:imgSavePath]) {
        [fm removeItemAtPath:imgSavePath error:nil];
    }
    [fm createFileAtPath:imgSavePath contents:data attributes:nil];
    return imgSavePath;
}

CG_INLINE NSString *getTransformImageLink(NSString *originalLink,int percentage) {
    if (isValidString(originalLink)) {
        NSString *oldExt = [originalLink pathExtension];
        NSString *pString = @"";
        if (percentage == 25) {
            pString = @"025_025";
        }
        else if (percentage == 50) {
            pString = @"05_05";
        }
        else if (percentage == 75) {
            pString = @"075_075";
        }
        else if (percentage == 100) {
            return originalLink;
        }
        else {
            return nil;
        }
        NSString *newExt = [NSString stringWithFormat:@"%@.%@",pString,oldExt];
        NSString *newLink = [originalLink stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",oldExt] withString:newExt];
        return newLink;
    }
    
    return nil;
}

#pragma mark - others
/**
 * 计算两组经纬度坐标 之间的距离
 * params ：lat1 纬度1； lng1 经度1； lat2 纬度2； lng2 经度2； len_type （1:m or 2:km);
 * return m or km
 */
CG_INLINE double getDistance(double lat1, double lng1, double lat2, double lng2, double len_type)
{
    double EARTH_RADIUS=6378.137;
    double PI=3.1415926;
    double radLat1 = lat1 * PI / 180.0;
    double radLat2 = lat2 * PI / 180.0;
    double a = radLat1 - radLat2;
    double b = (lng1 * PI / 180.0) - (lng2 * PI / 180.0);
    double s = 2 * asin(sqrt(pow(sin(a/2),2) + cos(radLat1) * cos(radLat2) * pow(sin(b/2),2)));
    s = s * EARTH_RADIUS;
    s = round(s * 1000);
    if (len_type > 1)
    {
        s /= 1000;
    }
    return round(s);
}

//string:lon,lat
CG_INLINE CLLocation* getGfLocation(NSString* location) {
    NSArray *arr = [location componentsSeparatedByString:@","];
    if ([arr count] >= 2) {
        double lon = [[arr objectAtIndex:0] doubleValue];
        double lat = [[arr objectAtIndex:1] doubleValue];
        return [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    }
    return nil;
}


CG_INLINE NSString* getFormatedDistance(double dist) {
    NSString *resultString = @"";
    if (dist <= 100) {
        resultString = @"100米以内";
    }
    else if (dist <= 200) {
        resultString = @"200米以内";
    }
    else if (dist <= 500) {
        resultString = @"500米以内";
    }
    else if (dist <= 1000) {
        resultString = @"1000米以内";
    }
    else if (dist <= 2000) {
        resultString = @"2000米以内";
    }
    else if (dist <= 5000) {
        resultString = @"5000米以内";
    }
    else if (dist <= 10000) {
        resultString = @"10km以内";
    }
    else {
        resultString = @"大于10km";
    }
    
    return resultString;
}

CG_INLINE UIColor *GetColorWithRGB(float r,float g,float b) {
    return [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0];
}

CG_INLINE int getWordCount(NSString *word) {
    int i,n=[word length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[word characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

CG_INLINE UIColor *getHexColor(NSString *hexColor) {
    if(!hexColor || [hexColor isEqualToString:@""] || [hexColor length] < 7){
        if (hexColor.length != 4) {
            return [UIColor whiteColor];
        }
    }
    
    if (hexColor.length == 4) {
        hexColor = [NSString stringWithFormat:@"#%c%c%c%c%c%c",[hexColor characterAtIndex:1],[hexColor characterAtIndex:1],[hexColor characterAtIndex:2],[hexColor characterAtIndex:2],[hexColor characterAtIndex:3],[hexColor characterAtIndex:3]];
    }
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

CG_INLINE BOOL isMobileNumber(NSString *mobileNum)
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString * CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString * CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
//    NSString * CT = @"^1((33|53|8[019]|77[0-9]))\\d{8}$";
    NSString *CT = @"^1(3[3]|4[9]|53|7[0367]|8[019])\\d{8}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        if([regextestcm evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:mobileNum] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

CG_INLINE BOOL isValidateEmail(NSString *Email)
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}


CG_INLINE NSString* URLEncodedString(NSString *urlString)
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)urlString,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

#pragma mark - About System
CG_INLINE BOOL iPhone5() {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height > 960 : NO);
}

///用此方法代替iPhone5()
CG_INLINE BOOL isBigScreen() {
    return ([[UIScreen mainScreen] bounds].size.height > 480);
}

CG_INLINE BOOL ios7OrLater() {
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO;
}

CG_INLINE BOOL ios8OrLater() {
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO;
}

CG_INLINE NSString *GetDocumentPath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

CG_INLINE NSString *getTmpPath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

CG_INLINE NSString *GetMainBundlePath() {
    return [[NSBundle mainBundle] bundlePath];
}

CG_INLINE AppDelegate* app_delegate() {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

#pragma mark - About Frame
/*
 *   About Size
 */
CG_INLINE CGSize GetStringSize(NSString *str,float fontSize,NSString *fontName,CGSize formatSize) {
    UIFont *font;
    if (fontName && fontName.length > 1) {
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    CGSize size = formatSize;
    CGSize labelsize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return labelsize;
}

CG_INLINE float getTextHeightForLabel(NSString *textString,UILabel *label) {
    CGSize cSize;
    if (ios7OrLater()) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil];
        
        cSize = [textString boundingRectWithSize:CGSizeMake(label.frame.size.width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else {
        cSize = [textString sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width,MAXFLOAT) lineBreakMode:0];
    }
    
    cSize.height = (int)(cSize.height / label.frame.size.height + 1) * label.frame.size.height;//(cSize.height >= 30.0f ? cSize.height : 30.0f);
    return cSize.height;
}

CG_INLINE CGFloat fitLabelHeight(UILabel *label,NSString *contentString) {
    label.numberOfLines = 0;
//    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, 0)];
//    CGSize size = [contentString sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:1];
    CGRect rct = label.frame;
    rct.size.height = getTextHeightForLabel(contentString,label);//size.height+20;
    label.frame = rct;
    
    return label.frame.size.height;
}

CG_INLINE CGFloat fitlabelHeight(UILabel *label) {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, 0)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    CGRect rct = label.frame;
    rct.size.height = size.height;
    label.frame = rct;
    
    return label.frame.size.height;
}

CG_INLINE CGFloat fitLabelWidth(UILabel *label) {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(0, label.frame.size.height)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rct = label.frame;
    rct.size.width = size.width;
    label.frame = rct;
    
    return label.frame.size.width;
}

CG_INLINE CGSize fitLabelSize(UILabel *label) {
    label.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake(260.0,99999.0);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:0];
    CGRect rct = label.frame;
    rct.size.width = size.width;
    rct.size.height = size.height;
    label.frame = rct;
    
    return size;
}
//设置label距离
CG_INLINE void setLabelSpace(UILabel *label,int spaceHigh,int lineCount,NSString *content) {
    label.numberOfLines = lineCount;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spaceHigh];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}


CG_INLINE void setViewFrameOriginX(UIView *v ,float x) {
    CGRect frame = v.frame;
    frame.origin.x = x;
    v.frame = frame;
}

CG_INLINE void setViewFrameOriginY(UIView *v ,float y) {
    CGRect frame = v.frame;
    frame.origin.y = y;
    v.frame = frame;
}

CG_INLINE void setViewFrameSizeWidth(UIView *v ,float w) {
    CGRect frame = v.frame;
    frame.size.width = w;
    v.frame = frame;
}

CG_INLINE void setViewFrameSizeHeight(UIView *v ,float h) {
    CGRect frame = v.frame;
    frame.size.height = h;
    v.frame = frame;
}


CG_INLINE UIView* getStarRateBar(NSInteger rate) {
    CGFloat margin = 5.f,starWH = 15.f;
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (starWH + margin)*5, starWH+2*margin)];
    barView.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*margin+i*starWH, margin, starWH, starWH)];
        [imgv setClipsToBounds:YES];
        [imgv setImage:[UIImage imageNamed:(i<=rate ? @"star-on.png" : @"star-off.png")]];
        [barView addSubview:imgv];
    }
    
    
    return barView;
}


CG_INLINE void removeAllSubViews(UIView *v) {
    for (NSInteger i = 0; i < v.subviews.count; i++) {
        UIView *viewTmp = [v.subviews objectAtIndex:i];
        [viewTmp removeFromSuperview];
    }
}

CG_INLINE BOOL isRetinaScreen(){
    CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
    if (((screenSize.width >= 639.9f))
        && (fabs(screenSize.height >= 959.9f))){
        return YES;
    }
    return NO;
}

CG_INLINE BOOL stringIsEmpty(NSString *string) {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}

CG_INLINE CGFloat getDoubleFromString(NSString *string) {
    if([string isKindOfClass:[NSNull class]]){
        return 0.0f;
    }
    if(!string){
        return 0.0f;
    }
    if([string isKindOfClass:[NSString class]]){
        if(stringIsEmpty(string)){
            return 0.0f;
        }
    }
    if([string isKindOfClass:[NSString class]]){
        if([[string lowercaseString] isEqualToString:@"<null>"] || [[string lowercaseString] isEqualToString:@"null"]){
            return 0.0f;
        }
    }
    return [string doubleValue];
}

CG_INLINE void scaleSizeOfWebView(UIWebView *webView,BOOL bounces) {
    for(id subview in webView.subviews){
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView *)subview;
            scrollView.bounces = bounces;
            [webView setFrame:CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, scrollView.contentSize.height)];
        }
    }
}
CG_INLINE BOOL writeImageData(NSData *imageData,NSString *toPath) {
    if((!imageData) || (!toPath) || ([toPath isEqualToString:@""])){
        return NO;
    }
    @try {
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:toPath atomically:YES];
        return YES;
    }
    @catch (NSException *e) {
        NSLog(@"create thumbnail exception.");
    }
    return NO;
}

CG_INLINE BOOL removeFromDocuments(NSString *filePath) {
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:NO]) {
        return [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
    }
    return NO;
}

CG_INLINE NSString* getShortDateTimeForShow(NSString *dateTimeString) {
    if (isValidString(dateTimeString) && dateTimeString.length > 3) {
        return [dateTimeString substringToIndex:dateTimeString.length-3];
    }
    
    return dateTimeString;
}

CG_INLINE CGSize getTextSizeForLabel(NSString *textString,UILabel *label,CGFloat maxWidth,CGFloat maxHeight) {
    CGSize cSize;
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil];
    cSize = [textString boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    cSize.height = (int)(cSize.height / label.frame.size.height + 1) * label.frame.size.height;
    return cSize;
}

CG_INLINE NSString* stringByRemovingControlCharacters(NSString *inputString) {
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputString rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound) {
        NSMutableString *Mmutable = [NSMutableString stringWithString:inputString];
        while (range.location != NSNotFound) {
            [Mmutable deleteCharactersInRange:range];
            range = [Mmutable rangeOfCharacterFromSet:controlChars];
        }
        return Mmutable;
    }
    return inputString;
}

CG_INLINE UIImage *createImageWithColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//找到导航栏底部的横线
CG_INLINE UIImageView *findHairlineImageViewUnder(UIView *view) {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = findHairlineImageViewUnder(subview);
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

//添加敏感度
CG_INLINE UIButton *ButtonAndImageBtnRect (CGRect frame, CGRect ImageFrame ,NSString* image)
{
    UIImageView *leftbut=[[UIImageView alloc]init];
    leftbut.frame =ImageFrame;
    
    leftbut.image = [UIImage imageNamed:image];
    
    UIButton *leftbut1=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbut1.frame =frame;
    leftbut1.tag = 200;
    
    [leftbut1 addSubview:leftbut];
    return leftbut1;
}

CG_INLINE NSString *htmlEntityDecode(NSString *string) {
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    string = [string stringByReplacingOccurrencesOfString:@"&hellip;" withString:@"……"];
    string = [string stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    string = [string stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    string = [string stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"’"];
    string = [string stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"‘"];
    return string;
}

CG_INLINE bool checkIfAllNecessaryFieldsFilled(NSArray *fields,UIButton *btn) {
    //132,19,13
    [btn setBackgroundColor:GetColorWithRGB(203, 203, 203)];
    for (int i = 0; i < fields.count; i++) {
        id obj = [fields objectAtIndex:i];
        if ([obj isKindOfClass:NSClassFromString(@"UITextField")] || [obj isKindOfClass:NSClassFromString(@"UITextView")] || [obj isKindOfClass:NSClassFromString(@"UILabel")]) {
            if ([[obj text] length] <= 0) {
                return NO;
            }
        }
        else if ([obj isKindOfClass:NSClassFromString(@"UIImageView")]) {
            if (![obj image]) {
                return NO;
            }
        }
        else if ([obj isKindOfClass:NSClassFromString(@"NSString")]) {
            if ([obj length] <= 0) {
                return NO;
            }
        }
        else {
            if ([obj respondsToSelector:@selector(text)] && [[obj text] length] <= 0) {
                return NO;
            }
        }
    }
    [btn setBackgroundColor:GetColorWithRGB(132, 19, 13)];
    return YES;
}


CG_INLINE NSString *switchImageToStringByImage(UIImage* mImage)
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(mImage.CGImage);
    BOOL isPng= (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
    
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if (isPng) {
        imageData = UIImagePNGRepresentation(mImage);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(mImage, 0.6f);
        mimeType = @"image/jpg";
    }
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
    
//    
//    NSData *imageData = UIImagePNGRepresentation(mImage);
//    NSString *baseStr = [imageData base64Encoding];
//    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                                        (CFStringRef)baseStr,
//                                                                                         NULL,
//                                                                                         CFSTR(":/?#[]@!$&’()*+,;="),
//                                                                                         kCFStringEncodingUTF8);
//    baseString=[NSString stringWithFormat:@"data:image/jpg;base64,%@",baseString];
//    return baseString;
}

//add by Lance  这种方法打电话可以回到原来的界面
CG_INLINE UIWebView *ln_makePhoneInView(UIView *aview ,NSString *phoneNumStr) {
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumStr];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [aview addSubview:callWebview];
    return callWebview;
}

CG_INLINE void drawDashLineView(UIView *lineView, int lineLength, int lineSpacing, UIColor *lineColor)
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

//是否含有表情
CG_INLINE BOOL stringContainsEmoji(NSString *string)
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
