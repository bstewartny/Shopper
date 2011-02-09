#import <Foundation/Foundation.h>
#import "ManagedObject.h"
#import "List.h"

@interface Item : ManagedObject {

}
@property(nonatomic,retain) NSString * uid;
@property(nonatomic,retain) List * list;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * notes;
@property(nonatomic,retain) NSNumber * order;

- (NSComparisonResult)compareItem:(Item*)i;

@end
