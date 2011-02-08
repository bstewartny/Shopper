#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class MKMapView;
@class MKPlacemark;
 

@interface PlaceMark : NSObject <MKAnnotation>
{
	NSString * title;
	NSString * subTitle;
	CLLocationCoordinate2D coordinate;
}

@property(nonatomic,retain) NSString * title;
@property(nonatomic,retain) NSString * subTitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@end



@interface MapViewController : UIViewController {
	NSArray * places;
	NSInteger index;
	MKMapView *mapView;
	MKPlacemark *mPlacemark;
	//CLLocationCoordinate2D location;
}
@property(nonatomic,retain) NSArray * places;

- (id) initWithPlaces:(NSArray*)places index:(NSInteger)index;

@end
