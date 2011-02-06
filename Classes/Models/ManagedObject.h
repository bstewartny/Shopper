#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ManagedObject : NSManagedObject {

}

- (void) save;
- (void) delete;

@end
