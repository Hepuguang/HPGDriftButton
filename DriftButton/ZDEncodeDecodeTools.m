//
//  ZDEncodeDecodeTools.m
//  ZDProject
//
//  Created by gorson on 8/13/15.
//  Copyright (c) 2015 1000phone. All rights reserved.
//

#import "ZDEncodeDecodeTools.h"

@implementation ZDEncodeDecodeTools

// urlEncode 编码
+ (NSString *)urlencode:(NSString *)encodeString
{
    return [encodeString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// urlDecode 解码
+ (NSString *)urldecode:(NSString *)decodeString
{
    return [decodeString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//Unicode转UTF-8中文
+ (NSString*) replaceUnicode:(NSString*)aUnicodeString

{
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
//                                                           mutabilityOption:NSPropertyListImmutable
//                                                                     format:NULL
//                                                           errorDescription:NULL];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData
                                                                    options:NSPropertyListImmutable
                                                                     format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}

//UTF-8转Unicode
+ (NSString *) utf8ToUnicode:(NSString *)string
{
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if(_char >= 'a' && _char <= 'z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if(_char >= 'A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else
        {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
        
    }
    return s;
}


/**
 base64编码
 */
+ (NSString *) base64Encode:(NSString *)string{
    //先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}
/**
 base64解码
 */
+ (NSString *) base64Dencode:(NSString *)base64String{
    if (base64String.length == 0) {
        return @"";
    }
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (string.length == 0) {
        string = base64String;
    }
    return string;
}

@end
