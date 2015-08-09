//
//  ACObject.m
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import "ACObject.h"
#import "ACString.h"
#import <stdio.h>
#import <stdlib.h>
#import <objc/objc-class.h>

int32_t retainCount;

@implementation ACObject

#pragma mark - Class Methods

+ (Class)class
{
    return self;
}

+ (id)alloc
{
    ACObject *o = class_createInstance(self, 0);
    o->isa = self;
    retainCount = 1;
    return o;
}

+ (BOOL)isSubclassOfClass:(Class)c
{
    return (class_getSuperclass(self) == c);
}

+ (Class)superclass
{
    return class_getSuperclass(self);
}

+ (id)new
{
    return [[self alloc] init];
}

#pragma mark - Instance Methods

- (id)init
{
    return self;
}

- (void)release
{
    if ((--retainCount) <= 0)
        [self dealloc];
}

- (int32_t)retain
{
    return ++retainCount;
}

- (int32_t)retainCount
{
    return retainCount;
}

- (void)dealloc
{
    free(self);
}

- (void)doesNotRecognizeSelector:(SEL)sel
{
    const char *selName = sel_getName(sel);
    const char *className = class_getName(self->isa);
    
    fprintf(stderr, "Class %s does not recognize selector %s", className, selName);
}

- (ACString *)description
{
    return [[ACString alloc] initWithFormat:$("Object of class %s - retain count: %d"), class_getName(self->isa), retainCount];
}

- (signed char)isKindOfClass:(Class)c
{
    return (c == isa);
}

- (signed char)isEqual:(id)o
{
    return (self == o);
}

@end
