//
//  DropView.m
//  MenuMe
//
//  Created by Brian Cooke on 4/28/09.
//  Code based off drag and drop example code from 
//  http://cocoadevcentral.com/articles/000056.php

#import "DropView.h"


@implementation DropView
@synthesize delegate;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSTIFFPboardType, 
                                   NSFilenamesPboardType, nil]];
    return self;
}

- (void)dealloc
{
    [self unregisterDraggedTypes];
    [super dealloc];
}

- (void) setImage:(NSImage *)aImage
{
    [super setImage:aImage];
    [delegate setImage:aImage];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
        //are offering
        return NSDragOperationCopy;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
        //to tell them we aren't interested
        return NSDragOperationNone;
    }
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
    //we aren't particularily interested in this so we will do nothing
    //this is one of the methods that we do not have to implement
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
        //are offering
        return NSDragOperationCopy;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
        //to tell them we aren't interested
        return NSDragOperationNone;
    }
}

- (void)draggingEnded:(id <NSDraggingInfo>)sender
{
    //we don't do anything in our implementation
    //this could be ommitted since NSDraggingDestination is an infomal
    //protocol and returns nothing
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *paste = [sender draggingPasteboard];
    //gets the dragging-specific pasteboard from the sender
    NSArray *types = [NSArray arrayWithObjects:NSTIFFPboardType, NSFilenamesPboardType, nil];
    //a list of types that we can accept
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
    
    if (nil == carriedData)
    {
        //the operation failed for some reason
        NSRunAlertPanel(@"Paste Error", @"Sorry, but the past operation failed", 
                        nil, nil, nil);
        return NO;
    }
    else
    {
        //the pasteboard was able to give us some meaningful data
        if ([desiredType isEqualToString:NSTIFFPboardType])
        {
            //we have TIFF bitmap data in the NSData object
            NSImage *newImage = [[NSImage alloc] initWithData:carriedData];
            [self setImage:newImage];
            [newImage release];    
            //we are no longer interested in this so we need to release it
        }
        else if ([desiredType isEqualToString:NSFilenamesPboardType])
        {
            //we have a list of file names in an NSData object
            NSArray *fileArray = 
            [paste propertyListForType:@"NSFilenamesPboardType"];
            //be caseful since this method returns id.  
            //We just happen to know that it will be an array.
            NSString *path = [fileArray objectAtIndex:0];
            //assume that we can ignore all but the first path in the list
            NSImage *newImage = [[NSImage alloc] initWithContentsOfFile:path];
            
            if (nil == newImage)
            {
                //we failed for some reason
                NSRunAlertPanel(@"File Reading Error", 
                                [NSString stringWithFormat:
                                 @"Sorry, but I failed to open the file at \"%@\"",
                                 path], nil, nil, nil);
                return NO;
            }
            else
            {
                //newImage is now a new valid image
                [self setImage:newImage];
            }
            [newImage release];
        }
        else
        {
            //this can't happen
            NSAssert(NO, @"This can't happen");
            return NO;
        }
    }
    [self setNeedsDisplay:YES];    //redraw us with the new image
    return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
    //re-draw the view with our new data
    [self setNeedsDisplay:YES];
}


@end
