//
//  ACError.m
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import "ACError.h"
#import "ACString.h"

@implementation ACError

+ (id)errorWithDomain:(ACString *)domain description:(ACString *)desc code:(ACErrorCode)code
{
    return [[self alloc] initWithDomain:domain description:desc code:code];
}

- (id)initWithDomain:(ACString *)domain description:(ACString *)desc code:(ACErrorCode)code
{
    if (self = [super init])
    {
        errorDomain = domain;
        errorDescription = desc;
        errorCode = code;
    }
    return self;
}

- (ACString *)description
{
    return [[ACString alloc] initWithFormat:$("%s - Code %d : %s"), errorDomain.UTF8String, errorCode, errorDescription.UTF8String];
}

@end
