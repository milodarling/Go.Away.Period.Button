//
// Go.Away.Period.Button
//
// Safari Hook
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define PREFS_PLIST_PATH	@"/private/var/mobile/Library/Preferences/com.rcrepo.safaridefaultkeyboard.plist"
// should be using [NSHomeDirectory() stringByAppendingPathComponent:] here, but it isn't working ??

static NSString *keyboardChrome = nil;



//
// Load user preferences.
//
static void loadPreferences() {
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_PLIST_PATH];
		// NSLog(@"[Go.Away.Period.Button] loaded preferences, got this: %@", prefs);

	if (prefs && prefs[@"keyboardChrome"]) {
				// NSLog(@"[Go.Away.Period.Button] found setting for keyboardChrome: %@", prefs[@"keyboardChrome"]);
			keyboardChrome = prefs[@"keyboardChrome"];
	} else {
		// use default setting
		keyboardChrome = @"default";
	}

		// NSLog(@"[Go.Away.Period.Button] using setting: keyboardChrome = %@", keyboardChrome);
}



//
// Apply settings again when returning from background.
//
%hook Application
- (void)applicationWillEnterForeground:(UIApplication *)application {
	%orig;
	loadPreferences();
}
%end



//
// Override the keyboard type.
// Possible return values are the following...
//
//		typedef enum : NSInteger {
//	   		UIKeyboardTypeDefault,							// 0
//	   		UIKeyboardTypeASCIICapable,
//	   		UIKeyboardTypeNumbersAndPunctuation,
//	   		UIKeyboardTypeURL,								// 3
//	   		UIKeyboardTypeNumberPad,
//	   		UIKeyboardTypePhonePad,
//	   		UIKeyboardTypeNamePhonePad,
//	   		UIKeyboardTypeEmailAddress,
//	   		UIKeyboardTypeDecimalPad,
//	   		UIKeyboardTypeTwitter,
//	   		UIKeyboardTypeWebSearch,
//	   		UIKeyboardTypeAlphabet = UIKeyboardTypeASCIICapable
//		} UIKeyboardType;
//
%hook UITextInputTraits
- (int)keyboardType {
	int result = %orig;

	if (keyboardChrome) {

		if ([keyboardChrome isEqualToString:@"default"]) {
			result = 0;
				// NSLog(@"[Go.Away.Period.Button] keyboardType >> forcing value:%d", result);

		} else if ([keyboardChrome isEqualToString:@"address"]) {
			result = 3;
				// NSLog(@"[Go.Away.Period.Button] keyboardType >> forcing value:%d", result);
		}
	}

	return result;
}
%end



// Initialization stuff
%ctor {
	@autoreleasepool {
			NSLog(@" [Go.Away.Period.Button] init.");
		loadPreferences();
	}
}
