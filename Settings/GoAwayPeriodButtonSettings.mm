//
//  Go.Away.Period.Button Settings
//
//

#import <Preferences/PSListController.h>


@interface GoAwayPeriodButtonSettingsController: PSListController
@end


@implementation GoAwayPeriodButtonSettingsController
- (id)specifiers {
	if (_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"GoAwayPeriodButtonSettings" target:self];
	}
	return _specifiers;
}
@end
