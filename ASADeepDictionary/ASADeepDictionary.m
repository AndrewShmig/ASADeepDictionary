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
  NSMutableDictionary *_aliases;
}

#pragma mark - init
- (id)init {
  self = [super init];
  
  if(self){
    _deepDictionary = [[NSMutableDictionary alloc] init];
    _aliases = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  
  if(self) {
    _deepDictionary = [dictionary mutableCopy];
    _aliases = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

- (id)initWithJSON:(NSData *)jsonObject {
  self = [super init];
  
  if(self) {
    _deepDictionary = [NSJSONSerialization
                       JSONObjectWithData:jsonObject
                       options:NSJSONReadingMutableContainers
                       error:nil];
    
    _aliases = [[NSMutableDictionary alloc] init];
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
  key = [self ASA_PRIVATE_METHOD_parseAliasesInKeyPath:key];
  
  NSArray *pathComponents = [key componentsSeparatedByString:@"."];
  
  if(pathComponents == nil || [pathComponents count] == 0)
    return;
  
  __block id currentNode = _deepDictionary;
  [pathComponents
   enumerateObjectsUsingBlock:^(id pathComponent, NSUInteger idx, BOOL *stop) {
     
     id nextNode = currentNode[pathComponent];
     
     BOOL nextNodeIsNil = (nextNode == nil);
     BOOL nextNodeIsDictionary = [nextNode
                                  isKindOfClass:[NSMutableDictionary class]];
     BOOL lastPathComponent = (idx == [pathComponents count] - 1);
     
     if((nextNodeIsNil || !nextNodeIsDictionary) && !lastPathComponent) {
       [currentNode setObject:[NSMutableDictionary dictionary]
                       forKey:pathComponent];
     } else if(idx == [pathComponents count] - 1) {
       currentNode[pathComponent] = [value mutableCopy];
     }
     
     currentNode = currentNode[pathComponent];
     
   }];
}

- (id)valueForUndefinedKey:(NSString *)key {
  key = [self ASA_PRIVATE_METHOD_parseAliasesInKeyPath:key];
  
  NSArray *pathComponents = [key componentsSeparatedByString:@"."];
  
  if(pathComponents == nil || [pathComponents count] == 0)
    return nil;
  
  __block id currentNode = _deepDictionary;
  [pathComponents
   enumerateObjectsUsingBlock:^(id pathComponent, NSUInteger idx, BOOL *stop) {
     
     id nextNode = nil;
     
     if([pathComponent hasPrefix:@"#"]) { // array index
       NSString *indexAsString = [pathComponent substringFromIndex:1];
       int indexAsInteger = [indexAsString intValue];
       
       BOOL validArrayIndex = [indexAsString intValue] < [currentNode count];
       BOOL currentNodeIsArray = [currentNode
                                  isKindOfClass:[NSMutableArray class]];
       
       if(validArrayIndex && currentNodeIsArray)
         nextNode = currentNode[indexAsInteger];
     } else {
       nextNode = currentNode[pathComponent];
     }
     
     if(nextNode == nil)
       *stop = YES;
     
     currentNode = nextNode;
     
   }];
  
  return currentNode;
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath {
  [self setValue:value forKey:keyPath];
}

- (id)valueForKeyPath:(NSString *)keyPath {
  return [self valueForUndefinedKey:keyPath];
}

- (void)setAlias:(NSString *)alias forKey:(NSString *)key {
  [_aliases setObject:key
              forKey:[NSString stringWithFormat:@"$%@", alias]];
}

- (void)setAlias:(NSString *)alias forKeyPath:(NSString *)keyPath {
  [self setAlias:alias forKey:keyPath];
}

- (void)removeAlias:(NSString *)alias {
  [_aliases removeObjectForKey:[NSString stringWithFormat:@"$%@", alias]];
}

- (void)removeAllAliases {
  [_aliases removeAllObjects];
}

#pragma mark - Description & main getters
- (NSString *) description {
  return [_deepDictionary description];
}

- (NSMutableDictionary *)dictionary {
  return [[_deepDictionary copy] autorelease];
}

- (NSMutableDictionary *)aliases {
  return [[_aliases copy] autorelease];
}

#pragma mark - Dealloc
- (void)dealloc {
  [_deepDictionary release];
  [_aliases release];
  [super dealloc];
}

#pragma mark - Private methods
- (NSString *)ASA_PRIVATE_METHOD_parseAliasesInKeyPath:(NSString *)keyPath {
  NSMutableString *parsedString = [[NSMutableString alloc] init];
  
  NSArray *pathComponents = [keyPath componentsSeparatedByString:@"."];
  for(NSString *pathComponent in pathComponents) {
    if(_aliases[pathComponent] != nil) {
      [parsedString appendString:_aliases[pathComponent]];
    } else {
      [parsedString appendString:pathComponent];
    }
    
    [parsedString appendString:@"."];
  }
  
  // removing last '.' char
  [parsedString
   deleteCharactersInRange:NSMakeRange(parsedString.length - 1, 1)];
  
  [parsedString autorelease];
  
  return parsedString;
}

@end
