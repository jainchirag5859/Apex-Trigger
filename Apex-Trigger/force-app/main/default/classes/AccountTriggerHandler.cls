public class AccountTriggerHandler { //NOPMD
    public static void beforeInsert(List<Account> newList) { //NOPMD
        billingToShippingAddress(newList,NULL);
        updateRatingForMediaIndustry(newList,NULL);
    }

    public static void afterInsert(List<Account> newList) { //NOPMD
        //insertAccountRelatedContacts(newList);
        // insertContactWithCheckboxRelatedToAccount(newList);
        // insertOpportunityWithCheckboxRelatedToAccount(newList);
    }
    
    public static void beforeUpdate(List<Account> newList, Map<Id, Account> oldMap) { //NOPMD
        // setDescriptionWhenPhoneUpdated(newList,oldMap);
        // billingToShippingAddress(newList,oldMap);
        // updateRatingForMediaIndustry(newList,oldMap);
        // restrictUpdateByCreatedDate(newList);
        // updateStageRelatedToActive(newList,oldMap);
    }

    public static void afterUpdate(List<Account> newList, Map<Id, Account> oldMap) { //NOPMD
        setHomePhoneRelatedToContacts(newList,oldMap);
        // setBillingToMailingAddress(newList,oldMap);
    }

    public static void beforeDelete(List<Account> oldList) { //NOPMD
        //reventDeleteAccountRecord(oldList);
        //validateDeleteAccountOnProfiles(oldList);
        deleteAccountNotRelatedToOpportunity(oldList);
        //deleteAccountNotRelatedToCase(oldList);
    }
    
    public static void afterDelete(List<Account> oldList) { //NOPMD

    }

    //1. update Rating on creation or updation of Account record
    private static void updateRatingForMediaIndustry(List<Account> newList, Map<Id, Account> oldMap){
        AccountService.getRatingForMediaIndustry(newList, oldMap);
    }
    
    private static void billingToShippingAddress(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
        AccountService.getShippingAddress(newList,oldMap);
    }

    private static void insertAccountRelatedContacts(List<Account> newList){
        List<Contact> contacts = AccountService.createContactsRelatedToAccount(newList);
        if(!contacts.isEmpty()){
            insert(contacts); //NOPMD
        }
    }

    private static void insertOpportunityRelatedToAccount(List<Account> newList){
        List<Opportunity> opportunities = AccountService.createOpportunityRelatedToAccount(newList);
        if(!opportunities.isEmpty()){
            insert(opportunities); //NOPMD
        }
    }

    private static void insertOpportunityWithCheckboxRelatedToAccount(List<Account> newList){
        List<Opportunity> opportunities = AccountService.createOpportunityRelatedToAccount(newList);
        if(!opportunities.isEmpty()){
            insert(opportunities); //NOPMD
        }
    }

    private static void insertContactWithCheckboxRelatedToAccount(List<Account> newList){
        List<Contact> contacts = AccountService.createContactWithCheckboxRelatedToAccount(newList);
        if(!contacts.isEmpty()){
            insert(contacts); //NOPMD
        }
    }

    private static void setDescriptionWhenPhoneUpdated(List<Account> newList, Map<Id, Account> oldMap){
        AccountService.getDescriptionWhenPhoneUpdated(newList, oldMap);
    }

    //3. If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field). [Using Map]
    // private static void setHomePhoneRelatedToContacts(List<Account> newList, Map<Id, Account> oldMap){
    //     List<Contact> contacts = AccountService.getHomePhoneDetail(newList, oldMap);
    //     update contacts; //NOPMD
    // }
    
    //4.If the Account phone is updated then populate the phone number on all related Contacts (Home Phone field). [Using Parent-Child SOQL]
    private static void setHomePhoneRelatedToContacts(List<Account> newList, Map<Id, Account> oldMap){
        List<Contact> newContacts = AccountService.getHomePhoneParentToChild(newList, oldMap);
        if(!newContacts.isEmpty()){
            update newContacts; //NOPMD
        }
    }

    //5. If the Account billing address is updated then update related contacts mailing address. [Using Map]
    // private static void setBillingToMailingAddress(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
    //     List<Contact> newContacts = AccountService.getMailingAddress(newList, oldMap);
    //     if(!newContacts.isEmpty()){
    //         update newContacts; //NOPMD
    //     }
    // }

    //6. If the Account billing address is updated then update related contacts mailing address. [Using Parent-Child SOQL]
    private static void setBillingToMailingAddress(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
        List<Contact> newContacts = AccountService.getMailingAddressParentToChild(newList, oldMap);
        if(!newContacts.isEmpty()){
            update newContacts; //NOPMD
        }
    }

    //9.Account records cannot be deleted if active is Yes.
    private static void preventDeleteAccountRecord(List<Account> oldList){
        AccountService.getDeleteAccountRecordError(oldList);
    }

    //10. && 11. Prevent account record from being edited if the record is created 7 days back.
    private static void restrictUpdateByCreatedDate(List<Account> oldList){
        AccountService.getUpdationError(oldList);
    }

    //8. Write a trigger on Account when Account Active field is updated from 'Yes' to 'No' then check all opportunities associated with the account. Update all Opportunities Stage to close lost if stage not equal to close won.
    private static void updateStageRelatedToActive(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
        List<Opportunity> updatedList = AccountService.getStageupdatedListRelatedToActive(newList, oldMap);
        if(!updatedList.isEmpty()){
            update updatedList; //NOPMD
        }
    }

    //13. Write a trigger on Account and check only System Administrator profile users should be able to delete an account.
    private static void validateDeleteAccountOnProfiles(List<Account> oldList){
        AccountService.getDeleteAccountOnProfilesError(oldList);
    }

    //15. Prevent deletion of an account if there is any opportunity related to that account.
    private static void deleteAccountNotRelatedToOpportunity(List<Account> oldList){
        AccountService.getdeleteAccountNotRelatedToOpportunityError(oldList);
    }

    //16. Prevent deletion of an account if there is any case related to that account.
    private static void deleteAccountNotRelatedToCase(List<Account> oldList){
        AccountService.getdeleteAccountNotRelatedToCaseError(oldList);
    }

    //31. Set OWD as Private for Account. Once an Account record is created, it should be automatically shared with any one user who belongs to Standard User profile.
    private static void shareWithStandardUsers(List<Account> newAccounts) { 
        List<AccountShare> accountSharesToInsert = AccountService.getsharingDetailsForStandardUsers(newAccounts);
        insert accountSharesToInsert; //NOPMD
    }
}