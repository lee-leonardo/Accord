//
//  ChoreList+ChoreListCategory.m
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "ChoreList+ChoreListCategory.h"

@implementation ChoreList (ChoreListCategory)

+(void)createChoreList:(NSString*)name withContext:(NSManagedObjectContext*)context
{
    ChoreList *newChoreList = [NSEntityDescription insertNewObjectForEntityForName:@"ChoreList" inManagedObjectContext:context];
    
    newChoreList.title = name;
    newChoreList.admin = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
}

@end
