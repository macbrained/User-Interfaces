//
//  ProcessCompleteAppDelegate.h
//  ProcessComplete
//
//  Created by Zack Smith on 11/12/10.
//  Copyright 2010 318. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ProcessCompleteAppDelegate : NSObject
{
    IBOutlet NSWindow *window;
	IBOutlet NSButton *restartButton;
}


@property (assign) IBOutlet NSWindow *window;

- (void)makeWindowFullScreen;
- (void) getSystemVersionMajor:(unsigned *)major
						 minor:(unsigned *)minor
						bugFix:(unsigned *)bugFix;


@end
