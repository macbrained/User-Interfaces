//
//  ProcessCompleteAppDelegate.h
//  ProcessComplete
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
