/* Cydia - iPhone UIKit Front-End for Debian APT
 * Copyright (C) 2008-2015  Jay Freeman (saurik)
*/

/* GNU General Public License, Version 3 {{{ */
/*
 * Cydia is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version.
 *
 * Cydia is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Cydia.  If not, see <http://www.gnu.org/licenses/>.
**/
/* }}} */

#include "CyteKit/UCPlatform.h"

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

#include "CyteKit/Application.h"

#include "iPhonePrivate.h"
#include <Menes/ObjectHandle.h>

@implementation CyteApplication : UIApplication {
}

- (void) _sendMemoryWarningNotification {
    if (kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iPhoneOS_3_0) // XXX: maybe 4_0?
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UIApplicationMemoryWarningNotification" object:[UIApplication sharedApplication]];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UIApplicationDidReceiveMemoryWarningNotification" object:[UIApplication sharedApplication]];
}

- (void) _sendMemoryWarningNotifications {
    while (true) {
        [self performSelectorOnMainThread:@selector(_sendMemoryWarningNotification) withObject:nil waitUntilDone:NO];
        sleep(2);
        //usleep(2000000);
    }
}

- (void) applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"--");
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void) applicationDidFinishLaunching:(id)unused {
    //[NSThread detachNewThreadSelector:@selector(_sendMemoryWarningNotifications) toTarget:self withObject:nil];

    if ([self respondsToSelector:@selector(setApplicationSupportsShakeToEdit:)])
        [self setApplicationSupportsShakeToEdit:NO];
}

@end