//
//  ACString.m
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import "ACString.h"
#import "ACError.h"
#import "ACArray.h"
#import <stdio.h>
#import <stdlib.h>
#import <string.h>
#import <stdarg.h>
#import <errno.h>

@implementation ACString

#pragma mark - Class Methods

+ (id)string
{
    return [self stringWithUTF8String:""];
}

+ (id)stringWithUTF8String:(const char *)str
{
    return [[self alloc] initWithUTF8String:str];
}

+ (id)stringWithString:(ACString *)str
{
    return [[self alloc] initWithString:str];
}

+ (id)stringWithContentsOfFile:(ACString *)path error:(ACError **)error
{
    return [[self alloc] initWithContentsOfFile:path error:error];
}

+ (id)stringWithFormat:(ACString *)fmt, ...
{
    ACString *str = [[self alloc] init];
    
    void *o;
    char *buf;
    ACInteger len = 0;
    
    va_list list;
    va_start(list, fmt);
    
    while ((o = va_arg(list, void *)) != NULL)
    {
        len += sizeof(o);
    }
    va_end(list);
    va_start(list, fmt);
    
    vasprintf(&buf, fmt.UTF8String, list);
    
    va_end(list);
    str->string = strdup(buf);
    free(buf);
    
    return str;
}

#pragma mark - Instance Methods

- (id)initWithUTF8String:(const char *)str
{
    if (self = [super init])
    {
        self->string = strdup(str);
    }
    return self;
}

- (id)initWithString:(ACString *)str
{
    return [self initWithUTF8String:str->string];
}

- (ACInteger)length
{
    return strlen(self->string);
}

- (id)initWithContentsOfFile:(ACString *)path error:(ACError **)error
{
    if (self = [super init])
    {
        char *buf;
        FILE *f;
        long fileLen;
        
        f = fopen(path->string, "r");
        if (!f)
        {
            if (error)
                *error = [ACError errorWithDomain:$("File Error") description:[ACString stringWithUTF8String:strerror(errno)] code:errno];
            return nil;
        }
        
        fseek(f, 0, SEEK_END);
        fileLen = ftell(f);
        fseek(f, 0, SEEK_SET);
        
        buf = malloc(fileLen + 1);
        fread(buf, 1, fileLen, f);
        buf[fileLen] = '\0';
        
        self->string = strdup(buf);
        
        free(buf);
        fclose(f);
    }
    return self;
}

- (id)initWithFormat:(ACString *)fmt, ...
{
    if (self = [super init])
    {
        void *o;
        char *buf;
        ACInteger len = 0;
        
        va_list list;
        va_start(list, fmt);
        
        while ((o = va_arg(list, void *)) != NULL)
        {
            len += sizeof(o);
        }
        va_end(list);
        va_start(list, fmt);
                
        vasprintf(&buf, fmt.UTF8String, list);
        
        va_end(list);
        self->string = strdup(buf);
        free(buf);
    }
    return self;
}

- (char *)UTF8String
{
    return strdup(self->string);
}

- (void)dealloc
{
    [super dealloc];
    free(self->string);
}

- (ACString *)description
{
    return self;
}

- (signed char)isEqualToString:(ACString *)str
{
    return ((strcmp(self->string, str->string)) == 0) ? YES : NO;
}

- (void)appendString:(ACString *)str
{
    ACInteger len = [self length] + [str length] + 1;
    char *newStr = malloc(len);
    strcpy(newStr, self->string);
    free(self->string);
    
    strcat(newStr, str->string);
    self->string = strdup(newStr);
    free(newStr);    
}

- (ACArray *)componentsSeparatedByString:(ACString *)str
{
    //TODO: fix
    ACArray *retval = [ACArray array];
    char *orig = strdup(self->string);
    char *delim = strdup(str->string);
    size_t delimlen = strlen(delim);
    
    ACInteger lastDelimLoc = 0;
    
    for (long i = 0; orig[i + delimlen] != '\0'; i++)
    {
        char *sample = malloc(delimlen + 1);
        for (long p = 0, c = i; p < delimlen; p++, c++)
            sample[p] = orig[c];
        sample[delimlen] = '\0';
        if (strcmp(sample, delim) == 0)
        {
            char *comp = malloc(i + 1);
            for (long p = 0; p < i; p++)
                comp[p] = orig[p + lastDelimLoc];
            comp[i] = '\0';
            ACString *component = $(comp);
            [retval addObject:component];
            
            lastDelimLoc = i + delimlen;
            
            free(comp);
        }
        free(sample);
    }
    
    free(orig);
    free(delim);
    
    return retval;
}

@end
