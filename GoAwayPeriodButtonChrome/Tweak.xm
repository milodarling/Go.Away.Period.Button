//
//  Go.Away.Period.Button Tweak
//
//  Chrome Hook
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifdef DEBUG
	#define DebugLog(s, ...) NSLog(@"[Go.Away.Period.Button (Chrome)] >> %@", [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
	#define DebugLog(s, ...)
#endif


#define PREFS_PLIST_PATH	@"/private/var/mobile/Library/Preferences/com.rcrepo.safaridefaultkeyboard.plist"

static NSString *keyboardChrome = nil;



//
// Load user preferences.
//
static void loadPreferences() {
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_PLIST_PATH];
    DebugLog(@"loaded preferences, got this: %@", prefs);
	
	if (prefs && prefs[@"keyboardChrome"]) {
		DebugLog(@"found setting for keyboardChrome: %@", prefs[@"keyboardChrome"]);
		keyboardChrome = prefs[@"keyboardChrome"];
	} else {
		// use default setting
		keyboardChrome = @"default";
	}	
    DebugLog(@"using setting: keyboardChrome = %@", keyboardChrome);
}



//
// Handle notifications from Settings.
//
static void prefsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name,
						 const void *object, CFDictionaryRef userInfo) {

	DebugLog(@"******** Settings Changed Notification ********");
	system("killall -HUP com.google.chrome.ios");
}



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
- (int) keyboardType {
	int result = %orig;	
	
	if (keyboardChrome) {		
		if ([keyboardChrome isEqualToString:@"default"]) {
			result = UIKeyboardTypeDefault;
		    DebugLog(@"keyboardType >> forcing value:%d", result);
		} else if ([keyboardChrome isEqualToString:@"address"]) {
			result = UIKeyboardTypeURL;
		    DebugLog(@"keyboardType >> forcing value:%d", result);
		}
	}
	return result;
}
%end


		
// Initialization stuff
%ctor {	
	@autoreleasepool {
	    NSLog(@" Go.Away.Period.Button (Chrome) loaded.");
		loadPreferences();
		
		//start listening for notifications from Settings
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
										NULL,
										(CFNotificationCallback)prefsChanged,
										CFSTR("com.rcrepo.safaridefaultkeyboard/prefschanged-chrome"),
										NULL,
										CFNotificationSuspensionBehaviorDeliverImmediately
		);
		
		%init;
	}
}
