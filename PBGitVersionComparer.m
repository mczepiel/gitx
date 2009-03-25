//
//  PBGitVersionComparer.m
//  GitX
//
//  Created by Pieter de Bie on 25-03-09.
//  Copyright 2009 Pieter de Bie. All rights reserved.
//

#import "PBGitVersionComparer.h"


@implementation PBGitVersionComparer

+ (void) initialize
{
	NSLog(@"Initializing comparer");
}

- (NSString *)baseVersionFor:(NSString *)version suffix:(NSString **)suffix
{
	if ([version hasPrefix:@"v"])
		version = [version substringFromIndex:1];

	NSRange r = [version rangeOfString:@"-"];
	if (r.location != NSNotFound)
	{
		if (suffix)
			*suffix = [version substringFromIndex:r.location + 1];

		version = [version substringToIndex:r.location];
	}

	return version;
}

/*!
 @method     
 @discussion Should return NSOrderedAscending if b > a, NSOrderedDescending if b < a, and NSOrderedSame if they are equivalent.
 */
- (NSComparisonResult)compareVersion:(NSString *)versionA toVersion:(NSString *)versionB
{
	if ([versionA isEqualToString:versionB])
		return NSOrderedSame;

	NSString *suffixA = nil, *suffixB = nil;
	versionA = [self baseVersionFor:versionA suffix:&suffixA];
	versionB = [self baseVersionFor:versionB suffix:&suffixB];

	NSComparisonResult res = [versionA compare:versionB];
	if (res != NSOrderedSame)
		return res;

	if (suffixB && !suffixA)
		return NSOrderedAscending;
	
	if (suffixA && !suffixB)
		return NSOrderedDescending;

	NSLog(@"A %@, %@", versionA, versionB);

	if (!suffixA && !suffixB)
		return [versionA compare:versionB];

	return [suffixA compare:suffixB];
}

@end
