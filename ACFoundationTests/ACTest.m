//
//  ACTest.m
//  ACFoundation
//
//  Created by Christopher Loonam on 8/9/15.
//
//

#import <stdio.h>
#import "ACTest.h"

@implementation ACTest

- (void)printCategory:(ACString *)cat
{
    puts("-------------");
    printf("%s Tests\n", cat.UTF8String);
    puts("-------------");
}

- (void)ACObjectTest
{
    [self printCategory:$("ACObject")];
    ACObject *object = [[ACObject alloc] init];
    if (!object)
        puts("Error allocating memory for ACObject");
    else
        puts(object.description.UTF8String);
    
    [object release];
}

- (void)ACStringTest
{
    [self printCategory:$("ACString")];
    ACString *string = $("This is a test string. Hello, world!");
    puts("Enter a file path to write the test string to:");
    char fpath[256];
    fgets(fpath, 255, stdin);
    ACString *filePath = $(fpath);
    
    ACError *error = nil;
    [string writeToFile:filePath error:&error];
    if (error)
        puts(error.description.UTF8String), [error release], error = nil;
    puts("Reading from file that was written to");
    
    ACString *fileContents = [ACString stringWithContentsOfFile:filePath error:&error];
    if (error)
        puts(error.description.UTF8String), [error release], error = nil;
    puts("File Contents:");
    puts(fileContents.UTF8String);
    
    [string release];
    [filePath release];
    [fileContents release];
}

- (void)ACArrayTest
{
    [self printCategory:$("ACArray")];
    
    ACArray *subArray = [ACArray arrayWithObjects:$("Sub Object 1"), $("Sub Object 2"), nil];
    ACError *error = [ACError errorWithDomain:$("Domain") description:$("Description") code:12];
    ACNumber *number = [ACNumber numberWithInt:2];
    
    ACArray *array = [ACArray arrayWithObjects:$("Object 1"), subArray, error, number, nil];
    
    puts("Array should contain a string, sub array, error, and a number");
    puts(array.description.UTF8String);
    
    [array removeObjectAtIndex:2];
    
    puts("Array should contain a string, sub array, and a number");
    puts(array.description.UTF8String);

    [array insertObject:error atIndex:0];
    
    puts("Array should contain an error, string, sub array, and a number");
    puts(array.description.UTF8String);
    
    puts("Enter a file path to write the test array to:");
    char fpath[256];
    fgets(fpath, 255, stdin);
    ACString *filePath = $(fpath);
    
    ACError *err = nil;
    [array writeToFile:filePath error:&err];
    if (err)
        puts(err.description.UTF8String), [err release], err = nil;
    puts("Reading from file that was written to");
    
    ACString *fileContents = [ACString stringWithContentsOfFile:filePath error:&err];
    if (err)
        puts(error.description.UTF8String), [err release], err = nil;
    puts("File Contents:");
    puts(fileContents.UTF8String);
    
    [subArray release];
    [error release];
    [number release];
    [array release];
    [filePath release];
    [fileContents release];
}

- (void)test
{
    [self ACObjectTest];
    [self ACStringTest];
    [self ACArrayTest];
}

@end
