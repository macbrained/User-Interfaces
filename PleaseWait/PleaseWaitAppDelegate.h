//
//  PleaseWaitAppDelegate.h
//  PleaseWait
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
