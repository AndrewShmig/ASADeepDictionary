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
    
    NSArray *data = @[@{@"name":@"Andrew", @"age":@"21"},
                      @{@"name":@"Igori", @"age":@"25"},
                      @{@"name":@"Masha", @"age":@"19"}];
    
    [dd setAlias:@"data" forKey:@"cookies.localstoragetype.xml.data"];
    [dd setValue:data forKey:@"$data"];
    
    NSLog(@"%@", dd);
    
    NSUInteger count = [[dd valueForKey:@"$data"] count];
    for(int i=0; i<count; i++) {
      NSString *namePath = [NSString stringWithFormat:@"$data.#%d.name", i];
      NSString *agePath  = [NSString stringWithFormat:@"$data.#%d.age", i];
      
      NSString *name = [dd valueForKey:namePath];
      NSString *age = [dd valueForKey:agePath];
      
      NSLog(@"%@ is %@ years old!", name, age);
    }
    
    
    [dd release];
    dd = nil;
  }
  
  return 0;
}

