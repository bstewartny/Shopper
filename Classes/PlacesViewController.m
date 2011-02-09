#import "PlacesViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Foursquare.h"
#import "Place.h"
#import "PlaceViewController.h"

@implementation PlacesViewController

- (id) init
{
	self=[super initWithStyle:UITableViewStylePlain];
	if(self)
	{
		self.navigationItem.title=@"Places";
		self.title=@"Places";
		foursquare=[[Foursquare alloc] init];
		self.tabBarItem=[[[UITabBarItem alloc] initWithTitle:@"Places" image:nil tag:3] autorelease];
		places=nil;
	}
	return self;
}

- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
	locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
	
	spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	spinner.hidesWhenStopped=YES;
	
	CGRect b=[[UIScreen mainScreen] bounds];
	
	spinner.frame=CGRectMake(b.size.width/2-15, b.size.height/2-15, 30, 30);
	
	[self.tableView addSubview:spinner];

	[self startUpdatingLocation];
}

- (void) startUpdatingLocation
{
	[locationManager startUpdatingLocation];
	spinner.hidden=NO;
	[spinner startAnimating];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"didUpdateToLocation");
	
	[locationManager stopUpdatingLocation];
	
	// show spinner, etc.
	[foursquare searchVenuesWithLat:newLocation.coordinate.latitude	lng:newLocation.coordinate.longitude limit:50 query:nil target:self];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	[spinner stopAnimating];
	spinner.hidden=YES;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	[locationManager stopUpdatingLocation];
	[spinner stopAnimating];
	spinner.hidden=YES;
}

- (void) foursquare:(Foursquare*)fs didFindItems:(id)json
{
	NSLog(@"venue search worked: %@",[json description]);
	
	NSDictionary * response=[json objectForKey:@"response"];
	
	NSMutableArray * tmp=[[NSMutableArray alloc] init];
	NSMutableArray * shops=[[NSMutableArray alloc] init];
	
	NSArray * groups=[response objectForKey:@"groups"];
	
	for(NSDictionary * group in groups)
	{
		NSArray * items=[group objectForKey:@"items"];
		
		for(NSDictionary * item in items)
		{
			Place * place=[[Place alloc] init];
			
			NSArray * categories=[item objectForKey:@"categories"];
			
			if([categories count]>0)
			{
				NSDictionary * category=[categories objectAtIndex:0];
				
				place.category=[category objectForKey:@"name"];
			 	
			}
			
			for(NSDictionary * category in categories)
			{
				NSString * category_name=[category objectForKey:@"name"];
				
				if ([category_name isEqualToString:@"Post Office"] ||
					[category_name isEqualToString:@"Drugstore & Pharmacy"])
				{
					place.shop=YES;
					break;
				}
				
				NSArray * parents=[category objectForKey:@"parents"];
				
				for(NSString * parent in parents)
				{
					if([parent isEqualToString:@"Shops"] ||
					   [parent isEqualToString:@"Food"] ||
					   [parent isEqualToString:@"Food & Drink"] ||
					   [parent isEqualToString:@"Nightlife"] )
					{
						place.shop=YES;
						break;
					}
				}
				
				if(place.shop)
				{
					break;
				}
			}
			
			if(place.shop)
			{
				[shops addObject:place];
			}
			
			place.uid=[item objectForKey:@"id"];
			
			place.name=[item objectForKey:@"name"];
			
			NSDictionary * location=[item objectForKey:@"location"];
			
			place.address=[location objectForKey:@"address"];
			place.city=[location objectForKey:@"city"];
			place.postalCode=[location objectForKey:@"postalCode"];
			place.crossStreet=[location objectForKey:@"crossStreet"];
			
			place.lat=[[location objectForKey:@"lat"] floatValue];
			place.lng=[[location objectForKey:@"lng"] floatValue];
			
			
			NSDictionary * contact=[item objectForKey:@"contact"];
			
			place.phone=[contact objectForKey:@"phone"];
			place.twitter=[contact objectForKey:@"twitter"];
			
			[tmp addObject:place];
			
			[place release];
			
		}
	}
	
	NSLog(@"Found %d total places and %d shops",[tmp count],[shops count]);
	
	if ([shops count]>0) 
	{
		[places release];
		places=[shops retain];
	}
	else
	{
		[places release];
		places=[tmp retain];
	}
	
	[shops release];
	[tmp release];
	
	// hide spinner, etc.
	[spinner stopAnimating];
	spinner.hidden=YES;
	
	[self.tableView reloadData];
}

- (void) foursquare:(Foursquare*)fs didFailWithError:(NSError*)error
{
	[spinner stopAnimating];
	spinner.hidden=YES;
	
	NSLog(@"venue search failed: %@",[error userInfo]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return [places count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Place * place=[places objectAtIndex:indexPath.row];
    
	// Configure the cell...
    cell.textLabel.text=place.name;
	
	if([place.category length]>0)
	{
		cell.detailTextLabel.text=place.category;
	}
	else 
	{
		cell.detailTextLabel.text=place.address;
	}

	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{    
	Place * place=[places objectAtIndex:indexPath.row];
	
	PlaceViewController * placeView=[[PlaceViewController alloc] initWithPlace:place];
	
	[self.navigationController pushViewController:placeView animated:YES];
	
	[placeView release];
}

- (void)dealloc 
{
	[spinner release];
	[locationManager release];
	[foursquare release];
    [super dealloc];
}

@end

