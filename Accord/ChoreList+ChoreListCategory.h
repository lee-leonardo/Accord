//
//  ChoreList+ChoreListCategory.h
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ChoreList.h"

@interface ChoreList (ChoreListCategory)

+(void)createChoreList:(NSString*)name withContext:(NSManagedObjectContext*)context;

@end
