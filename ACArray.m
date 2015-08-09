//
//  ACArray.m
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import "ACArray.h"
#import "ACString.h"
#import <stdlib.h>
#import <stdarg.h>

@implementation ACArray

+ (id)array
{
    return [self arrayWithObjects:nil];
}

+ (id)arrayWithObjects:(id)o, ...
{
    ACArray *array = [[self alloc] init];
    
    if (!o)
    {
        array->count = 0;
        array->objects = malloc(1);
        array->size = 1;
        return array;
    }
    
    ACInteger i = 1;
    ACInteger len = 0;
    id obj;
    
    va_list list;
    va_start(list, o);
    
    len += sizeof(o);
    
    while ((obj = va_arg(list, id)) != nil)
    {
        len += sizeof(obj);
    }
    
    va_end(list);
    va_start(list, o);
    
    array->objects = malloc(len);
    
    array->objects[0] = o;
    
    while ((obj = va_arg(list, id)) != nil)
    {
        array->objects[i] = obj;
        i++;
    }
    
    array->count = i;
    array->size = len;
    
    va_end(list);
    
    return array;
}

- (id)initWithObjects:(id)o, ...
{
    if (self = [super init])
    {
        if (!o)
        {
            count = 0;
            objects = malloc(1);
            size = 1;
            return self;
        }
        
        ACInteger i = 1;
        ACInteger len;
        id obj;
        
        va_list list;
        va_start(list, o);
        
        len += sizeof(o);
        
        while ((obj = va_arg(list, id)) != nil)
        {
            len += sizeof(obj);
        }
        
        va_end(list);
        va_start(list, o);
        
        objects = malloc(len);
        
        objects[0] = o;
        
        while ((obj = va_arg(list, id)) != nil)
        {
            objects[i] = obj;
            i++;
        }
        
        size = len;
        count = i;
        
        va_end(list);
    }
    return self;
}

- (id)objectAtIndex:(ACInteger)idx
{
    return objects[idx];
}

- (ACInteger)indexOfObject:(id)o
{
    for (int i = 0; i < count; i++)
        if ([o isEqual:o])
            return i;
    return -1;
}

- (ACInteger)count
{
    return count;
}

- (signed char)containsObject:(id)o
{
    for (int i = 0; i < count; i++)
        if ([objects[i] isEqual:o])
            return YES;
    return NO;
}

- (ACString *)description
{
    ACString *desc = $("[");
    BOOL firstObj = YES;
    
    for (int i = 0; i < count; i++)
    {
        ACString *objString = [ACString stringWithFormat:$("%s\"%s\""), (firstObj) ? "" : ",", [objects[i] description].UTF8String];
        [desc appendString:objString];
        firstObj = NO;
    }
    
    [desc appendString:$("]")];
    
    return desc;
}

- (void)addObject:(id)o
{
    size += sizeof(o);
    objects = realloc(objects, size);
    objects[count++] = o;
}

@end
