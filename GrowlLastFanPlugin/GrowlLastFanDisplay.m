//
//  GrowlLastFanDisplay.m
//  GrowlLastFanPlugin
//
//  Created by Li Bin on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GrowlLastFanDisplay.h"

#define DEFAULT_SONG_LENGTH 180000

@implementation GrowlLastFanDisplay

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)displayNotification:(GrowlApplicationNotification *)notification {    
    NSString *title = [notification title];
	NSString *text  = [notification notificationDescription];
    
    NSArray *artistAndAlbum = [text componentsSeparatedByString:@"\n"];
    
    NSString *musicPath = [NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *musicLocation = [[NSURL fileURLWithPath:musicPath] absoluteString];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setValue:@"Playing" forKey:@"Player State"];
    [info setValue:title forKey:@"Name"];
    [info setValue:[artistAndAlbum objectAtIndex:0] forKey:@"Artist"];
    [info setValue:[artistAndAlbum objectAtIndex:1] forKey:@"Album"];
    [info setValue:musicLocation forKey:@"Location"];
    [info setValue:[NSNumber numberWithInt:DEFAULT_SONG_LENGTH] forKey:@"Total Time"];
    
    NSNotification *noti = [NSNotification notificationWithName:@"com.apple.iTunes.playerInfo"
                                                         object:NULL
                                                       userInfo:info];
    [[NSDistributedNotificationCenter defaultCenter] postNotification:noti];
}

@end
