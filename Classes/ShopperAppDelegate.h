#import <UIKit/UIKit.h>
#import "ShopperDelegate.h"
#import <CoreData/CoreData.h>


@interface ShopperAppDelegate : NSObject <UIApplicationDelegate,ShopperDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	UINavigationController * listNavController;
	UINavigationController * couponNavController;
	UINavigationController * placesNavController;
	
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
}
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UINavigationController * listNavController;
@property (nonatomic, retain) UINavigationController * couponNavController;
@property (nonatomic, retain) UINavigationController * placesNavController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

- (NSManagedObjectContext *) createNewManagedObjectContext:(id)mergePolicy;
-(NSArray *) searchObjects: (NSString*) entityName predicate: (NSPredicate *) predicate sortKey: (NSString*) sortKey sortAscending: (BOOL) sortAscending;
@end

