#import "ShopperAppDelegate.h"
#import "ListsViewController.h"
#import "CouponViewController.h"
#import "PlaceViewController.h"
#import "List.h"
#import "UUID.h"


@interface ShopperAppDelegate (CoreDataPrivate)
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSString *)applicationDocumentsDirectory;
@end

@implementation ShopperAppDelegate

@synthesize window;
@synthesize  tabBarController;
@synthesize  listNavController;
@synthesize  couponNavController;
@synthesize  placeNavController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{        
    // Override point for customization after application launch.

	tabBarController =[[UITabBarController alloc] init];
	
	ListsViewController * listsViewController=[[ListsViewController alloc] init];
	CouponViewController * couponViewController=[[CouponViewController alloc] init];
	PlaceViewController * placeViewController=[[PlaceViewController alloc] init];
	
	listsViewController.delegate=self;
	couponViewController.delegate=self;
	placeViewController.delegate=self;
	
	
	
	listNavController=[[UINavigationController alloc] initWithRootViewController:listsViewController];
	couponNavController=[[UINavigationController alloc] initWithRootViewController:couponViewController];
	placeNavController=[[UINavigationController alloc] initWithRootViewController:placeViewController];
	
	tabBarController.viewControllers=[NSArray arrayWithObjects:listNavController,couponNavController,placeNavController,nil];
	
	[listsViewController release];
	[couponViewController release];
	[placeViewController release];
		
    // Add the view controller's view to the window and display.
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

- (NSArray*) lists
{
	return [self searchObjects:@"List" predicate:nil sortKey:@"order" sortAscending:YES];
}

- (NSArray*) coupons;
{
	return [self searchObjects:@"Coupon" predicate:nil sortKey:@"recv_date" sortAscending:YES];
}

- (NSArray*) places
{
	// fetch using foursquare API using current location
	return nil;
}

-(NSArray *) searchObjects: (NSString*) entityName predicate: (NSPredicate *) predicate sortKey: (NSString*) sortKey sortAscending: (BOOL) sortAscending
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
	[request setEntity:entity];
	
	// If a predicate was passed, pass it to the query
	if(predicate != nil)
	{
		[request setPredicate:predicate];
	}
	
	// If a sort key was passed, use it for sorting.
	if(sortKey != nil)
	{
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptors release];
		[sortDescriptor release];
	}
	
	NSError *error;
	
	NSArray * results=[[self managedObjectContext] executeFetchRequest:request error:&error];
	
	[request release];
	
	return results;
}

- (void) reOrderLists
{
	int count=0;
	for(List * list in [self lists])
	{
		list.order=[NSNumber numberWithInt:count];
		count++;
	}
	NSError * error=nil;
	
	[[self managedObjectContext] save:&error];
}


- (void) moveListFromIndex:(int)fromIndex toIndex:(int)toIndex
{
	NSLog(@"moveListFromIndex: %d to %d",fromIndex,toIndex);
	// get item at index
	NSArray * a=[self lists];
	
	NSMutableArray * tmp=[NSMutableArray arrayWithArray:a];
	
	id item=[tmp objectAtIndex:fromIndex];
	
	[tmp removeObjectAtIndex:fromIndex];
	
	if(toIndex<fromIndex)
	{
		NSLog(@"insert object at index: %d",toIndex);
		[tmp insertObject:item atIndex:toIndex];
	}
	else 
	{
		NSLog(@"insert object at index: %d",(toIndex));
		[tmp insertObject:item atIndex:toIndex];
	}
	
	// now renumber from 0...
	int displayOrder=0;
	BOOL needsSaved=NO;
	
	for(List * item in tmp)
	{
		NSNumber * currentOrder=item.order;
		if([currentOrder intValue]!=displayOrder)
		{
			NSLog(@"Changing displayOrder form %d to %d",[currentOrder intValue],displayOrder);
			[item setOrder:[NSNumber numberWithInt:displayOrder]];
			needsSaved=YES;
		}
		
		displayOrder++;
	}
	
	if(needsSaved)
	{
		NSError * error=nil;
		
		[[self managedObjectContext] save:&error];
	}
}


- (List*) addList:(NSString*)name
{
	
	List * list=[NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:[self managedObjectContext]];
	
	list.uid=[UUID GetUUID];
	list.name=name;
	
	int count=[[self lists] count];
	list.order=[NSNumber numberWithInt:count];
	
	NSLog(@"adding list with order: %d",count);
	
	
	[list save];
	
	return list;
}

- (NSArray*) placesForItem:(Item*)item
{
	return nil;
}

- (NSArray*) couponsForItem:(Item*)item
{
	return nil;
}

- (NSArray*) itemsForCoupon:(Coupon*)coupon
{
	return nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	
	NSError *error = nil;
    if (managedObjectContext != nil) 
	{
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) 
		{
			NSLog(@"Failed to save in AppDelegate.applicationWillTerminate: %@, %@", error, [error userInfo]);
			//abort();
        } 
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (NSManagedObjectModel*)managedObjectModel 
{
	if (managedObjectModel)
	{
		return managedObjectModel;
	}
	else 
	{
		managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain]; 
		return managedObjectModel;   
	}
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator 
{
	if (persistentStoreCoordinator)
	{
		return persistentStoreCoordinator;
	}
	else 
	{
		NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"shopper.sqlite"]];
	
		persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
		NSError *error = nil;
		
		[persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error];
	
		return persistentStoreCoordinator;
	}
}

- (NSManagedObjectContext *) managedObjectContext 
{	
    if (managedObjectContext) 
	{
        return managedObjectContext;
    }
	else 
	{
		managedObjectContext=[self createNewManagedObjectContext:NSOverwriteMergePolicy];
		return managedObjectContext;
	}
}

- (NSManagedObjectContext *) createNewManagedObjectContext:(id)mergePolicy
{
	NSManagedObjectContext * moc=nil;
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) 
	{
		moc = [[NSManagedObjectContext alloc] init];
		[moc setPersistentStoreCoordinator: coordinator];
		[moc setMergePolicy:mergePolicy];
	}
	return moc;
}					   

- (NSString *)applicationDocumentsDirectory 
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)dealloc 
{
	[managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
	[tabBarController release];
	[listNavController release];
	[couponNavController release];
	[placeNavController release];
    [window release];
    [super dealloc];
}


@end
