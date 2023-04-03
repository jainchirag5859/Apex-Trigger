public with sharing class AccountService { //NOPMD
    public static void getShippingAddress(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
        for(Account account : newList){
            if(account.CopyBillingToShipping__c){
                if(oldMap.containsKey(account.Id)){
                    if(oldMap.get(account.Id).BillingCountry != oldMap.get(account.Id).ShippingCountry){
                        account.ShippingCountry = account.BillingCountry;
                    }
                    if(oldMap.get(account.Id).BillingGeocodeAccuracy != oldMap.get(account.Id).ShippingGeocodeAccuracy){
                        account.ShippingGeocodeAccuracy = account.BillingGeocodeAccuracy;
                    }
                    if(oldMap.get(account.Id).BillingLatitude != oldMap.get(account.Id).ShippingLongitude){
                        account.ShippingLongitude = account.BillingLatitude;
                    }
                    if(oldMap.get(account.Id).BillingLongitude != oldMap.get(account.Id).ShippingLongitude){
                        account.ShippingLongitude = account.BillingLongitude;   
                    }
                    if(oldMap.get(account.Id).BillingPostalCode != oldMap.get(account.Id).ShippingPostalCode){
                        account.ShippingPostalCode = account.BillingPostalCode;
                    }
                    if(oldMap.get(account.Id).BillingState != oldMap.get(account.Id).ShippingState){
                        account.ShippingState = account.BillingState;
                    }
                    if(oldMap.get(account.Id).BillingStreet != oldMap.get(account.Id).ShippingStreet){
                        account.ShippingStreet = account.BillingStreet;
                    }
                }
                else{
                    if(account.CopyBillingToShipping__c == true){
                        if(account.BillingCountry != NULL){
                            account.ShippingCountry = account.BillingCountry;
                        }
                        if(account.BillingGeocodeAccuracy != NULL){
                            account.ShippingGeocodeAccuracy = account.BillingGeocodeAccuracy;
                        }
                        if(account.BillingLatitude != NULL){
                            account.ShippingLongitude = account.BillingLatitude;
                        }
                        if(account.BillingLongitude != NULL){
                            account.ShippingLongitude = account.BillingLongitude;   
                        }
                        if(account.BillingPostalCode != NULL){
                            account.ShippingPostalCode = account.BillingPostalCode;
                        }
                        if(account.BillingState != NULL){
                            account.ShippingState = account.BillingState;
                        }
                        if(account.BillingStreet != NULL){
                            account.ShippingStreet = account.BillingStreet;
                        }
                    }
                }
            }
        }
    }

    public static void getRatingForMediaIndustry(List<Account> newList, Map<Id, Account> oldMap){
        for (Account account : newList) {
            if((oldMap == NULL && account.Industry != NULL && account.Industry == 'Media') || (account.Industry != NULL && account.Industry == 'Media' && oldMap.get(account.Id).Industry != account.Industry)){
                account.Rating = 'Hot';
            }
        }
    }

    public static List<Contact> createContactsRelatedToAccount(List<Account> newList) {
        List<Contact> contacts = new List<Contact>();
        for(Account account : newList){
            Contact contactInstance = new Contact();
            if(account.Id != NULL){
                contactInstance.AccountId = account.Id;
            }
            if(account.Name != NULL){
                contactInstance.Lastname = account.Name;
            }
            if(account.Phone != NULL){
                contactInstance.Phone = account.Phone;
            }
            contacts.add(contactInstance);
        }
        return contacts;
    }

    public static List<Opportunity> createOpportunityRelatedToAccount(List<Account> newList) {
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Account account : newList){
            Opportunity opportunityInstance = new Opportunity();
            if(account.Id != NULL){
                opportunityInstance.AccountId = account.Id;
            }
            if(account.Name != NULL){
                opportunityInstance.Name = account.Name;
            }
            if(account.Close_Date__c != NULL){
                opportunityInstance.CloseDate = account.Close_Date__c;
            }
            opportunityInstance.StageName = 'Priority';
            opportunities.add(opportunityInstance);
        }
        return opportunities;
    }

    public static List<Opportunity> createOpportunityWithCheckboxRelatedToAccount(List<Account> newList) {
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Account account : newList){
            Opportunity opportunityInstance = new Opportunity(); 
            if(account.Opportunity__c && account.Active__c == 'Yes'){
                if(account.Id != NULL){
                    opportunityInstance.AccountId = account.Id;
                }
                if(account.Name != NULL){
                    opportunityInstance.Name = account.Name;
                }
                if(account.Close_Date__c != NULL){
                    opportunityInstance.CloseDate = account.Close_Date__c;
                }
            }
            opportunityInstance.StageName = 'Priority';
            opportunities.add(opportunityInstance);
        }
        return opportunities;
    }

    public static List<Contact> createContactWithCheckboxRelatedToAccount(List<Account> newList) {
        List<Contact> contacts = new List<Contact>();
        for(Account account : newList){
            Contact contactInstance = new Contact();
            if(account.Contact__c){
                if(account.Id != NULL){
                    contactInstance.AccountId = account.Id;
                }
                if(account.Phone != NULL){
                    contactInstance.Phone = account.Phone;
                }
                if(account.Name != NULL){
                    contactInstance.Lastname = account.Name;
                }
            }
            contacts.add(contactInstance);
        }
        return contacts;
    }

    public static void getDescriptionWhenPhoneUpdated(List<Account> newList, Map<Id, Account> oldMap){
        for(Account account : newList){
            if(oldMap.containsKey(account.Id)){
                if(account.Phone != oldMap.get(account.Id).Phone){
                    account.Description = 'Phone is Updated! Old Value : ' + oldMap.get(account.Id).Phone + ' New Value : ' + account.Phone;
                }
            }
        }
    }

    public static List<Contact> getHomePhoneDetail(List<Account> newList, Map<Id, Account> oldMap){
        Map<Id, String> idToPhone = new Map<Id, String>();
        for(Account account : newList){
            if(oldMap.containsKey(account.Id)){
                if(account.Phone != oldMap.get(account.Id).Phone){
                    idToPhone.put(account.Id, account.Phone);
                }
            }
        }
        List<Contact> contacts = AccountSelector.getHomePhoneListFromContact(idToPhone);
        for(Contact contactInstance : contacts){
            if(idToPhone.containsKey(contactInstance.AccountId)){
                contactInstance.HomePhone = idToPhone.get(contactInstance.AccountId);
            }
        }
        return contacts;
    }

    public static List<Contact> getHomePhoneParentToChild(List<Account> newList, Map<Id, Account> oldMap){
        List<Contact> newContacts = new List<Contact>();
        Set<Id> accountIds = oldMap.keyset();
        List<Account> accounts = AccountSelector.getHomePhoneListUsingParentToChild(accountIds);
        for(Account newAccounts : accounts){
            for(Contact contactInstance : newAccounts.contacts){
                contactInstance.HomePhone = newAccounts.Phone;      
                newContacts.add(contactInstance);
            }
        }
        return newContacts;
    }

    public static List<Contact> getMailingAddress(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
        List<Contact> newContacts = new List<Contact>();
        Map<Id, Account> idToAccountMap = new Map<Id, Account>();
        for(Account account : newList){
            if(account.BillingCountry != oldMap.get(account.Id).BillingCountry && oldMap!=NULL){
                idToAccountMap.put(account.Id, account);
            }
            if(account.BillingGeocodeAccuracy != oldMap.get(account.Id).BillingGeocodeAccuracy && oldMap!=NULL){
                idToAccountMap.put(account.Id, account);
            }
            if(account.BillingLatitude != oldMap.get(account.Id).BillingLatitude && oldMap!=NULL){
                idToAccountMap.put(account.Id, account);
            }
            if(account.BillingLongitude != oldMap.get(account.Id).BillingLongitude && oldMap!=NULL){
                idToAccountMap.put(account.Id, account);
            }
            if(account.BillingPostalCode != oldMap.get(account.Id).BillingPostalCode && oldMap!=NULL){
                idToAccountMap.put(account.Id, account);
            }
            if(account.BillingState != oldMap.get(account.Id).BillingState && oldMap!=NULL){
                idToAccountMap.put(account.Id, account);
            }
            if(account.BillingStreet != oldMap.get(account.Id).BillingStreet && oldMap!=NULL){
                idToAccountMap.put(account.Id, account);
            }
        }
        List<Contact> oldContacts = AccountSelector.getOldContactsForMailingAddress(idToAccountMap);
        for(Contact contactInstance : oldContacts){
            if(idToAccountMap.containsKey(contactInstance.AccountId)){
                contactInstance.MailingCountry = idToAccountMap.get(contactInstance.AccountId).BillingCountry;
                contactInstance.MailingState = idToAccountMap.get(contactInstance.AccountId).BillingState;
                contactInstance.MailingStreet = idToAccountMap.get(contactInstance.AccountId).BillingStreet;
                contactInstance.MailingPostalCode = idToAccountMap.get(contactInstance.AccountId).BillingPostalCode;
                newContacts.add(contactInstance);
            }
        }
        return newContacts;
    }

    public static List<Contact> getMailingAddressParentToChild(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
        List<Contact> newContacts = new List<Contact>();
        Set<Id> accountIds = new Set<Id>();
        for(Account account : newList){
            if(account.BillingCountry != oldMap.get(account.Id).BillingCountry && oldMap!=NULL){
                accountIds.add(account.Id);
            }
            if(account.BillingGeocodeAccuracy != oldMap.get(account.Id).BillingGeocodeAccuracy && oldMap!=NULL){
                accountIds.add(account.Id);
            }
            if(account.BillingLatitude != oldMap.get(account.Id).BillingLatitude && oldMap!=NULL){
                accountIds.add(account.Id);
            }
            if(account.BillingLongitude != oldMap.get(account.Id).BillingLongitude && oldMap!=NULL){
                accountIds.add(account.Id);
            }
            if(account.BillingPostalCode != oldMap.get(account.Id).BillingPostalCode && oldMap!=NULL){
                accountIds.add(account.Id);
            }
            if(account.BillingState != oldMap.get(account.Id).BillingState && oldMap!=NULL){
                accountIds.add(account.Id);
            }
            if(account.BillingStreet != oldMap.get(account.Id).BillingStreet && oldMap!=NULL){
                accountIds.add(account.Id);
            }
        }
        List<Account> oldAccounts = AccountSelector.getOldContactsForMailingUsingParentToChild(accountIds);
        for(Account accountInstance : oldAccounts){
            for(Contact contactInstance : accountInstance.Contacts){
                contactInstance.MailingCountry = accountInstance.BillingCountry;
                contactInstance.MailingState = accountInstance.BillingState;
                contactInstance.MailingStreet = accountInstance.BillingStreet;
                contactInstance.MailingPostalCode = accountInstance.BillingPostalCode;
                newContacts.add(contactInstance);
            }
        }
        return newContacts;
    }

    public static void getDeleteAccountRecordError(List<Account> oldList){
        for(Account account : oldList){
            if(account.active__c == 'Yes'){
                account.addError('Account cannot be deleted');
            }
        }
    }

    public static void getUpdationError(List<Account> oldList){
        for(Account account : oldList){
            if(account.CreatedDate < System.Today() - 7){
                account.addError('Record cannot be updated !');
            }
        }
    }

    public static List<Opportunity> getStageupdatedListRelatedToActive(List<Account> newList, Map<Id, Account> oldMap){ //NOPMD
        List<Opportunity> updatedList = new List<Opportunity>();
        Set<Id> newIds = new Set<Id>();
        for(Account account : newList){
            if(account.active__c == 'No' && oldMap.get(account.Id).active__c == 'Yes'){
                newIds.add(account.Id);
            }
        }
        if(!newIds.isEmpty()){
            List<Account> newAccounts = AccountSelector.getStageUpdationListFromAccount(newIds);
            for(Account account : newAccounts){
                for(Opportunity newOpportinities : account.opportunities){
                    if(newOpportinities.StageName != 'Closed Won' && newOpportinities.StageName !='Closed Lost'){
                        newOpportinities.StageName = 'Closed Lost';
                        updatedList.add(newOpportinities);
                    }
                }
            }
        }
        return updatedList;
    }

    public static void getDeleteAccountOnProfilesError(List<Account> oldList){
        Id systemAdminID = AccountSelector.getSystemAdminIds();
        for(Account account : oldList){
            if(UserInfo.getProfileId() != systemAdminID){
                account.addError('Account cannot be deleted !');
            }
        }
    }

    public static void getdeleteAccountNotRelatedToOpportunityError(List<Account> oldList){
        List<Opportunity> opportunities = AccountSelector.getOpportunityList();
        Set<Id> opportunityAccountIds = new Set<Id>();
        for (Opportunity opportunity : opportunities) {
            OpportunityAccountIds.add(opportunity.AccountId);
        }
        for (Account account : oldList) {
            if (OpportunityAccountIds.contains(account.Id)) {
                account.addError('Account cannot be deleted as it is associated with an Opportunity');
            }
        }
    }

    public static void getdeleteAccountNotRelatedToCaseError(List<Account> oldList){
        List<Case> newCases = AccountSelector.getCasesList();
        Set<Id> caseAccountIds = new Set<Id>();
        for (Case cases : newCases) {
            caseAccountIds.add(cases.AccountId);
        }
        for (Account account : oldList) {
            if (caseAccountIds.contains(account.Id)) {
                account.addError('Account cannot be deleted as it is associated with an Case');
            }
        }
    }

    public static List<AccountShare> getsharingDetailsForStandardUsers(List<Account> newAccounts) { 
        List<AccountShare> accountSharesToInsert = new List<AccountShare>();
        List<User> standardUsers = AccountSelector.getStandardUserList();
        
        for (Account newAccount : newAccounts) {
            for (User standardUser : standardUsers) {
                AccountShare accountShare = new AccountShare();
                accountShare.AccountId = newAccount.Id;
                accountShare.UserOrGroupId = standardUser.Id;
                accountShare.AccountAccessLevel = 'Read';
                accountShare.RowCause = Schema.AccountShare.RowCause.Manual;
                accountSharesToInsert.add(accountShare);
            }
        }
        return accountSharesToInsert;
    }
}