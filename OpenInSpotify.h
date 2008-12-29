//
//  OpenInSpotify.h
//  OpenInSpotify
//
//  Created by Nicklas Shamlo on 28/12/08.
//  Copyright 2008 Nicklas Shamlo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OpenInSpotify : NSObject {

}

+ (OpenInSpotify*) sharedInstance;
- (BOOL)shouldLog;

@end
