//
//  ACArray.h
//  ACFoundation
//
//  Created by Christopher Loonam on 8/8/15.
//
//

#import "ACObject.h"

@interface ACArray : ACObject
{
    ACInteger count;
    id *objects;
    ACInteger size;
}

+ (id)arrayWithObjects:(id)o, ...; //nil terminated list
+ (id)array;

- (id)initWithObjects:(id)o, ...;
- (id)objectAtIndex:(ACInteger)idx;
- (ACInteger)indexOfObject:(id)o;
- (ACInteger)count;
- (BOOL)containsObject:(id)o;
- (void)addObject:(id)o;

@end
