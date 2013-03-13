More info: http://developing-ios-apps-with-andrew-shmig.blogspot.ru/2013/03/asadeepdictionary.html

ASADeepDictionary
=================

Deep dictionary using KVC (+JSON)

<b>Example #1:</b> ASADeepDictionary allocation and initialization (writing and reading values)
````objective-c
    ASADeepDictionary *dd = [[ASADeepDictionary alloc] init];
    
    [dd setValue:@"AndrewShmig" forKey:@"cookies.user.login"];
    [dd setValue:@"andrewshmig@gmail.com" forKey:@"cookies.user.email"];
    [dd setValue:@"ru_RU" forKey:@"cookies.user.locale"];
    
    NSLog(@"login: %@", [dd valueForKey:@"cookies.user.login"]);
    NSLog(@"email: %@", [dd valueForKey:@"cookies.user.email"]);
    
    NSLog(@"user record: %@", [dd valueForKey:@"cookies.user"]);
````

<b>Output:</b>
````objective-c
    login: AndrewShmig
    email: andrewshmig@gmail.com 
    user record: {
        email = "andrewshmig@gmail.com";
        locale = "ru_RU";
        login = AndrewShmig;
    } 
````

<b>Example #2:</b> ASADeepDictionary to JSON convertion
````objective-c
    ASADeepDictionary *dd = [[ASADeepDictionary alloc] init];
    
    [dd setValue:@"AndrewShmig" forKey:@"cookies.user.login"];
    [dd setValue:@"andrewshmig@gmail.com" forKey:@"cookies.user.email"];
    [dd setValue:@"ru_RU" forKey:@"cookies.user.locale"];
    
    NSData *jsonData = [dd JSON];
    NSLog(@"JSON: %@", [NSString stringWithUTF8String:[jsonData bytes]]);
````

<b>Output:</b>
````objective-c
    JSON: {
    "cookies" : {
        "user" : {
            "login" : "AndrewShmig",
            "email" : "andrewshmig@gmail.com",
            "locale" : "ru_RU"
        }
    }
    }
````

<b>Example #3:</b> Init ASADeepDictionary with another dictionary
````objective-c
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
````

<b>Output:</b>
````objective-c
    orientation: {
        horizontalAlign = YES;
        verticalAlign = NO;
    }
````

<b>Example #4:</b> Init ASADeepDictionary with JSON object
````objective-c
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
````

<b>Output:</b>
````objective-c
    {
        key = value;
        key2 = value2;
        user =     {
            email = "andrewshmig@gmail.com";
            name = AndrewShmig;
        };
    }
````

<b>Example #5:</b> Using aliases
````objective-c
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
````

<b>Output:</b>
````objective-c
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
````

<b>Example #6:</b> Array iteration with '#' placeholder
````objective-c
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
````

<b>Output:</b>
````objective-c
    {
    cookies =     {
        localstoragetype =         {
            xml =             {
                data =                 (
                                        {
                        age = 21;
                        name = Andrew;
                    },
                                        {
                        age = 25;
                        name = Igori;
                    },
                                        {
                        age = 19;
                        name = Masha;
                    }
                );
            };
        };
    };
    }
    
    Andrew is 21 years old!
    Igori is 25 years old!
    Masha is 19 years old!
````
