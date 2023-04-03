public with sharing class AccountSelector {
    public static List<Contact> getHomePhoneListFromContact(Map<Id, String> idToPhone){ //NOPMD
        List<Contact> contacts = [SELECT AccountId, Id, HomePhone FROM Contact WHERE AccountId IN: idToPhone.keyset()]; //NOPMD
        return contacts;
    }

    public static List<Account> getHomePhoneListUsingParentToChild(Set<Id> accountIds){ //NOPMD
        List<Account> accounts = [SELECT Id, Phone,(SELECT Id, HomePhone FROM Contacts) FROM Account WHERE Id IN: accountIds]; //NOPMD
        return accounts;
    }

    public static List<Contact> getOldContactsForMailingAddress(Map<Id, Account> idToAccountMap){ //NOPMD
        List<Contact> oldContacts = [SELECT AccountId, Id FROM Contact WHERE AccountId IN: idToAccountMap.keyset()]; //NOPMD
        return oldContacts;
    }

    public static List<Account> getOldContactsForMailingUsingParentToChild(Set<Id> accountIds){ //NOPMD
        List<Account> oldAccounts = [SELECT Id, BillingCountry, BillingState, BillingStreet, BillingPostalCode,(SELECT Id FROM contacts) FROM Account WHERE Id IN: accountIds]; //NOPMD
        return oldAccounts;
    }

    public static List<Account> getStageUpdationListFromAccount(Set<Id> newIds){ //NOPMD
        List<Account> newAccounts = [SELECT Id, active__c, (SELECT Id, StageName FROM Opportunities) FROM Account WHERE Id IN: newIds]; //NOPMD        
        return newAccounts;
    }

    public static Id getSystemAdminIds() {
        Id systemAdminID = [SELECT Id from Profile WHERE Name = 'System Administrator'].Id;
        return systemAdminID;
    }

    public static List<Opportunity> getOpportunityList() {
        List<Opportunity> opportunities = [SELECT Id , AccountId FROM Opportunity]; //NOPMD
        return opportunities;
    }

    public static List<Case> getCasesList() {
        List<Case> newCases = [SELECT Id , AccountId FROM Case]; //NOPMD
        return newCases;
    }

    public static List<User> getStandardUserList() {
        List<User> standardUsers = [SELECT Id FROM User WHERE Profile.Name = 'Standard User'];  //NOPMD
        return standardUsers;
    }
}