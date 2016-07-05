//
//  CoreDataTests.m
//  CoreDataTests
//
//  Created by Rahul Malik on 06/07/16.
//  Copyright © 2016 Rahul Malik. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "objc/runtime.h"
#import "Cart.h"

@interface CoreDataTests : XCTestCase
@property (strong, nonatomic) NSString *entityName;
@property (strong, nonatomic) NSManagedObjectModel *model;
@property (strong, nonatomic) NSPersistentStoreCoordinator *coordinator;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSString *tempFilePath;
@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) NSString *storeName;
@end

@implementation CoreDataTests

- (void)setUp
{
    [super setUp];
    // Setup entity name
    self.entityName = @"Cart";
    
    // Setup my model and coordinator
    NSURL* urlToModel = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"RetailStore" ofType:@"momd"]];
    self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:urlToModel];
    self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];

    // Create the temp directory
    self.storeName = @"test.sqllite";
    self.tempFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"UnitTests"];
    self.fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    if (![self.fileManager fileExistsAtPath:self.tempFilePath])
        [self.fileManager createDirectoryAtPath:self.tempFilePath withIntermediateDirectories: YES attributes:nil error:&error];
    
    // Remove the existing store path
    [self clearTempDBs];
    
    // Add the new persistent Store
    [self.coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil
                                             URL:[NSURL fileURLWithPath:[self.tempFilePath stringByAppendingPathComponent:self.storeName]]
                                         options:nil
                                           error:&error];
    
    // Setup the context
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.context setPersistentStoreCoordinator:self.coordinator];
}

- (void)tearDown
{
    self.model = nil;
    self.coordinator = nil;
    self.context = nil;
    [self clearTempDBs];
    self.tempFilePath = nil;
    self.fileManager = nil;
    self.entityName = nil;
    self.storeName = nil;
    [super tearDown];
}

- (void)clearTempDBs
{
    NSError* error;
    NSString *persistentStoreFileString = [self.tempFilePath stringByAppendingPathComponent:self.storeName];
    if ([self.fileManager fileExistsAtPath:persistentStoreFileString])
        [self.fileManager removeItemAtPath:persistentStoreFileString error:&error];
    
    persistentStoreFileString = [self.tempFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-shm", self.storeName]];
    if ([self.fileManager fileExistsAtPath:persistentStoreFileString])
        [self.fileManager removeItemAtPath:persistentStoreFileString error:&error];
    
    persistentStoreFileString = [self.tempFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-wal", self.storeName]];
    if ([self.fileManager fileExistsAtPath:persistentStoreFileString])
        [self.fileManager removeItemAtPath:persistentStoreFileString error:&error];
}

- (NSDictionary*) getPropertiesWithTypes:(NSString*)objectName
{
    NSMutableDictionary *returnDictionary = [[NSMutableDictionary alloc] init];
    id LenderClass = NSClassFromString(objectName);
    if (LenderClass == nil)
        return returnDictionary;
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
    for (i = 0; i < outCount; i++)
    {
        // Retrieve all of the raw information
        objc_property_t property = properties[i];
        NSString *propStr = [[NSString alloc] initWithCString:property_getName(property) encoding:NSASCIIStringEncoding];
        const char * type = property_getAttributes(property);
        NSString * typeString = [NSString stringWithUTF8String:type];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        
        // Retrieve the type
        NSString* propType = nil;
        if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1)
        {
            propType = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];  //turns @"NSDate" into NSDate
        }
        
        [returnDictionary setValue:propType forKey:propStr];
    }
    return returnDictionary;
}

- (void)testTimestampAttributeTest
{
    NSDictionary *properties = [self getPropertiesWithTypes: self.entityName];
    NSString *fieldName;
    NSString *dataType;
    
    fieldName = @"timeStamp";
    dataType = @"NSDate";
    
    XCTAssertTrue([properties.allKeys containsObject:fieldName], @"Cart object doesn't contain field: %@", fieldName);
    XCTAssertTrue([[properties valueForKey:fieldName] isEqualToString:dataType], @"%@ is not of type: %@", fieldName, dataType);
    
}

- (void)testImageAttributeTest
{
    NSDictionary *properties = [self getPropertiesWithTypes: self.entityName];
    NSString *fieldName;
    NSString *dataType;
    
    fieldName = @"img";
    dataType = @"NSString";
    
    XCTAssertTrue([properties.allKeys containsObject:fieldName], @"Cart object doesn't contain field: %@", fieldName);
    XCTAssertTrue([[properties valueForKey:fieldName] isEqualToString:dataType], @"%@ is not of type: %@", fieldName, dataType);
}

- (void)testDescriptionAttributeTest
{
    NSDictionary *properties = [self getPropertiesWithTypes: self.entityName];
    NSString *fieldName;
    NSString *dataType;
    
    fieldName = @"dec";
    dataType = @"NSString";
    
    XCTAssertTrue([properties.allKeys containsObject:fieldName], @"Cart object doesn't contain field: %@", fieldName);
    XCTAssertTrue([[properties valueForKey:fieldName] isEqualToString:dataType], @"%@ is not of type: %@", fieldName, dataType);
}

- (void)testNameAttributeTest
{
    NSDictionary *properties = [self getPropertiesWithTypes: self.entityName];
    NSString *fieldName;
    NSString *dataType;
    
    fieldName = @"name";
    dataType = @"NSString";
    
    XCTAssertTrue([properties.allKeys containsObject:fieldName], @"Cart object doesn't contain field: %@", fieldName);
    XCTAssertTrue([[properties valueForKey:fieldName] isEqualToString:dataType], @"%@ is not of type: %@", fieldName, dataType);
}

- (void)testInsertAndDelete
{
    Cart *newCart = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:self.context];
    newCart.timeStamp = [NSDate date];
    newCart.name = @"testName";
    newCart.dec = @"testDec";
    newCart.img = @"test.img";
    newCart.cost = 10;
    
    [self.context insertObject:newCart];
    NSError* saveError = nil;
    [self.context save:&saveError];
    
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.context setPersistentStoreCoordinator:self.coordinator];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: self.entityName];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@",@"testName"]];
    NSError* fetchError = nil;
    NSArray *items = [self.context executeFetchRequest:request error:&fetchError];

    XCTAssertNil(saveError, @"There was an error trying to save the data");
    XCTAssertNil(fetchError, @"There was an error trying to fetch the data");
    XCTAssertEqual(items.count, 1, @"The insert failed");
    
    [self.context deleteObject:items.firstObject];
    [self.context save:&saveError];
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.context setPersistentStoreCoordinator:self.coordinator];
    NSArray *deletedItems = [self.context executeFetchRequest:request error:&fetchError];
    
    XCTAssertNil(saveError, @"There was an error trying to save the data");
    XCTAssertNil(fetchError, @"There was an error trying to fetch the data");
    XCTAssertEqual(deletedItems.count, 0, @"The delete failed");
}


@end
