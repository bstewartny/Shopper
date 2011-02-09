#import <Foundation/Foundation.h>

@interface Place : NSObject 
{
	NSString * uid;
	NSString * name;
	NSString * address;
	NSString * crossStreet;
	NSString * city;
	NSString * state;
	NSString * postalCode;
	NSString * phone;
	NSString * twitter;
	BOOL shop;
	CGFloat lat;
	CGFloat lng;
	CGFloat distance;
	NSString * category;
}

@property(nonatomic,retain) NSString * uid;
@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * address;
@property(nonatomic,retain) NSString * crossStreet;
@property(nonatomic,retain) NSString * city;
@property(nonatomic,retain) NSString * state;
@property(nonatomic,retain) NSString * postalCode;
@property(nonatomic,retain) NSString * phone;
@property(nonatomic,retain) NSString * twitter;
@property(nonatomic) BOOL shop;

@property(nonatomic) CGFloat lat;
@property(nonatomic) CGFloat lng;
@property(nonatomic) CGFloat distance;

@property(nonatomic,retain) NSString * category;

@end
