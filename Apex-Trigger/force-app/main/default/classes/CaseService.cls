public with sharing class CaseService {
    public static List<Account> createContacts(List<Case> newList) {
        List<Account> accounts = new List<Account>();
        for(Case cases : newList){
            if(cases.AccountId != NULL){
                Account accountInstance = new Account();
                if(cases.AccountId != NULL){
                    accountInstance.Id = cases.AccountId;
                }
                if(cases.CaseNumber != NULL){
                    accountInstance.Latest_Case_Number__c = cases.CaseNumber;
                }
                accounts.add(accountInstance);
            }
        }
        return accounts;
    }

    public static List<Account> caseRelatedAccountsWithRecordTypes(Set<Id> accountIds){
        List<Account> accounts = new List<Account>();
        Id customerCaseId = CaseSelector.getCustomerCaseIds();
        Id partnerCaseId = CaseSelector.getPartnerCaseIds();
        Map<Id, Account> accountWithcustomerCase = CaseSelector.getAccountWithCustomerCase(customerCaseId, accountIds);
        Map<Id, Account> accountWithPartnerCase = CaseSelector.getAccountWithPartnerCase(partnerCaseId, accountIds);
        for (Id accountId : accountIds) {
            Account account = new Account();
            account.Id = accountId;
            if (accountWithcustomerCase.containsKey(accountId)) {
                account.Customer_total_numbers__c = accountWithcustomerCase.get(accountId).Cases.size();
            }
            if (accountWithPartnerCase.containsKey(accountId)) {
                account.Partner_total_numbers__c = accountWithPartnerCase.get(accountId).Cases.size();
            }
            accounts.add(account);
        }
        return accounts;
    }
}