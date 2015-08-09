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
#import <string.h>

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

- (id)init
{
    return [self initWithObjects:nil];
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
        ACString *objString = [ACString stringWithFormat:$("%s%s"), (firstObj) ? "" : ",", [objects[i] description].UTF8String];
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

- (void)insertObject:(id)o atIndex:(ACInteger)idx
{
    count++;
    size += sizeof(o);
    id *newobjs = malloc(size);
    /*
               0  1  2  3  4
      orig = [ 3, 4, 1, 9, 3]
     insert '6' at index 2
     
              0  1  2  3  4  5
      end = [ 3, 4, 6, 1, 9, 3]
     */
    
    for (ACInteger i = 0, p = 0; i < count; i++, p++)
    {
        if (i == idx)
        {
            newobjs[i] = o;
            p--;
            continue;
        }
        newobjs[i] = self->objects[p];
    }
    
    free(self->objects);
    self->objects = newobjs;
}

- (void)removeObjectAtIndex:(ACInteger)idx
{
    size_t sz = sizeof([self objectAtIndex:idx]);
    ACInteger newSize = size - sz;
    id *newobjs = malloc(newSize);
    for (ACInteger i = 0, p = 0; i < count; i++)
        if (i != idx)
            newobjs[p++] = objects[i];
    free(self->objects);
    self->objects = newobjs;
    count--;
}

- (void)dealloc
{
    [super dealloc];
    free(self->objects);
}

- (id)firstObject
{
    return [self objectAtIndex:0];
}

- (id)lastObject
{
    return [self objectAtIndex:(count-1)];
}

- (void)writeToFile:(ACString *)path error:(ACError **)error
{
    [[self description] writeToFile:path error:error];
}

#pragma mark - Copying

- (id)copy
{
    //TODO: untested
    id *objs = malloc(size);
    memcpy(objs, self->objects, size);
    ACArray *arr = [ACArray alloc];
    arr->objects = objs;
    arr->count = count;
    arr->size = size;
    return arr;
}

@end
