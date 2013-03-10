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
          forKey:@"cookies.user.demo.login.temporaryInfo.msg"];
    
    NSLog(@"%@", dd);
    
  }

  return 0;
}

