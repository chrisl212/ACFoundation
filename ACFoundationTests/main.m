//
//  main.m
//  ACFoundationTests
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import <stdio.h>
#import "ACTest.h"

int main(int argc, const char * argv[])
{
    ACTest *test = [[ACTest alloc] init];
    [test test];
    
    [test release];
    return 0;
}
