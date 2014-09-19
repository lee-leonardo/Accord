//
//  ChoreList.h
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Chore, User;

@interface ChoreList : NSManagedObject

@property (nonatomic, retain) NSString * admin;
@property (nonatomic, retain) id customization;
@property (nonatomic, retain) NSString * listDescription;
@property (nonatomic, retain) NSString * listIdentifier;
@property (nonatomic, retain) NSNumber * location;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *chores;
@property (nonatomic, retain) NSSet *users;
@end

@interface ChoreList (CoreDataGeneratedAccessors)

- (void)addChoresObject:(Chore *)value;
- (void)removeChoresObject:(Chore *)value;
- (void)addChores:(NSSet *)values;
- (void)removeChores:(NSSet *)values;

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
