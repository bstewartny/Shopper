#import <Foundation/Foundation.h>
#import "ManagedObject.h"

@interface Coupon : ManagedObject {

}

@property(nonatomic,retain) NSString * uid;
@property(nonatomic,retain) NSString * title;
@property(nonatomic,retain) NSString * text;
@property(nonatomic,retain) NSString * place_uid;
@property(nonatomic,retain) NSString * place_name;
@property(nonatomic,retain) NSString * place_address;
@property(nonatomic,retain) NSString * place_location;
@property(nonatomic,retain) NSString * item_name;
@property(nonatomic,retain) NSDate * recv_date;
@property(nonatomic,retain) NSDate * active_date;
@property(nonatomic,retain) NSDate * expire_date;
@property(nonatomic,retain) NSNumber * accepted;
@property(nonatomic,retain) NSNumber * used;
@property(nonatomic,retain) NSDate * used_date;

@end
