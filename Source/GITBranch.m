//
//  GITBranch.m
//  Git
//
//  Created by Geoff Garside on 17/10/2009.
//  Copyright 2009 Geoff Garside. All rights reserved.
//

#import "GITBranch.h"
#import "GITRepo.h"
#import "GITRef.h"
#import "GITRefResolver.h"


@implementation GITBranch

@synthesize repo, ref;

+ (GITBranch *)branchWithName: (NSString *)theName inRepo: (GITRepo *)theRepo {
    GITRef *branchRef = [[theRepo refResolver] resolveRefWithName:theName];
    if ( !branchRef )
        return nil;
    return [[self class] branchFromRef:branchRef];
}
+ (GITBranch *)branchFromRef: (GITRef *)theRef {
    return [[[[self class] alloc] initFromRef:theRef] autorelease];
}

- (id)initFromRef: (GITRef *)theRef {
    if ( ![super init] )
        return nil;

    self.repo = [theRef repo];
    self.ref = theRef;

    return self;
}

- (NSString *)name {
    return [[self.ref name] stringByReplacingOccurrencesOfString:@"refs/heads/" withString:@""];
}

- (void)dealloc {
    self.repo = nil;
    self.ref = nil;
    [super dealloc];
}

@end