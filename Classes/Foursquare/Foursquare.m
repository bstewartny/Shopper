#import "Foursquare.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation Foursquare

- (NSString*) escapeQueryValue:(NSString*)value
{
	NSString * v= (NSString *)CFURLCreateStringByAddingPercentEscapes(
																	  NULL, /* allocator */
																	  (CFStringRef)value,
																	  NULL, /* charactersToLeaveUnescaped */
																	  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																	  kCFStringEncodingUTF8);
	return [v autorelease];
}

- (void) searchVenuesWithLat:(CGFloat)lat lng:(CGFloat)lng limit:(NSInteger)limit query:(NSString*)query target:(id)target
{
	//http://developer.foursquare.com/docs/venues/search.html 
	
	//http://developer.foursquare.com/docs/explore.html#req=venues/search%3Fll%3D40.7,-74
	
	//https://api.foursquare.com/v2/venues/search?ll=40.7,-74&oauth_token=1VYTD24FBIWVEHXWJPQE1PX4XYAVB3NEI2O05KOWUQXEJIKB

	NSString * url=[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?llAcc=100.0&ll=%f,%f&limit=500&client_id=%@&client_secret=%@",lat,lng,kFoursquareClientID,kFoursquareSecret];

	[request cancel];
	[request release];
	
	request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
	//[request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
	//[request setSecondsToCache:60*60*24*3]; // Cache for 3 days
	
	NSMutableDictionary * userInfo=[[NSMutableDictionary alloc] init];
	
	[userInfo setObject:target forKey:@"target"];
	 	
	request.userInfo=userInfo;
	
	[userInfo release];
	
	request.requestMethod=@"GET";
	
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	[request start];
	//NSOperationQueue *queue = [PixelLifeAppDelegate sharedAppDelegate].downloadQueue;
	//[queue addOperation:request];
	//[request release];
}

- (void)requestDone:(ASIHTTPRequest *)request
{
	if([request didUseCachedResponse])
	{
		NSLog(@"Got response from cache for: %@",[request.url description]);
	}
	
    NSData *data = [request responseData];
	
	id json=[[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease] JSONValue];

	id target=[request.userInfo objectForKey:@"target"];
	
	if([target respondsToSelector:@selector(foursquare:didFindItems:)])
	{
		[target foursquare:self didFindItems:json];
	}
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	
    id target=[request.userInfo objectForKey:@"target"];
	
	if([target respondsToSelector:@selector(foursquare:didFailWithError:)])
	{
		[target foursquare:self didFailWithError:error];
	}
}

- (void) dealloc
{
	[request cancel];
	[request release];
	request=nil;
	[super dealloc];
}

@end
