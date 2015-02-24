//
//  AppDelegate.m
//  NexJob
//
//  Created by Kyle Ju on 2015-02-21.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "AppDelegate.h"
#import "NJJobProjectionFetch.h"

#define kHeightOfTabBar 42.0f

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Appeareances
    
    BOOL isParsed = [[NSUserDefaults standardUserDefaults] boolForKey:@"isParsed"];
    if (!isParsed) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [NJJobProjectionParser loadXML];
            [NJJobVacancyParser loadXML];
            [NJLabourForceSurveyParser loadXML];
        });
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isParsed"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[UITabBarItem appearanceWhenContainedIn:[NJMainTabBarController class], nil] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Regular" size:17]} forState:UIControlStateNormal];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor nj_greyColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor nj_redColor], NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Regular" size:17]} forState:UIControlStateNormal];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.jobsVC = [[NJJobsViewController alloc] init];
    self.industriesVC = [[NJIndustriesViewController alloc] init];
    self.introVC = [[NJIntroViewController alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.jobsVC selector:@selector(reloadTableView:) name:@"NJNotificationJobsVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self.industriesVC selector:@selector(reloadTableView:) name:@"NJNotificationIndustriesVC" object:nil];

    
    NJMainNavigationViewController *navController1 = [[NJMainNavigationViewController alloc] initWithRootViewController:self.jobsVC];
    NJMainNavigationViewController *navController2 = [[NJMainNavigationViewController alloc] initWithRootViewController:self.industriesVC];
    
    
    self.tabBarController = [[NJMainTabBarController alloc] init];
    self.tabBarController.tabBar.frame = CGRectMake(0, self.window.frame.size.height - kHeightOfTabBar, self.window.frame.size.width, kHeightOfTabBar);
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, nil];
    
    UITabBarItem *itemJob = [self.tabBarController.tabBar.items objectAtIndex:0];
    UITabBarItem *itemIndustry = [self.tabBarController.tabBar.items objectAtIndex:1];
        
    [itemJob setTitle:@"Jobs"];
    [itemIndustry setTitle:@"Provinces"];
    
    [itemJob setTitlePositionAdjustment:UIOffsetMake(0, -15.0)];
    [itemIndustry setTitlePositionAdjustment:UIOffsetMake(0, -15.0)];
    
    self.tabBarController.selectedIndex = 0;
    
    self.window.rootViewController = self.introVC;
    
    return YES;
}

- (void)transitionToResultsScreen
{
    self.window.rootViewController =  self.tabBarController;
    
    [UIView transitionWithView:self.window
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}

- (void)fetchJobsWithGroupCodes:(NSArray *)arrayOfGC andIndustryCodes:(NSArray *)arrayOfIC
{
    NSArray *arrayOfJobs = [NJJobProjectionFetch jobProjectionFetchHelper:arrayOfGC withIndustry:arrayOfIC];
    
    NSMutableArray *arrayOfIndustries;
    NSMutableArray *temporaryArray = [provincesCoreData vacancyFetchProvinces:arrayOfIC[0]];
    if (temporaryArray.count > 0){
        arrayOfIndustries = temporaryArray;
    }else{
        [provincesCoreData createProvincesEntity:arrayOfIC[0]];
        arrayOfIndustries = [provincesCoreData vacancyFetchProvinces:arrayOfIC[0]];

    }
    NSArray *sortedArrayOfJobs = [arrayOfJobs sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        JobProjection *job1 = (JobProjection*)obj1;
        JobProjection *job2 = (JobProjection*)obj2;
        
        if (job1.projectionAverage > job2.projectionAverage){
            return NSOrderedAscending;
        } else if (job1.projectionAverage == job2.projectionAverage) {
            return NSOrderedSame;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NJNotificationJobsVC" object:sortedArrayOfJobs];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NJNotificationIndustriesVC" object:arrayOfIndustries];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.warofthetotems.NexJob" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NexJob" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NexJob.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
