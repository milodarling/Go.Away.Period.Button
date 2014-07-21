NSString *settingsPath = @"/var/mobile/Library/Preferences/com.rcrepo.safaridefaultkeyboard.plist";
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
//BOOL enabled = [[prefs objectForKey:@"enabled"] boolValue];
NSString *keyboardSMS = [prefs objectForKey:@"keyboardSMS"];

%hook UITextInputTraits
	-(int) keyboardType {
		if([keyboardSMS isEqualToString:@"default"])  {
			return 0;
			return %orig;
			}
		else if ([keyboardSMS isEqualToString:@"address"]) {
			return 3;
			return %orig;
		}
		else if ([keyboardSMS isEqualToString:@"original"] || [keyboardSMS isEqualToString:@""] || keyboardSMS == nil) {
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
