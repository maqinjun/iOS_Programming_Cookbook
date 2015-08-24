//
//  AdressBookViewController.m
//  UITest
//
//  Created by maqj on 15/7/9.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "AdressBookViewController.h"
#import <AddressBook/AddressBook.h>

@interface AdressBookViewController ()

@end

@implementation AdressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initRequestAddressBook];
}

- (void)initRequestAddressBook{
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = NULL;
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
        {
            NSLog(@"kABAuthorizationStatusAuthorized");
            addressBook = ABAddressBookCreateWithOptions(NULL, &error);
            
            [self useAddressBook:addressBook];
            
            [self readFromAddressBook:addressBook];
            
            [self newPersonWithFirstName:@"D." lastName:@"Dragon" inAddressBook:addressBook];
            
            [self createNewGroupInAddressBook:addressBook];
            
            [self addPersonAndGroupToAddressBook:addressBook];
            
            if (addressBook != NULL) {
                CFRelease(addressBook);
            }
            break;
        }
        case kABAuthorizationStatusDenied:
            NSLog(@"kABAuthorizationStatusDenied");
            break;
        case kABAuthorizationStatusNotDetermined:
        {
            addressBook = ABAddressBookCreateWithOptions(NULL, &error);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    NSLog(@"Access was granted.");
                    [self useAddressBook:addressBook];
                    
                    [self readFromAddressBook:addressBook];
                    
                    [self newPersonWithFirstName:@"D." lastName:@"Dragon" inAddressBook:addressBook];
                    
                    [self createNewGroupInAddressBook:addressBook];
                    
                }else{
                    NSLog(@"Access was not granted.");
                }
                
                if (addressBook != NULL) {
                    CFRelease(addressBook);
                }
            });
            break;
        }
        case kABAuthorizationStatusRestricted:
            NSLog(@"kABAuthorizationStatusRestricted");
            break;
    }
}

- (ABRecordRef)newPersonWithFirstName:(NSString*)firstName
                             lastName:(NSString*)lastName
                        inAddressBook:(ABAddressBookRef)addressBook{

    ABRecordRef result = NULL;
    
    if (addressBook == NULL) {
        NSLog(@"The address book is NULL.");
        return result;
    }
    
    if (firstName.length == 0  &&
        lastName.length == 0) {
        
        NSLog(@"First name and last name are both empty.");
        return result;
    }
    
    result = ABPersonCreate();
    
    if (result == NULL) {
        NSLog(@"Failed to create new person.");
        return  result;
    }
    
    BOOL couldSetFirstName = NO;
    BOOL couldSetLastName = NO;
    
    CFErrorRef setFirstNameError = NULL;
    CFErrorRef setLastNameError = NULL;
    
    couldSetFirstName = ABRecordSetValue(result, kABPersonFirstNameProperty, (__bridge CFTypeRef)(firstName), &setFirstNameError);
    
    couldSetLastName = ABRecordSetValue(result, kABPersonLastNameProperty, (__bridge CFTypeRef)(lastName), &setLastNameError);
    
    CFErrorRef couldAddRecordError = NULL;
    
    BOOL couldAddRecord = ABAddressBookAddRecord(addressBook, result, &couldAddRecordError);
    
    if (couldAddRecord) {
        NSLog(@"Successfully added the person.");
    }else{
        NSLog(@"Failed to add the person.");
        CFRelease(result);
        result = NULL;
        
        return  result;
    }
    
    if (ABAddressBookHasUnsavedChanges(addressBook)) {
        CFErrorRef couldSaveAddressBookError = NULL;
        BOOL couldSaveAddressBook = ABAddressBookSave(addressBook, &couldSaveAddressBookError);
        
        if (couldSaveAddressBook) {
            NSLog(@"Successfully saved the address book.");
        }else{
            NSLog(@"Failed to save the address book.");
        }
    }
    
    if (couldSetFirstName &&
        couldSetLastName) {
        NSLog(@"Successfully set the first name and the last name of the person.");
    }else{
        NSLog(@"Failed to set the first name and last name of teh person.");
    }
    
    return result;
}

- (void)createNewGroupInAddressBook:(ABAddressBookRef)addressBook{
    ABRecordRef groupRecord = [self newGroupWithName:@"Persons Dragon" inAddressBook:addressBook];
    if (groupRecord != NULL) {
        CFRelease(groupRecord);
        NSLog(@"Successfully created the group.");
    }else{
        NSLog(@"Failed to create the group.");
    }
}

- (BOOL)addPerson:(ABRecordRef)person
          toGroup:(ABRecordRef)group
    inAddressBook:(ABAddressBookRef)addressBook{
    
    BOOL result = NO;
    
    if (person == NULL||
        group == NULL||
        addressBook == NULL) {
        NSLog(@"Invalid parameters are given.");
        return result;
    }
    
    CFErrorRef error = NULL;
    
    result = ABGroupAddMember(group, person, &error);
    
    if (result == NO) {
        NSLog(@"Could not add the person to the group.");
        return NO;
    }
    
    if (ABAddressBookHasUnsavedChanges(addressBook)) {
        
        result =  ABAddressBookSave(addressBook, &error);
        if (result) {
            NSLog(@"Successfully add the person to the group.");
        }else{
            NSLog(@"Failed to save the person to the group.");
        }
        
    }else{
        NSLog(@"No changes were saved.");
    }
    
    return result;
}

- (void)addPersonAndGroupToAddressBook:(ABAddressBookRef)addressBook{
    ABRecordRef person = [self newPersonWithFirstName:@"D." lastName:@"LUXI" inAddressBook:addressBook];
    
    if (person != NULL) {
        
        ABRecordRef group = [self newGroupWithName:@"ONE PICE" inAddressBook:addressBook];
        
        if (group != NULL) {
            
            if ([self addPerson:person toGroup:group inAddressBook:addressBook]) {
                NSLog(@"Successfully add D. LUXI to ONE PICE.");
            }
            
        }else{
            NSLog(@"Failed to create group ONE PICE");
        }
    }else{
        NSLog(@"Failed to create person D. LUXI");
    }
}

- (ABRecordRef)newGroupWithName:(NSString*)groupName
                  inAddressBook:(ABAddressBookRef)addressBook{
    ABRecordRef result = NULL;
    
    if (addressBook == NULL) {
        NSLog(@"The address book is NULL.");
        return result;
    }
    
    result = ABGroupCreate();
    
    if (result == NULL) {
        NSLog(@"Failed to create a new group.");
        return result;
    }
    
    BOOL couldSetGroupName = NO;
    CFErrorRef error = NULL;
    
    couldSetGroupName = ABRecordSetValue(result, kABGroupNameProperty, (__bridge CFTypeRef)groupName, &error);
    
    if (couldSetGroupName) {
        BOOL couldAddRecord = NO;
        CFErrorRef couldAddRecordError = NULL;
        
        couldAddRecord = ABAddressBookAddRecord(addressBook, result, &couldAddRecordError);
        
        if (couldAddRecord) {
            NSLog(@"Successfully add the new group.");
            if (ABAddressBookHasUnsavedChanges(addressBook)) {
                BOOL couldSaveAddressBook = NO;
                CFErrorRef couldSaveAddressBookError = NULL;
                couldSaveAddressBook = ABAddressBookSave(addressBook, &couldSaveAddressBookError);
                
                if (couldSaveAddressBook) {
                    NSLog(@"Successfully saved the address book.");
                }else{
                    CFRelease(result);
                    result = NULL;
                    NSLog(@"Failed to save the address book.");
                }
            }else{
                CFRelease(result);
                result = NULL;
                NSLog(@"No unsaved changes.");
            }
            
        }else{
            CFRelease(result);
            result = NULL;
            NSLog(@"Could not add a new group");
        }
    }else{
        CFRelease(result);
        result = NULL;
        NSLog(@"Could not set the name of the group.");
    }
    
    return result;
}

- (void)readFromAddressBook:(ABAddressBookRef)addressBook{
    NSArray *contacts = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for (int i = 0; i < contacts.count; i++) {
        ABRecordRef person = (__bridge ABRecordRef)([contacts objectAtIndex:i]);
     
        NSString *firstName = (__bridge NSString*) ABRecordCopyValue(person, kABPersonFirstNameProperty);
        
        NSString *lastName = (__bridge NSString*) ABRecordCopyValue(person, kABPersonLastNameProperty);
        
        NSString *middleName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
        
        NSLog(@"%@ %@ %@", firstName, middleName, lastName);

    }
}

- (void)useAddressBook:(ABAddressBookRef)addressBook{
    if (ABAddressBookHasUnsavedChanges(addressBook)) {
        NSLog(@"Changes were found in the address book.");
        
        BOOL doYouWantToSaveChanges = YES;
        
        if (doYouWantToSaveChanges) {
            CFErrorRef error = NULL;
            
            if (ABAddressBookSave(addressBook, &error)) {
                NSLog(@"We successfully saved our changes to the address book.");
            }else{
                NSLog(@"We failed to save the changes.");
            }
        }else{
            ABAddressBookRevert(addressBook);
        }
    }else{
        NSLog(@"No changes to the address book.");
    }
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
