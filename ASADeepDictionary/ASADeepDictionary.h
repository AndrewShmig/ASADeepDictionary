//
//  ASADeepDictionary.h
//  ASADeepDictionary
//
//  Created by AndrewShmig on 3/10/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASADeepDictionary : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithJSON:(NSData *)jsonObject;

- (NSMutableDictionary *)dictionary;
- (NSMutableDictionary *)aliases;
- (NSData *)JSON;

- (void)setAlias:(NSString *)alias forKey:(NSString *)key;
- (void)setAlias:(NSString *)alias forKeyPath:(NSString *)keyPath;
- (void)removeAlias:(NSString *)alias;
- (void)removeAllAliases;

@end
