//
//  ACDictionary.m
//  ACFoundation
//
//  Created by Christopher Loonam on 8/9/15.
//
//

#import "ACDictionary.h"
#import "ACArray.h"
#import "ACString.h"

ACArray *dictKeys;
ACArray *dictObjects;

@implementation ACDictionary

+ (id)dictionary
{
    return [self dictionaryWithKeys:[ACArray array] objects:[ACArray array]];
}

+ (id)dictionaryWithKeys:(ACArray *)keys objects:(ACArray *)objs
{
    return [[self alloc] initWithKeys:keys objects:objs];
}

- (id)init
{
    return [self initWithKeys:[ACArray array] objects:[ACArray array]];
}

- (id)initWithKeys:(ACArray *)keys objects:(ACArray *)objs
{
    if (self = [super init])
    {
        dictKeys = keys;
        dictObjects = objs;
    }
    return self;
}

- (ACArray *)keys
{
    return [dictKeys copy];
}

- (ACArray *)objects
{
    return [dictObjects copy];
}

- (id)objectForKey:(ACString *)o
{
    ACInteger idx = [dictKeys indexOfObject:o];
    return (idx >= 0) ? [dictObjects objectAtIndex:idx] : nil;
}

- (void)setObject:(id)o forKey:(ACString *)key
{
    ACInteger idx = [dictKeys indexOfObject:key];
    if (idx == -1)
    {
        [dictKeys addObject:key];
        [dictObjects addObject:o];
        return;
    }
    [dictObjects removeObjectAtIndex:idx];
    [dictObjects insertObject:o atIndex:idx];
}

- (void)removeObjectForKey:(ACString *)key
{
    ACInteger idx = [dictKeys indexOfObject:key];
    if (idx == -1)
        return;
    [dictKeys removeObjectAtIndex:idx];
    [dictObjects removeObjectAtIndex:idx];
}

- (ACString *)description
{
    ACString *desc = $("{");
    
    BOOL firstObj = YES;
    
    for (int i = 0; i < dictKeys.count; i++)
    {
        ACString *objString = [ACString stringWithFormat:$("%s%s : %s"), (firstObj) ? "" : ",", [[dictKeys objectAtIndex:i] description].UTF8String, [[dictObjects objectAtIndex:i] description].UTF8String];
        [desc appendString:objString];
        firstObj = NO;
    }
    
    [desc appendString:$("}")];
    
    return desc;
}

- (void)dealloc
{
    [super dealloc];
    [dictKeys release];
    [dictObjects release];
}

@end
