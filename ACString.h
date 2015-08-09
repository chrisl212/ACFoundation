//
//  ACString.h
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import "ACObject.h"

#define $(s) [ACString stringWithUTF8String:s]

@class ACError, ACArray;

@interface ACString : ACObject <ACCopying>
{
    char *string;
}

+ (id)string;
+ (id)stringWithUTF8String:(const char *)str;
+ (id)stringWithString:(ACString *)str;
+ (id)stringWithContentsOfFile:(ACString *)path error:(ACError **)error;
+ (id)stringWithFormat:(ACString *)fmt, ...;

- (id)initWithUTF8String:(const char *)str;
- (id)initWithString:(ACString *)str;
- (id)initWithContentsOfFile:(ACString *)path error:(ACError **)error;
- (id)initWithFormat:(ACString *)fmt, ...;
- (ACInteger)length;
- (char *)UTF8String;
- (BOOL)isEqualToString:(ACString *)str;
- (void)appendString:(ACString *)str;
- (void)writeToFile:(ACString *)path error:(ACError **)error;
//- (ACArray *)componentsSeparatedByString:(ACString *)str; not yet implemented

@end
