//
//  Terminal.m
//  OpenInSpotify
//
//  Created by Nicklas Shamlo on 28/12/08.
//  Copyright 2008 Nicklas Shamlo. All rights reserved.
//

#import "Terminal.h"

@implementation TTView (OpenInSpotifyTTView)

- (NSMenu*) OpenInSpotify_menuForEvent:(NSEvent*) event
{
  NSMenu *ctxMenu = [self OpenInSpotify_menuForEvent: event];
  
  NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
  NSUInteger c_idx = [self characterIndexForPoint:[[self window] convertBaseToScreen:[self convertPointToBase:p]]];
  NSString * str = [self string];
  NSUInteger length = [str length];
  
  NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  
  NSUInteger l,r;
  for (l = c_idx; l > 0; l--) {
    unichar l_ch = [str characterAtIndex: l];
    
    if ([set characterIsMember:l_ch]) {
      l++;
      break;
    }
  }
  for (r = c_idx + 1; r < length; r++) {
    unichar r_ch = [str characterAtIndex: r];
    
    if ([set characterIsMember:r_ch]) {
      break;
    }
  }
  
  bool found = FALSE;
  NSString *url;
  if (l > 0 && r < length) {
    url = [str substringWithRange: NSMakeRange(l, r - l)];
    if ([url hasPrefix: @"spotify:"]) {
      found = TRUE;
    }
    else if ([url hasPrefix: @"http://open.spotify.com/"]) {
      found = TRUE;
    }
  }
  
  NSMenuItem *item = [ctxMenu itemWithTitle:@"Open in Spotify"];
  if (item != nil) {
    [ctxMenu removeItem: item];
  }
  
  if (found) {
    item = [ctxMenu insertItemWithTitle: @"Open in Spotify" action:@selector(openInSpotify:) keyEquivalent:@"" atIndex:0];
    [item setToolTip: url];
    
    [self setSelectedRange: NSMakeRange(l, r - l)];
  }
  
  return ctxMenu;
}

- (void) openInSpotify: (NSMenuItem*) item 
{
  NSPasteboard *pboard = [NSPasteboard pasteboardWithUniqueName];
  NSArray *typesDeclared = [NSArray arrayWithObject:NSStringPboardType];
    
  [pboard declareTypes:typesDeclared owner:nil];
  [pboard setString:[item toolTip] forType:NSStringPboardType];
  
  NSPerformService(@"Spotify/Open link", pboard);
}

@end

