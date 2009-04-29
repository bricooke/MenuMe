//
//  DropView.h
//  MenuMe
//
//  Created by Brian Cooke on 4/28/09.
//

#import <Cocoa/Cocoa.h>


@interface DropView : NSImageView {
    id delegate;
}

@property (retain) id delegate;

@end
