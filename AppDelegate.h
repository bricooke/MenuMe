//
//  AppDelegate.h
//  MenuMe
//
//  Created by Brian Cooke on 4/28/09.
//  Copyright 2009 roobasoft, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DropView.h"

@interface AppDelegate : NSObject {
    IBOutlet DropView *dropView;
    NSStatusItem *_statusItem;
}

@property (retain) NSStatusItem *statusItem;

- (void) setImage:(NSImage *)aImage;

@end
