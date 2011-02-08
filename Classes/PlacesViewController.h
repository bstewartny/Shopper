#import <UIKit/UIKit.h>
#import "ShopperTableViewController.h"
@class Foursquare;
@class CLLocationManager;
@interface PlacesViewController : ShopperTableViewController {
	Foursquare * foursquare;
	CLLocationManager * locationManager;
	UIActivityIndicatorView * spinner;
	NSArray * places;
}

@end
