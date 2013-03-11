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
    
    NSDictionary *dic = @{@"key":@"value",
                          @"key2":@"value2",
                          @"user":@{
                              @"name":@"AndrewShmig",
                              @"email":@"andrewshmig@gmail.com"
                              }};
    
    ASADeepDictionary *dd = [[ASADeepDictionary alloc]
                             initWithDictionary:dic];

    ASADeepDictionary *dd2 = [[ASADeepDictionary alloc]
                              initWithJSON:[dd JSON]];
    
    NSLog(@"%@", dd2);
    
  }

  return 0;
}

