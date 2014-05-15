#import <Preferences/Preferences.h>

@interface GoAwayPeriodButtonListController: PSListController {
}
@end

@implementation GoAwayPeriodButtonListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"GoAwayPeriodButton" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
