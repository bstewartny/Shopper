//
//  ItemCategory.h
//  Shopper
//
//  Created by Robert Stewart on 2/24/11.
//  Copyright 2011 OmegaMuse, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ItemCategory : NSObject {
	NSString * category;
	NSString * subCategory;
	NSString * name;
}
@property(nonatomic,retain) NSString * category;
@property(nonatomic,retain) NSString * subCategory;
@property(nonatomic,retain) NSString * name;

+ (NSArray*) parseFile:(NSString*)filename;

@end
