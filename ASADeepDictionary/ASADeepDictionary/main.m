//
//  main.m
//  ASADeepDictionary
//
//  Created by AndrewShmig on 3/10/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASADeepDictionary.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool {
    
    ASADeepDictionary *dd = [[ASADeepDictionary alloc] init];
    
    [dd setValue:@"Hello deep dictionary!"
          forKey:@"cookies.user.msg"];
    
    ASADeepDictionary *dd2 = [[ASADeepDictionary alloc] init];
    [dd2 setValue:@"andrewshmig@gmail.com" forKey:@"localInfo.email"];
    [dd2 setValue:@"178 MB" forKey:@"localInfo.bufferSize"];
    
    [dd setValue:[dd2 deepDictionary] forKey:@"cookies.user.info"];
    
    NSLog(@"%@", dd);
    
    NSLog(@"buffer size: %@", [dd valueForKey:@"cookies.user.info.localInfo.bufferSize"]);
    
  }

  return 0;
}

