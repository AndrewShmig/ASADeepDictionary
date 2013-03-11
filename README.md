More info: http://developing-ios-apps-with-andrew-shmig.blogspot.ru/2013/03/asadeepdictionary.html

TODO: 
+ XML

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

<b>Example #4:</b> Init ASADeepDictionary with JSON object
<code>

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
</code>

<b>Output:</b>
<code>

    {
        key = value;
        key2 = value2;
        user =     {
            email = "andrewshmig@gmail.com";
            name = AndrewShmig;
        };
    }
</code>

<b>Example #5:</b> Using aliases
<code>

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
</code>

<b>Output:</b>
<code>

    login: AndrewShmig
    email: andrewshmig@gmail.com
    githubService: {
        usergroup =     {
            admin =         {
                email = "andrewshmig@gmail.com";
                login = AndrewShmig;
            };
        };
    }
    
    github usergroup: {
        admin =     {
            email = "andrewshmig@gmail.com";
            login = AndrewShmig;
        };
    }
    
    aliases: {
        "$githubService" = "cookies.github";
    }
    
    {
    cookies =     {
        github =         {
            usergroup =             {
                admin =                 {
                    email = "andrewshmig@gmail.com";
                    login = AndrewShmig;
                };
            };
        };
    };
    }
</code>
