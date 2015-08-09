//
//  main.m
//  ACFoundationTests
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import <stdio.h>
#import "ACFoundation.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char fname[256];
        
        puts("File Tests\n-----------\nEnter file name:");
        scanf("%s", fname);
        
        ACString *filePath = [ACString stringWithUTF8String:fname];
        ACError *error;
        ACString *fileContents = [ACString stringWithContentsOfFile:filePath error:&error];
        if (error)
            puts(error.description.UTF8String);
        
        if (fileContents)
            puts([fileContents UTF8String]);
        
        puts("\nString Tests\n-----------");
        
        ACString *string1 = $("Foo");
        ACString *string2 = $("Foo");
        ACString *string3 = $("Bar foo");
        
        printf("'%s' is equal to '%s' : %c\n", string1.UTF8String, string2.UTF8String, ([string1 isEqualToString:string2]) ? 'Y' : 'N');
        printf("'%s' is equal to '%s' : %c\n", string2.UTF8String, string3.UTF8String, ([string2 isEqualToString:string3]) ? 'Y' : 'N');
        
        ACString *componentTest = $("String is XYZ separated by XYZ two delimiters");
        ACArray *components = [componentTest componentsSeparatedByString:$("XYZ")];
        puts(components.description.UTF8String);

        puts("\nArray Tests\n-----------");

        ACError *testError = [ACError errorWithDomain:$("Domain") description:$("Description") code:10];
        ACArray *array = [ACArray arrayWithObjects:$("String 1"), $("String 2"), $("String 3"), $("String 4"), testError, nil];
        puts(array.description.UTF8String);
        
        printf("Array contains %s : %c\n", testError.description.UTF8String, ([array containsObject:testError]) ? 'Y' : 'N');
        printf("Array contains %s : %c", string1.description.UTF8String, ([array containsObject:string1]) ? 'Y' : 'N');
        
        [filePath release];
        [fileContents release];
    }
    return 0;
}
