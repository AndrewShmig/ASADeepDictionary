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
    
    [dd setAlias:@"adminInfo" forKey:@"cookies.github.usergroup.admin"];
    [dd setAlias:@"githubService" forKeyPath:@"cookies.github"];
    
    NSLog(@"login: %@", [dd valueForKey:@"$adminInfo.login"]);
    NSLog(@"email: %@", [dd valueForKey:@"$adminInfo.email"]);
    
    NSLog(@"githubService: %@", [dd valueForKey:@"$githubService"]);
    NSLog(@"github usergroup: %@", [dd valueForKey:@"$githubService.usergroup"]);
    
    [dd removeAlias:@"adminInfo"];
    
    NSLog(@"aliases: %@", [dd aliases]);
    
    NSLog(@"%@", dd);
    
  }
  
  return 0;
}

