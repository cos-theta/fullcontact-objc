/*
 FCAPI+Stats.m
 fullcontact-objc
 
 Created by Duane Schleen on 10/8/12.
 
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

#import "FCAPI+Stats.h"

@implementation FCAPI (Stats)

- (void)getStats:(NSDate*)period
         success:(FCSuccessBlock)success
         failure:(FCFailureBlock)failure
{
    NSMutableDictionary *mutableParameters = nil;
    if (period){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM"];
        
        mutableParameters = [[NSMutableDictionary alloc] init];
        [mutableParameters setValue:[format stringFromDate:period] forKey:@"period"];
    }

    [self get:ENDPOINT_STATS withParameters:mutableParameters success:success failure:failure];
}

- (void)getStatsForYear:(NSString*)year
               andMonth:(NSString*)month
                success:(FCSuccessBlock)success
                failure:(FCFailureBlock)failure
{
    NSAssert(year, @"year cannot be nil");
    NSAssert(month, @"month cannot be nil");
    NSAssert([year length] == 4, @"year needs to be 4 digits");
    NSAssert([month length] == 2, @"month needs to be 2 digits");
    
    NSMutableDictionary *mutableParameters = [[NSMutableDictionary alloc] init];
    [mutableParameters setValue:[NSString stringWithFormat:@"%@-%@", year, month] forKey:@"period"];
    [self get:ENDPOINT_STATS withParameters:mutableParameters success:success failure:failure];
}

@end
