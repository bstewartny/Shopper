#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"

@implementation PlaceMark
@synthesize coordinate,title,subTitle;


- (void) dealloc
{
	[title release];
	[subTitle release];
	[super dealloc];
}

@end


@implementation MapViewController
@synthesize places;

- (id) initWithPlaces:(NSArray*)thePlaces index:(NSInteger)theIndex
{
	self=[super init];
	if(self)
	{
		self.places=thePlaces;
		index=theIndex;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	mapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
	mapView.showsUserLocation=TRUE;
	mapView.mapType=MKMapTypeStandard;
	
	mapView.delegate=self;
	[self.view addSubview:mapView];
	

	Place * place=[places objectAtIndex:index];
	
	CLLocationCoordinate2D location=mapView.userLocation.coordinate;
	
	location.latitude=place.lat;
	location.longitude=place.lng;
	
	MKCoordinateRegion region;
	region.center=location;
	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=0.01;
	span.longitudeDelta=0.01;
	region.span=span;
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	
	PlaceMark * placemark=[[PlaceMark alloc] init];
	
	 	
	placemark.coordinate=location;
	placemark.title=place.name;
	
	if([place.address length]>0)
	{
		placemark.subTitle=place.address;
	}
	else 
	{
		placemark.subTitle=place.category;
	}
	
	[mapView addAnnotation:placemark];
	[mapView selectAnnotation:placemark animated:YES];
	[placemark release];
	
}


/*
- (void) mapViewDidFinishLoadingMap: (MKMapView *) mapView {
    // if done loading, show the call out
    [self performSelector:@selector(dropPin) withObject:nil afterDelay:0.1];
}*/

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	annView.canShowCallout=YES;
	annView.animatesDrop=TRUE;
	return annView;
}

- (void)dealloc 
{
	[mapView release];
	[mPlacemark release];
	[places release];
    [super dealloc];
}


@end
