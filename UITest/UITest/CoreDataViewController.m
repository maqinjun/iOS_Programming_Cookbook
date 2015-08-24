//
//  CoreDataViewController.m
//  UITest
//
//  Created by maqj on 15/7/13.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "CoreDataViewController.h"
#import "Person.h"
#import "AppDelegate.h"

@interface CoreDataViewController ()<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *frc;

@end

static NSString *const cellIdentifier = @"CoreDataTableViewCellIdentifier";

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self registerTableCell];
    
    [self initItemButton];
    
    [self initFetchedResults];

//    [self createNewPersonWithFirstName:@"MA" lastName:@"QIN JUN" age:25];
//    [self createNewPersonWithFirstName:@"A" lastName:@"DOU" age:24];
//    [self createNewPersonWithFirstName:@"A" lastName:@"GUAN" age:23];
//    
//    [self fetchPersons];
}

- (void)initFetchedResults{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    
    NSSortDescriptor *sortByAge = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    NSSortDescriptor *sortByFirstName = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    fetchRequest.sortDescriptors = @[sortByAge, sortByFirstName];
    
    self.frc = [[NSFetchedResultsController alloc]
                initWithFetchRequest:fetchRequest
                managedObjectContext:delegate.managedObjectContext
                sectionNameKeyPath:nil
                cacheName:nil];
    self.frc.delegate = self;
    
    NSError *error = nil;
    
    if ([self.frc performFetch:&error]) {
        NSLog(@"Successfully fetched.");
    }else{
        NSLog(@"Failed to fetch: %@", error);
    }
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    Person *person = [self.frc objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [person.firstName stringByAppendingFormat:@" %@", person.lastName];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %ld", [person.age integerValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    Person *person = [self.frc objectAtIndexPath:indexPath];
    
    [delegate.managedObjectContext deleteObject:person];
    
    if ([person isDeleted]) {
        
        NSError *error = nil;
        if ([delegate.managedObjectContext save:&error]) {
            NSLog(@"Successfully deleted the object.");
        }else{
            NSLog(@"Failed to delete the object: %@",error);
        }
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 170.0f;
//}

#pragma mark -- NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath{
    if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if(type == NSFetchedResultsChangeInsert){
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}

- (void)registerTableCell{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)initItemButton{
    UIBarButtonItem *addItemButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleAddPerson:)];

    self.navigationItem.rightBarButtonItems = @[addItemButton, self.editButtonItem];
}

- (void)handleAddPerson:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CoreData" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AddPersonViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fetchPersons{
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    
    NSArray *persons = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (persons.count > 0) {
        for (int i = 0; i < persons.count; i++) {
            Person *person = persons[i];
            NSLog(@"%@ %@ %lu", person.firstName, person.lastName, [person.age unsignedIntegerValue]);
        }
    }
}

- (BOOL)createNewPersonWithFirstName:(NSString*)firstName lastName:(NSString*)lastName age:(NSUInteger)age{
    BOOL result = NO;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;

    if ([firstName length] == 0||
        lastName.length == 0) {
        NSLog(@"First name and last name mandatory.");
        return result;
    }
    
    Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:delegate.managedObjectContext];
    
    if (newPerson) {
        newPerson.age = @(age);
        newPerson.firstName = firstName;
        newPerson.lastName = lastName;
        
        NSError *error = nil;
        
        if ([delegate.managedObjectContext save:&error]) {
            NSLog(@"Successfully saved context: %@ %@", firstName, lastName);
            result = YES;
        }else{
            NSLog(@"Failed to save the context.");
        }
    }
    
    return result;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
