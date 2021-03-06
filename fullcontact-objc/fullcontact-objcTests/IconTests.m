/*
 IconTests.m
 fullcontact-objc
 
 Created by Duane Schleen on 10/4/12.
 
 Copyright (c)        2013 FullContact Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "IconTests.h"

#import "TestSemaphore.h"
#import "TestContstants.h"

#import "FCAPI+Icon.h"
#import "FCResponse.h"

#import "APIOrchestrator.h"

@implementation IconTests


- (void)setUp
{
    [super setUp];
	[APIOrchestrator sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testIcon
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED
    [[APIOrchestrator api]  getIcon:@"facebook" withSize:32 andStyle:@"default" success:^(UIImage *response) {
        [[TestSemaphore sharedInstance] lift:@"testLocationNormalization"];
        STAssertNotNil(response, @"Expected an image");
    } failure:^(NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLocationNormalization"];
        STAssertNil(error, error.localizedDescription);
    }];
#elif __MAC_OS_X_VERSION_MIN_REQUIRED
    [[APIOrchestrator api]  getIcon:@"facebook" withSize:32 andStyle:@"default" success:^(NSImage *response) {
        [[TestSemaphore sharedInstance] lift:@"testLocationNormalization"];
        STAssertNotNil(response, @"Expected an image");
    } failure:^(NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLocationNormalization"];
        STAssertNil(error, error.localizedDescription);
    }];
#endif
    
    [[TestSemaphore sharedInstance] waitForKey:@"testLocationNormalization"];
}


@end
