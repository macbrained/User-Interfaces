//
//  PleaseWaitAppDelegate.m
//  PleaseWait
//

#import "PleaseWaitAppDelegate.h"

@implementation PleaseWaitAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	myInstallProgressFile = @"/private/tmp/com.pleasewait.installprogress";
	myInstallProgressTxt = @"/private/tmp/com.pleasewait.progress";
	myInstallPhaseTxt = @"/private/tmp/com.pleasewait.phase";
	// Remove any previous txt at run time.
	[myFileManager removeItemAtPath:myInstallPhaseTxt error:NULL];
	[myFileManager removeItemAtPath:myInstallProgressTxt error:NULL];
	// Activate the application
	[NSApp arrangeInFront:self];
	[NSApp activateIgnoringOtherApps:YES];
	// Start the Progress Bar
	[ self startUserProgressIndicator];
	// Hide the Dock
	[self makeWindowFullScreen];
	// Create our timer
	updateProgressBarTime = [[NSTimer scheduledTimerWithTimeInterval:1
															  target:self
															selector:@selector(readInstallProgress)
															userInfo:nil
															 repeats:YES]retain];
	[ updateProgressBarTime fire];
}

-(void)sleepNow{
	sleep(1);
}

-(void)startUserProgressIndicator
{
	[userProgressBar performSelectorOnMainThread:@selector(startAnimation:)
									  withObject:self
								   waitUntilDone:false];
}

-(void)readInstallProgress
{
	[self updateProgressBar];
	[self updateStatusTxt];
	[self updatePhaseTxt];

}

-(void)updatePhaseTxt
{
	NSError *error;
	NSString *myCurrentPhaseTxt = [NSString stringWithContentsOfFile:myInstallPhaseTxt
															   encoding:NSUTF8StringEncoding
																  error:&error];
	[ userProgressBar startAnimation:self];
	if (myCurrentPhaseTxt == nil)
	{
		//[ currentStatus setStringValue:@"Please Wait..."];
	}
	else
	{
		NSArray *myCurrentPhaseLines = [myCurrentPhaseTxt componentsSeparatedByString:@"\n"];		
		NSString *myCurrentPhaseLine = [myCurrentPhaseLines objectAtIndex:
										   [myCurrentPhaseLines count] - 2 ];
		[ currentPhase setStringValue:myCurrentPhaseLine];
	}
}
-(void)updateStatusTxt
{
	NSError *error;
	NSString *myCurrentProgressTxt = [NSString stringWithContentsOfFile:myInstallProgressTxt
															encoding:NSUTF8StringEncoding
															   error:&error];
	[ userProgressBar startAnimation:self];
	if (myCurrentProgressTxt == nil)
	{
		//[ currentStatus setStringValue:@"Please Wait..."];
	}
	else
	{
		[ currentStatus setStringValue:@"Setting up postupgrade actions..."];
		NSArray *myCurrentProgressLines = [myCurrentProgressTxt componentsSeparatedByString:@"\n"];		
		NSString *myCurrentProgressLine = [myCurrentProgressLines objectAtIndex:
											 [myCurrentProgressLines count] - 2 ];
			[ currentStatus setStringValue:myCurrentProgressLine];
	}
}
-(void)updateProgressBar
{
	NSError *error;
	NSString *myCurrentProgress = [NSString stringWithContentsOfFile:myInstallProgressFile
															encoding:NSUTF8StringEncoding
															   error:&error];
	[ userProgressBar startAnimation:self];
	if (myCurrentProgress == nil)
	{
		[ userProgressBar setIndeterminate:YES];
		//NSLog (@"%@", error);
	}
	else
	{
		NSArray *myCurrentProgressLines = [myCurrentProgress componentsSeparatedByString:@"\n"];
		[ userProgressBar setIndeterminate:NO];

		NSString *myCurrentProgressNumber = [myCurrentProgressLines objectAtIndex:
											 [myCurrentProgressLines count] -2 ];
		if ([myCurrentProgressNumber intValue] < 100) {
			[ userProgressBar setDoubleValue:[myCurrentProgressNumber doubleValue]];
		}
		else {
			[ userProgressBar setIndeterminate:YES];
		}

	}
}

-(void)stopUserProgressIndicator
{
	[userProgressBar performSelectorOnMainThread:@selector(stopAnimation:)
									  withObject:self
								   waitUntilDone:false];
}

-(void)makeWindowFullScreen
{
	[NSMenu setMenuBarVisible:NO];
	[window setOpaque:NO];
	[window setLevel:NSFloatingWindowLevel];
	[NSApp arrangeInFront:self];
	[NSApp activateIgnoringOtherApps:YES];
}


@end
