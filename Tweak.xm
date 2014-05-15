NSString *settingsPath = @"/var/mobile/Library/Preferences/com.rcrepo.safaridefaultkeyboard.plist";
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
BOOL enabled = [[prefs objectForKey:@"enabled"] boolValue];

%hook UITextInputTraits
	-(int) keyboardType {
		if (enabled == TRUE)  {
			return 0;
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
