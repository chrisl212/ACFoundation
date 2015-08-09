//
//  ACError.h
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import "ACObject.h"

typedef ACInteger ACErrorCode;

@interface ACError : ACObject
{
    ACString *errorDomain;
    ACString *errorDescription;
    signed long errorCode;
}

+ (id)errorWithDomain:(ACString *)domain description:(ACString *)desc code:(ACErrorCode)code;
- (id)initWithDomain:(ACString *)domain description:(ACString *)desc code:(ACErrorCode)code;

@end
