//
//  ACNumber.m
//  ACFoundation
//
//  Created by Christopher Loonam on 8/9/15.
//
//

#import "ACNumber.h"

typedef union
{
    int intValue;
    double doubleValue;
    ACInteger integerValue;
    float floatValue;
    BOOL boolValue;
    unsigned int uintValue;
    long longValue;
    unsigned long ulongValue;
    long long longLongValue;
    unsigned long long uLongLongValue;
} ACValue;

ACValue value;

@implementation ACNumber

+ (id)numberWithInt:(int)i
{
    return [[self alloc] initWithInt:i];
}

+ (id)numberWithDouble:(double)d
{
    return [[self alloc] initWithDouble:d];
}

+ (id)numberWithFloat:(float)f
{
    return [[self alloc] initWithFloat:f];
}

+ (id)numberWithInteger:(ACInteger)integer
{
    return [[self alloc] initWithInteger:integer];
}

+ (id)numberWithBool:(BOOL)b
{
    return [[self alloc] initWithBool:b];
}

+ (id)numberWithUInt:(unsigned int)uint
{
    return [[self alloc] initWithUInt:uint];
}

+ (id)numberWithLong:(long)l
{
    return [[self alloc] initWithLong:l];
}

+ (id)numberWithULong:(unsigned long)ul
{
    return [[self alloc] initWithULong:ul];
}

+ (id)numberWithLongLong:(long long)ll
{
    return [[self alloc] initWithLongLong:ll];
}

+ (id)numberWithULongLong:(unsigned long long)ull
{
    return [[self alloc] initWithULongLong:ull];
}

- (id)init
{
    return [self initWithInt:0];
}

- (id)initWithInt:(int)i
{
    value.intValue = i;
    return self;
}

- (id)initWithDouble:(double)d
{
    value.doubleValue = d;
    return self;
}

- (id)initWithFloat:(float)f
{
    value.floatValue = f;
    return self;
}

- (id)initWithInteger:(ACInteger)integer
{
    value.integerValue = integer;
    return self;
}

- (id)initWithBool:(signed char)b
{
    value.boolValue = b;
    return self;
}

- (id)initWithUInt:(unsigned int)uint
{
    value.uintValue = uint;
    return self;
}

- (id)initWithLong:(long)l
{
    value.longValue = l;
    return self;
}

- (id)initWithULong:(unsigned long)ul
{
    value.ulongValue = ul;
    return self;
}

- (id)initWithLongLong:(long long)ll
{
    value.longLongValue = ll;
    return self;
}

- (id)initWithULongLong:(unsigned long long)ull
{
    value.uLongLongValue = ull;
    return self;
}

- (int)intValue
{
    return value.intValue;
}

- (double)doubleValue
{
    return value.doubleValue;
}

- (float)floatValue
{
    return value.floatValue;
}

- (ACInteger)integerValue
{
    return value.integerValue;
}

- (BOOL)boolValue
{
    return value.boolValue;
}

- (unsigned int)uintValue
{
    return value.uintValue;
}

- (long)longValue
{
    return value.longValue;
}

- (unsigned long)ulongValue
{
    return value.ulongValue;
}

- (long long)longLongValue
{
    return value.longLongValue;
}

- (unsigned long long)ulongLongValue
{
    return value.uLongLongValue;
}

@end
