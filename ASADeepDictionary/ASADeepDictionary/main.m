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
    [dd setValue:@{@"login":@"AndrewShmig", @"email":@"andrewshmig@gmail.com"}
          forKey:@"cookies.github.usergroup.admin"];
    
    [dd setAlias:@"githubAdmin" forKey:@"github.usergroup.admin"];
    
    NSLog(@"admin: %@", [dd valueForKey:@"cookies.$githubAdmin"]);
    
    [dd release];
    dd = nil;
  }
  
  return 0;
}

