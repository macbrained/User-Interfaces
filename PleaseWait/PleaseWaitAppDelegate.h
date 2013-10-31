//
//  PleaseWaitAppDelegate.h
//  PleaseWait
//
//  Created by Zack Smith on 10/19/10.
//  Copyright 2010 318. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PleaseWaitAppDelegate : NSObject {
    NSWindow *window;
	NSFileManager *myFileManager;
	NSTimer *updateProgressBarTime;
	NSString *myInstallProgressFile;
	NSString *myInstallProgressTxt;
	NSString *myInstallPhaseTxt;
	NSString *InstallProgressTxt;
	IBOutlet NSProgressIndicator *userProgressBar;
	IBOutlet NSTextField *currentStatus;
	IBOutlet NSTextField *currentPhase;
}

@property (assign) IBOutlet NSWindow *window;

- (void) startUserProgressIndicator;
- (void) stopUserProgressIndicator;
- (void) sleepNow;
- (void) makeWindowFullScreen;
- (void) readInstallProgress;
- (void) updateProgressBar;
- (void) updateStatusTxt;
- (void) updatePhaseTxt;
@end
