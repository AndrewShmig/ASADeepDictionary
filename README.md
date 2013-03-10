ASADeepDictionary
=================

Deep dictionary using KVC (+JSON, XML)

<b>Example #1:</b> ASADeepDictionary allocation and initialization (reading and writing values)
<code>
#import <Foundation/Foundation.h>
#import "ASADeepDictionary.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool {
    
    ASADeepDictionary *dd = [[ASADeepDictionary alloc] init];
    
    [dd setValue:@"AndrewShmig" forKey:@"cookies.user.login"];
    [dd setValue:@"andrewshmig@gmail.com" forKey:@"cookies.user.email"];
    [dd setValue:@"ru_RU" forKey:@"cookies.user.locale"];
    
    NSLog(@"%@", dd);
    
    NSLog(@"login: %@", [dd valueForKey:@"cookies.user.login"]);
    NSLog(@"email: %@", [dd valueForKey:@"cookies.user.email"]);
    
    NSLog(@"user record: %@", [dd valueForKey:@"cookies.user"]);
    
  }

  return 0;
}
</code>

<b>Example #2:</b> ASADeepDictionary to JSON convertion
<code>
#import <Foundation/Foundation.h>
#import "ASADeepDictionary.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool {
    
    ASADeepDictionary *dd = [[ASADeepDictionary alloc] init];
    
    [dd setValue:@"AndrewShmig" forKey:@"cookies.user.login"];
    [dd setValue:@"andrewshmig@gmail.com" forKey:@"cookies.user.email"];
    [dd setValue:@"ru_RU" forKey:@"cookies.user.locale"];
    
    NSData *jsonData = [dd JSON];
    NSLog(@"JSON: %@", [NSString stringWithUTF8String:[jsonData bytes]]);
    
  }

  return 0;
}
</code>

<b>Example #3:</b> Init ASADeepDictionary with another dictionary
<code>
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
    
  }

  return 0;
}
</code>