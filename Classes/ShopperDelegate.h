#import <UIKit/UIKit.h>
@class Item;
@class List;
@class Coupon;

@protocol ShopperDelegate

- (NSArray*) lists;
- (NSArray*) coupons;
- (NSArray*) places;

- (List*) addList:(NSString*)name;

- (void) reOrderLists;

- (NSArray*) placesForItem:(Item*)item;

- (NSArray*) couponsForItem:(Item*)item;

- (NSArray*) itemsForCoupon:(Coupon*)coupon;

- (void) moveListFromIndex:(int)fromIndex toIndex:(int)toIndex;

@end
