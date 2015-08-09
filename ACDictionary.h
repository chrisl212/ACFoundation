//
//  ACDictionary.h
//  ACFoundation
//
//  Created by Christopher Loonam on 8/9/15.
//
//

#import "ACObject.h"

@class ACArray, ACString;

@interface ACDictionary : ACObject //untested

+ (id)dictionary;
+ (id)dictionaryWithKeys:(ACArray *)keys objects:(ACArray *)objs;

- (id)initWithKeys:(ACArray *)keys objects:(ACArray *)objs;

- (ACArray *)keys;
- (ACArray *)objects;
- (id)objectForKey:(ACString *)o;
- (void)setObject:(id)o forKey:(ACString *)key;
- (void)removeObjectForKey:(ACString *)key;

@end
