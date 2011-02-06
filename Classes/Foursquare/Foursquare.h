#import <Foundation/Foundation.h>

@interface Foursquare : NSObject {
	NSString * token;
}

- (NSArray*) searchVenuesWithLat:(CGFloat)lat lng:(CGFloat)lng limit:(NSInteger)limit query:(NSString*)query;


@end
