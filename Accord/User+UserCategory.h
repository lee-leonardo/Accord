//
//  User+UserCategory.h
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "User.h"

@interface User (UserCategory)

+(void)createUser:(NSString *)username withContext:(NSManagedObjectContext *)context;

@end
