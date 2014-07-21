NSString *settingsPath = @"/var/mobile/Library/Preferences/com.rcrepo.safaridefaultkeyboard.plist";
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
//BOOL enabled = [[prefs objectForKey:@"enabled"] boolValue];
NSString *keyboardChrome = [prefs objectForKey:@"keyboardChrome"];

%hook UITextInputTraits
	-(int) keyboardType {
		if([keyboardChrome isEqualToString:@"default"])  {
			return 0;
			return %orig;
			}
		else if ([keyboardChrome isEqualToString:@"address"]) {
			return 3;
			return %orig;
		}
		else if ([keyboardChrome isEqualToString:@"original"] || [keyboardChrome isEqualToString:@""] || keyboardChrome == nil) {
		return %orig;
		}
		else {
			return %orig;
		}
	}
%end

void loadPreferences() {
    NSLog(@"GoAwayPeriodButton--Settings updated");
}

%ctor {
    // Initialization stuff

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadPreferences,
                                    CFSTR("com.rcrepo.safaridefaultkeyboard/prefschanged"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

    loadPreferences();
}
