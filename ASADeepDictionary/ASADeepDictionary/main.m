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
    
    NSDictionary *dic = @{@"window":@{
                              @"position": @{
                                  @"x": @"100",
                                  @"y": @"200",
                                  @"orientation":@{
                                      @"horizontalAlign": @"YES",
                                      @"verticalAlign": @"NO"
                                      }
                                  },
                              @"size": @{
                                  @"width": @"500",
                                  @"height": @"780"
                                  }
                              }};
    ASADeepDictionary *dd = [[ASADeepDictionary alloc] initWithDictionary:dic];
    
    NSLog(@"orientation: %@", [dd valueForKey:@"window.position.orientation"]);
    
    NSLog(@"dd: %@", [dd description]);
    
  }

  return 0;
}

