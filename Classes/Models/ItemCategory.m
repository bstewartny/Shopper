//
//  ItemCategory.m
//  Shopper
//
//  Created by Robert Stewart on 2/24/11.
//  Copyright 2011 OmegaMuse, LLC. All rights reserved.
//

#import "ItemCategory.h"


@implementation ItemCategory
@synthesize category,subCategory,name;

+ (NSArray*) parseFile:(NSString*)filename
{
	NSLog(@"filename=%@",filename);
						  
	NSMutableArray * items=[[NSMutableArray alloc] init];
	
	NSString * contents=[NSString stringWithContentsOfFile:filename];
	
	NSLog(@"got contents: %@",contents);
	
	NSArray * lines=[contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	
	for(NSString * line in lines)
	{
		NSArray * parts=[line componentsSeparatedByString:@","];
		if([parts count]==3)
		{
			ItemCategory * c=[[ItemCategory alloc] init];
			
			c.category=[parts objectAtIndex:0];
			c.subCategory=[parts objectAtIndex:1];
			c.name=[parts objectAtIndex:2];
		
			[items addObject:c];
			
			[c release];
		}
	}
	
	return [items autorelease];
}

- (void) dealloc
{
	[category release];
	[subCategory release];
	[name release];
	[super dealloc];
}


@end
