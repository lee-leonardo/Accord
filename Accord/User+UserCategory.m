//
//  User+UserCategory.m
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "User+UserCategory.h"

@implementation User (UserCategory)

+(void)createUser:(NSString *)username withContext:(NSManagedObjectContext *)context
{
    
    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:[NSString stringWithFormat:@"USER_%@", username] inManagedObjectContext:context];
    
    newUser.name = username;
    
}

@end
