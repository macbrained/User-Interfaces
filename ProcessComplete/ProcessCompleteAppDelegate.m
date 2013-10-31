//
//  ProcessCompleteAppDelegate.m
//  ProcessComplete
//
//  Created by Zack Smith on 11/12/10.
//  Copyright 2010 318. All rights reserved.
//

#import "ProcessCompleteAppDelegate.h"

@implementation ProcessCompleteAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[window setDefaultButtonCell:[restartButton cell]];
	[restartButton setKeyEquivalent:@"\r"];
	[self makeWindowFullScreen];
}

-(void)makeWindowFullScreen
{
	unsigned major, minor, bugFix;
	NSRect screenRect;
	// Get the shielding window level
	// Get the screen rect of our main display
	screenRect = [[NSScreen mainScreen] frame];
	[self getSystemVersionMajor:&major minor:&minor bugFix:&bugFix];
	
	NSString *myOSVersion = [NSString stringWithFormat:@"%u.%u.%u", major, minor, bugFix];
	
	NSLog(@"Found my OS Version:%@",myOSVersion);
	[ window setOpaque:NO];

	if (minor>5){
		NSLog(@"System is greater the 10.%u>10.5",minor);	
		[ window setStyleMask:NSBorderlessWindowMask];

	}
	[ window setBackgroundColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.75]];
	//[ window setBackgroundColor:[NSColor greenColor]];

	[ window setLevel:NSScreenSaverWindowLevel];
	[ window setFrame:screenRect display:YES animate:YES];
	[ window makeKeyAndOrderFront:nil];
	[ window setContentView:[window contentView]];
	// "Activate" Application
	[NSApp arrangeInFront:self];
	[NSApp activateIgnoringOtherApps:YES];
	[NSMenu setMenuBarVisible:NO];
	[NSApp requestUserAttention: NSInformationalRequest];
}

- (void)getSystemVersionMajor:(unsigned *)major
                        minor:(unsigned *)minor
                       bugFix:(unsigned *)bugFix;
{
    OSErr err;
    SInt32 systemVersion, versionMajor, versionMinor, versionBugFix;
    if ((err = Gestalt(gestaltSystemVersion, &systemVersion)) != noErr) goto fail;
    if (systemVersion < 0x1040)
    {
        if (major) *major = ((systemVersion & 0xF000) >> 12) * 10 +
            ((systemVersion & 0x0F00) >> 8);
        if (minor) *minor = (systemVersion & 0x00F0) >> 4;
        if (bugFix) *bugFix = (systemVersion & 0x000F);
    }
    else
    {
        if ((err = Gestalt(gestaltSystemVersionMajor, &versionMajor)) != noErr) goto fail;
        if ((err = Gestalt(gestaltSystemVersionMinor, &versionMinor)) != noErr) goto fail;
        if ((err = Gestalt(gestaltSystemVersionBugFix, &versionBugFix)) != noErr) goto fail;
        if (major) *major = versionMajor;
        if (minor) *minor = versionMinor;
        if (bugFix) *bugFix = versionBugFix;
    }
    
    return;
    
fail:
    NSLog(@"Unable to obtain system version: %ld", (long)err);
    if (major) *major = 10;
    if (minor) *minor = 0;
    if (bugFix) *bugFix = 0;
}

@end
