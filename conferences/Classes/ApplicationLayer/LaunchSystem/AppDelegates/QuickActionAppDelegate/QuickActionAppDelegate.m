// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "QuickActionAppDelegate.h"

#import "LaunchHandler.h"
#import "QuickActionUserActivityFactory.h"

@interface QuickActionAppDelegate ()

@property (nonatomic, strong) NSArray<id<LaunchHandler>> *launchHandlers;
@property (nonatomic, strong) QuickActionUserActivityFactory *userActivityFactory;

@end

@implementation QuickActionAppDelegate

#pragma mark - Initialization

- (instancetype)initWithLaunchHandlers:(NSArray <id<LaunchHandler>> *)launchHandlers
                   userActivityFactory:(QuickActionUserActivityFactory *)userActivityFactory {
    self = [super init];
    if (self) {
        _launchHandlers = launchHandlers;
        _userActivityFactory = userActivityFactory;
    }
    return self;
}

#pragma mark - <UIApplicationDelegate>

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    NSUserActivity *activity = [self.userActivityFactory createUserActivityFromShortcutItem:shortcutItem];
    
    for (id<LaunchHandler> launchHandler in self.launchHandlers) {
        if ([launchHandler canHandleLaunchWithActivity:activity]) {
            [launchHandler handleLaunchWithActivity:activity];
        }
    }
}

@end
