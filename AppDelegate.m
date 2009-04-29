//
//  AppDelegate.m
//  MenuMe
//
//  Created by Brian Cooke on 4/28/09.
//  Copyright 2009 roobasoft, LLC. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate
@synthesize statusItem = _statusItem;

- (void) applicationDidFinishLaunching:(NSNotification *)aNotif
{
    dropView.delegate = self;
}

- (void) setImage:(NSImage *)aImage
{
    if (self.statusItem) {
        [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
    }

    [aImage setScalesWhenResized:YES];
    [aImage setSize:NSMakeSize(MIN(aImage.size.width, 18), MIN(aImage.size.height, 18))];
    
    self.statusItem =[[NSStatusBar systemStatusBar] statusItemWithLength:32];
    [self.statusItem setImage:aImage];
}

@end
