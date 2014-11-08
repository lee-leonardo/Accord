//
//  Chore+ChoreCategory.m
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "Chore+ChoreCategory.h"

@implementation Chore (ChoreCategory)

+(void)createChoreMacro:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Chore *newChore = [NSEntityDescription insertNewObjectForEntityForName:@"Chore" inManagedObjectContext:context];
    newChore.choreIdentifier = name;
    
}

@end
