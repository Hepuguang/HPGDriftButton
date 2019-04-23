//
//  ZDEncodeDecodeTools.h
//  ZDProject
//
//  Created by gorson on 8/13/15.
//  Copyright (c) 2015 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDEncodeDecodeTools : NSObject

// urlEncode 编码
+ (NSString *)urlencode:(NSString *)encodeString;
// urlDecode 解码
+ (NSString *)urldecode:(NSString *)decodeString;
//Unicode转UTF-8中文
+ (NSString*) replaceUnicode:(NSString*)aUnicodeString;
//UTF-8转Unicode
+ (NSString *) utf8ToUnicode:(NSString *)string;

/**
 base64编码
 */
+ (NSString *) base64Encode:(NSString *)string;
/**
 base64解码
 */
+ (NSString *) base64Dencode:(NSString *)base64String;



@end
