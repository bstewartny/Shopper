#import "Place.h"

@implementation Place
@synthesize uid;
@synthesize  name;
@synthesize  address;
@synthesize  crossStreet;
@synthesize  city;
@synthesize  state;
@synthesize  postalCode;
@synthesize  phone;
@synthesize  lat;
@synthesize  lng;
@synthesize  distance;
@synthesize  category;
@synthesize twitter;

- (void) dealloc
{
	[uid release];
	[name release];
	[address release];
	[crossStreet release];
	[city release];
	[state release];
	[postalCode release];
	[phone release];
	[twitter release];
	[category release];
	[super dealloc];
}
@end
