/*
 *  testMain.m
 *  GitX
 *
 *  Created by Pieter de Bie on 25-03-09.
 *  Copyright 2009 Pieter de Bie. All rights reserved.
 *
 */

#import "PBGitVersionComparer.h"

int main (int argc, char const *argv[])
{
	PBGitVersionComparer *vc = [[PBGitVersionComparer alloc] init];
	assert([vc compareVersion:@"0.6.1" toVersion:@"0.6.2"] == NSOrderedAscending);
	assert([vc compareVersion:@"0.6.2" toVersion:@"0.6.1"] == NSOrderedDescending);
	assert([vc compareVersion:@"0.6.2" toVersion:@"v0.6.2"] == NSOrderedSame);

	assert([vc compareVersion:@"0.6.2" toVersion:@"v0.6.2-32-g34523"] == NSOrderedAscending);
	assert([vc compareVersion:@"0.6.2-32-aoeuoa" toVersion:@"v0.6.2"] == NSOrderedDescending);

	assert([vc compareVersion:@"0.6.2-10-g34523" toVersion:@"v0.6.2-32-g34523"] == NSOrderedAscending);
	assert([vc compareVersion:@"v0.6.2-10-g34523" toVersion:@"0.6.2-32-g34523"] == NSOrderedAscending);

	assert([vc compareVersion:@"v0.6.2-32-g34523" toVersion:@"0.6.2-10-g34523"] == NSOrderedDescending);

	assert([vc compareVersion:@"v0.6.2-32-g34523" toVersion:@"0.6.2-32-g34523"] == NSOrderedSame);
	assert([vc compareVersion:@"v0.6.2-32-g34523" toVersion:@"v0.6.2-32-g34523"] == NSOrderedSame);
	assert([vc compareVersion:@"0.6.2-32-g34523" toVersion:@"0.6.2-32-g34523"] == NSOrderedSame);

	return 0;
}