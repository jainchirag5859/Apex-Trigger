public with sharing class OpportunitySelector {
    public static Id getSystemAdminIds() {
        Id systemAdminID = [SELECT Id from Profile WHERE Name = 'System Administrator'].Id;
        return systemAdminID;
    }

    public static List<Account> getOpportunityRecordRelatedToAccount(List<Opportunity> oldList, Set<Id> opportunityIds){
        List<Account> newAccount = new List<Account>();
        newAccount = [SELECT Id, AnnualRevenue, (SELECT Id, Amount, Annual_Revenue__c FROM Opportunities) FROM Account WHERE Id =: opportunityIds]; //NOPMD
        return newAccount;
    }
}