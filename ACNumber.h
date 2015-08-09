//
//  ACNumber.h
//  ACFoundation
//
//  Created by Christopher Loonam on 8/9/15.
//
//

#import "ACObject.h"

@interface ACNumber : ACObject

+ (id)numberWithInt:(int)i;
+ (id)numberWithDouble:(double)d;
+ (id)numberWithFloat:(float)f;
+ (id)numberWithInteger:(ACInteger)integer;
+ (id)numberWithBool:(BOOL)b;
+ (id)numberWithUInt:(unsigned int)uint;
+ (id)numberWithLong:(long)l;
+ (id)numberWithULong:(unsigned long)ul;
+ (id)numberWithLongLong:(long long)ll;
+ (id)numberWithULongLong:(unsigned long long)ull;

- (id)initWithInt:(int)i;
- (id)initWithDouble:(double)d;
- (id)initWithFloat:(float)f;
- (id)initWithInteger:(ACInteger)integer;
- (id)initWithBool:(BOOL)b;
- (id)initWithUInt:(unsigned int)uint;
- (id)initWithLong:(long)l;
- (id)initWithULong:(unsigned long)ul;
- (id)initWithLongLong:(long long)ll;
- (id)initWithULongLong:(unsigned long long)ull;

- (int)intValue;
- (double)doubleValue;
- (float)floatValue;
- (ACInteger)integerValue;
- (BOOL)boolValue;
- (unsigned int)uintValue;
- (long)longValue;
- (unsigned long)ulongValue;
- (long long)longLongValue;
- (unsigned long long)ulongLongValue;

@end
