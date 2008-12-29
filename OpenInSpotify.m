//
//  OpenInSpotify.m
//  OpenInSpotify
//
//  Created by Nicklas Shamlo on 28/12/08.
//  Copyright 2008 Nicklas Shamlo. All rights reserved.
//

#import "OpenInSpotify.h"

#import "Terminal.h"

#import <objc/runtime.h>


static BOOL exchangeImplementations(SEL from, SEL to, Class class)
{
  Method o_method = nil;
  Method n_method = nil;
  
  o_method = class_getInstanceMethod(class, from);
  n_method = class_getInstanceMethod(class, to);
  if (o_method == nil || n_method == nil)
      return NO;
 
  n_method->method_name = from;
  o_method->method_name = to;
  return YES;
}

@implementation OpenInSpotify

+(void) load
{
  NSLog(@"OpenInSpotify loading..");
  
  Class view = NSClassFromString(@"TTView");
  if (!view)
  {
    NSLog(@"[OpenInSpotify] ERROR: Got nil Class for TTView");
    return;
  }
  
  OpenInSpotify *plugin = [OpenInSpotify sharedInstance];
  if (plugin == nil)
  {
    NSLog(@"[OpenInSpotify] Couldn't create plugin");
  }
  
  BOOL ok = exchangeImplementations(@selector(menuForEvent:), @selector(OpenInSpotify_menuForEvent:), view);
  if (!ok) {
    NSLog(@"[OpenInSpotify] Couldn't swizzle methods");
  }
  
  //SWIZZLE(view, @selector(menuForEvent:), @selector(OpenInSpotify_menuForEvent:));
  NSLog(@"[OpenInSpotify] plugin loaded.");      
}

+ (OpenInSpotify*) sharedInstance
{
  static OpenInSpotify* plugin = nil;

  if (plugin == nil)
    plugin = [[OpenInSpotify alloc] init];
    

  return plugin;
}

- (BOOL)shouldLog
{
  return NO;
}

@end
