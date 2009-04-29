//
//  DropView.h
//  MenuMe
//
//  Created by Brian Cooke on 4/28/09.
//  Copyright 2009 roobasoft, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DropView : NSImageView {
    id delegate;
}

@property (retain) id delegate;

@end
