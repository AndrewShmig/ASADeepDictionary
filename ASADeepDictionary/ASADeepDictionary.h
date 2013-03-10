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

- (NSMutableDictionary *)deepDictionary;
- (NSData *)JSON;

@end
