#import <Foundation/Foundation.h>

#define kFoursquareClientID @"V2WDDIEFJXGDMXVNCUSDYPULS3P1GYHFQR444MUNG3MMUHD4"
#define kFoursquareSecret @"ONO30JJWRJ5F0RRDFAMBD5QTHNZ22XLUFTJDDDBQWJY1SXMY"
#define kFoursquareCallbackURL @"http://listradar.appspot.com/foursquareauth"
#define kFoursquareTokenURL @"https://foursquare.com/oauth2/access_token"
#define kFoursquareAuthorizeURL @"https://foursquare.com/oauth2/authorize"

// see at https://foursquare.com/oauth/

// for venue search: pass client_id and client_secret in request...

@class ASIHTTPRequest;
@interface Foursquare : NSObject {
	NSString * token;
	ASIHTTPRequest * request;
}

- (void) searchVenuesWithLat:(CGFloat)lat lng:(CGFloat)lng limit:(NSInteger)limit query:(NSString*)query target:(id)target;


@end
