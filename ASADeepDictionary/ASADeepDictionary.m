//
//  ASADeepDictionary.m
//  ASADeepDictionary
//
//  Created by AndrewShmig on 3/10/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import "ASADeepDictionary.h"

@implementation ASADeepDictionary {
  NSMutableDictionary *_deepDictionary;
}

#pragma mark - init
- (id)init {
  self = [super init];
  
  if(self){
    _deepDictionary = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  
  if(self) {
    _deepDictionary = [dictionary mutableCopy];
  }
  
  return self;
}

#pragma mark - JSON
- (NSData *)JSON {
  return [NSJSONSerialization
          dataWithJSONObject:_deepDictionary
          options:NSJSONWritingPrettyPrinted
          error:nil];
}

#pragma mark - KVC
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  NSArray *pathComponents = [key componentsSeparatedByString:@"."];
  
  if(pathComponents == nil || [pathComponents count] == 0)
    return;
  
  __block id currentNode = _deepDictionary;
  [pathComponents
   enumerateObjectsUsingBlock:^(id pathComponent, NSUInteger idx, BOOL *stop) {
     
     if(currentNode[pathComponent] == nil ||
        ![currentNode[pathComponent] isKindOfClass:[NSDictionary class]])
        [currentNode setValue:[NSMutableDictionary dictionary]
                       forKey:pathComponent];
     
     if(idx == [pathComponents count] - 1)
       currentNode[pathComponent] = value;
     else
       currentNode = currentNode[pathComponent];
     
   }];
}

- (id)valueForUndefinedKey:(NSString *)key {
  NSArray *pathComponents = [key componentsSeparatedByString:@"."];
  
  if(pathComponents == nil || [pathComponents count] == 0)
    return nil;
  
  __block id currentNode = _deepDictionary;
  [pathComponents
   enumerateObjectsUsingBlock:^(id pathComponent, NSUInteger idx, BOOL *stop) {
     
     if(currentNode[pathComponent] == nil) {
       
       *stop = YES;
       currentNode = nil;
       
     } else {
       currentNode = currentNode[pathComponent];
     }
     
   }];
  
  return currentNode;
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath {
  [self setValue:value forKey:keyPath];
}

- (id)valueForKeyPath:(NSString *)keyPath {
  return [self valueForUndefinedKey:keyPath];
}

#pragma mark - Description
- (NSString *) description {
  return [_deepDictionary description];
}

- (NSMutableDictionary *)deepDictionary {
  return [_deepDictionary copy];
}

#pragma mark - Dealloc
- (void)dealloc {
  [_deepDictionary release];
  [super dealloc];
}

@end
