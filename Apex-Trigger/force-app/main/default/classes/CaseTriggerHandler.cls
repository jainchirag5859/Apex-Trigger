public with sharing class CaseTriggerHandler {
    public static void beforeInsert(List<Case> newList) { //NOPMD
        
    }

    public static void afterInsert(List<Case> newList) { 
        recentCasesOnAccount(newList);
        showNumbersOfCaseRecordTypes(newList);
    }

    public static void beforeUpdate(List<Case> newList, Map<Id, Case> oldMap) { //NOPMD

    }

    public static void afterUpdate(List<Case> newList, Map<Id, Case> oldMap) { //NOPMD

    }

    public static void beforeDelete(List<Case> oldList) { //NOPMD

    }

    public static void afterDelete(List<Case> oldList) { //NOPMD

    }

    private static void recentCasesOnAccount(List<Case> newList){
        List<Account> accounts = CaseService.createContacts(newList);
        if(!accounts.isEmpty()){
            update accounts; //NOPMD
        }
    }

    //22.Create two record types named as "Partner Case" and "Customer Case" on Case Object. On creation of Case, as per the record type populate the total number of Partner Case or Customer Case on Account object. Create Custom Fields on Account to have total numbers.
    private static void showNumbersOfCaseRecordTypes(List<Case> cases) {
        Set<Id> caseRelatedAccounts = new Set<Id>();
        for (Case accountCase : cases) {
           caseRelatedAccounts.add(accountCase.AccountId);
        }
        List<Account> accounts = CaseService.caseRelatedAccountsWithRecordTypes(caseRelatedAccounts);
        if (!accounts.isEmpty()) {
            update accounts; //NOPMD
        }
    }
}