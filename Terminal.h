//
//  Terminal.h
//  OpenInSpotify
//
//  Created by Nicklas Shamlo on 28/12/08.
//  Copyright 2008 Nicklas Shamlo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TTView: NSView
- (NSString*)string;
- (void) setSelectedRange: (NSRange) range;
- (unsigned int) characterIndexForPoint:(NSPoint) point;
- (NSMenu*)menuForEvent: (NSEvent*) event;
@end
