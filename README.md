ASADeepDictionary
=================

Deep dictionary using KVC (+JSON, XML)

<b>Example #1:</b> ASADeepDictionary allocation and initialization (writing and reading values)
<code>

    ASADeepDictionary *dd = [[ASADeepDictionary alloc] init];
    
    [dd setValue:@"AndrewShmig" forKey:@"cookies.user.login"];
    [dd setValue:@"andrewshmig@gmail.com" forKey:@"cookies.user.email"];
    [dd setValue:@"ru_RU" forKey:@"cookies.user.locale"];
    
    NSLog(@"login: %@", [dd valueForKey:@"cookies.user.login"]);
    NSLog(@"email: %@", [dd valueForKey:@"cookies.user.email"]);
    
    NSLog(@"user record: %@", [dd valueForKey:@"cookies.user"]);
</code>

<b>Output:</b>
<code>

    login: AndrewShmig
    email: andrewshmig@gmail.com 
    user record: {
        email = "andrewshmig@gmail.com";
        locale = "ru_RU";
        login = AndrewShmig;
    } 
    
</code>

<b>Example #2:</b> ASADeepDictionary to JSON convertion
<code> 

    ASADeepDictionary *dd = [[ASADeepDictionary alloc] init];
    
    [dd setValue:@"AndrewShmig" forKey:@"cookies.user.login"];
    [dd setValue:@"andrewshmig@gmail.com" forKey:@"cookies.user.email"];
    [dd setValue:@"ru_RU" forKey:@"cookies.user.locale"];
    
    NSData *jsonData = [dd JSON];
    NSLog(@"JSON: %@", [NSString stringWithUTF8String:[jsonData bytes]]);
</code>

<b>Output:</b>
<code>

    JSON: {
    "cookies" : {
        "user" : {
            "login" : "AndrewShmig",
            "email" : "andrewshmig@gmail.com",
            "locale" : "ru_RU"
        }
    }
}
</code>

<b>Example #3:</b> Init ASADeepDictionary with another dictionary
<code>

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
</code>

<b>Output:</b>
<code>

    orientation: {
        horizontalAlign = YES;
        verticalAlign = NO;
    }
</code>
