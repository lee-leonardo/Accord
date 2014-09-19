//
//  User.h
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * currentScore;
@property (nonatomic, retain) NSNumber * highScore;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *lists;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addListsObject:(NSManagedObject *)value;
- (void)removeListsObject:(NSManagedObject *)value;
- (void)addLists:(NSSet *)values;
- (void)removeLists:(NSSet *)values;

@end
