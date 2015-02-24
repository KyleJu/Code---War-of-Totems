//
//  AppDelegate.h
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NJMainTabBarController.h"
#import "NJJobsViewController.h"
#import "NJIndustriesViewController.h"
#import "NJMainNavigationViewController.h"
#import "NJIntroViewController.h"
#import "NJJobProjectionParser.h"
#import "JobProjection.h"
#import "provincesCoreData.h"
#import "NJJobVacancyParser.h"
#import "NJLabourForceSurveyParser.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSArray *groupCodes;
@property (strong, nonatomic) NSArray *industryCodes;

@property (strong, nonatomic) NJMainTabBarController *tabBarController;

@property (strong, nonatomic) NJIntroViewController *introVC;
@property (strong, nonatomic) NJJobsViewController *jobsVC;
@property (strong, nonatomic) NJIndustriesViewController *industriesVC;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)fetchJobsWithGroupCodes:(NSArray*)arrayOfGC andIndustryCodes:(NSArray*)arrayOfIC;
- (void)transitionToResultsScreen;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

