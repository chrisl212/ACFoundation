//
//  ACObject.h
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import <objc/objc.h>

typedef signed long int ACInteger;

#ifndef BOOL
    #define BOOL signed char
#endif
#ifndef YES
    #define YES 1
    #define NO 0
#endif

@class ACString;

@interface ACObject
{
    Class isa;
}

+ (Class)class;
+ (Class)superclass;
+ (BOOL)isSubclassOfClass:(Class)c;
+ (id)alloc;
+ (id)new;

- (id)init;
- (void)release;
- (int32_t)retain;
- (int32_t)retainCount;
- (void)dealloc;
- (void)doesNotRecognizeSelector:(SEL)sel;
- (ACString *)description;
- (BOOL)isKindOfClass:(Class)c;
- (BOOL)isEqual:(id)o;

@end
