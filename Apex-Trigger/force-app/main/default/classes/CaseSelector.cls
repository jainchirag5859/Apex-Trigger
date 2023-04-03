public with sharing class CaseSelector {
    public static Id getCustomerCaseIds() {
        Id customerCaseId = [SELECT Id, Name FROM RecordType WHERE Name = 'Customer Case'].Id;
        return customerCaseId;
    }
    
    public static Id getPartnerCaseIds() {
        Id partnerCaseId =  [SELECT Id, Name FROM RecordType WHERE Name = 'Partner Case'].Id;
        return partnerCaseId;
    }

    public static Map<Id, Account> getAccountWithCustomerCase(Id customerCaseId, Set<Id> accountIds){
        List<Account> accountWithCustomerCase = new List<Account>();
        accountWithcustomerCase = [Select Id, Customer_total_numbers__c, Partner_total_numbers__c,  (SELECT Id, RecordTypeId FROM Cases WHERE RecordTypeId =:customerCaseId) FROM Account WHERE Id IN:accountIds]; //NOPMD
        Map<Id, Account> accountCustomerMap = new Map<Id, Account>();
        for(Account account : accountWithCustomerCase){
            accountCustomerMap.put(account.Id,account);
        }
        return accountCustomerMap;
    }

    public static Map<Id, Account> getAccountWithPartnerCase(Id partnerCaseId, Set<Id> accountIds){
        List<Account> accountWithPartnerCase = new List<Account>();
        accountWithPartnerCase = [Select Id, Customer_total_numbers__c, Partner_total_numbers__c,  (SELECT Id, RecordTypeId FROM Cases WHERE RecordTypeId =:partnerCaseId) FROM Account WHERE Id IN:accountIds]; //NOPMD
        Map<Id, Account> accountPartnerMap = new Map<Id, Account>();
        for(Account account : accountWithPartnerCase){
            accountPartnerMap.put(account.Id,account);
        }
        return accountPartnerMap;
    }
}