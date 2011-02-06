#import <Foundation/Foundation.h>
#import "ManagedObject.h"
@class Item;

@interface List : ManagedObject 
{

}

@property(nonatomic,retain) NSString * uid;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSNumber * order;
@property(nonatomic,retain) NSSet * items;

- (NSArray*) orderedItems;

- (Item*) addItemWithName:(NSString*)name;
- (void) moveItemFromIndex:(int)fromIndex toIndex:(int)toIndex;

- (void) reOrderItems;

@end
