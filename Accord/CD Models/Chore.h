//
//  Chore.h
//  Accord
//
//  Created by Leonardo Lee on 9/19/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Chore : NSManagedObject

@property (nonatomic, retain) NSString * choreDescription;
@property (nonatomic, retain) NSString * choreIdentifier;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * instructions;
@property (nonatomic, retain) NSNumber * recurring;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSManagedObject *list;

@end
