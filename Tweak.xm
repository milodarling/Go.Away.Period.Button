//
//  Go.Away.Period.Button Tweak
//
//  Safari Hook
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
	#define DebugLog(s, ...) NSLog(@"[Go.Away.Period.Button (Safari)] %@", [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
	#define DebugLog(s, ...)
#endif


#define PREFS_PLIST_PATH	@"/private/var/mobile/Library/Preferences/com.rcrepo.safaridefaultkeyboard.plist"

static NSString *keyboardSafari = nil;



//
// Load user preferences.
//
static void loadPreferences() {
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PREFS_PLIST_PATH];
	DebugLog(@"loaded preferences, got this: %@", prefs);
	
	if (prefs && prefs[@"keyboardSafari"]) {
		DebugLog(@"found setting for keyboardSafari: %@", prefs[@"keyboardSafari"]);
		keyboardSafari = prefs[@"keyboardSafari"];
	} else {
		// use default setting
		keyboardSafari = @"default";
	}	
    DebugLog(@"using setting: keyboardSafari = %@", keyboardSafari);
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
- (int)keyboardType {
	int result = %orig;	
	
	if (keyboardSafari) {
		
		if ([keyboardSafari isEqualToString:@"default"]) {
			result = UIKeyboardTypeDefault;
		    DebugLog(@"keyboardType >> forcing value:%d", result);
			
		} else if ([keyboardSafari isEqualToString:@"address"]) {
			result = UIKeyboardTypeURL;
		    DebugLog(@"keyboardType >> forcing value:%d", result);
		}
	}
	
	return result;
}
%end



//
// Apply settings when Safari returns from background.
//
%hook Application
- (void)applicationWillEnterForeground:(UIApplication *)application {
	%orig;
	loadPreferences();
}
%end



// Initialization stuff
%ctor {	
	@autoreleasepool {
	    NSLog(@" Go.Away.Period.Button (MobileSafari) loaded.");
		loadPreferences();
		%init;
	}
}

