public with sharing class EmployeeSelector {
    public static List<Account> getEmployeeRecordRelatedToAccount(List<Employee__c> employeeList, Set<Id> employeeIds){
        List<Account> newAccount = new List<Account>();
        newAccount = [SELECT Id, (SELECT Id FROM Employees__r) FROM Account WHERE Id =: employeeIds]; //NOPMD
        return newAccount;
    }

    public static List<Account> getAccountRecordRelatedToEmployee(List<Employee__c> employeeList, Set<Id> employeeIds){
        List<Account> newAccount = new List<Account>();
        newAccount = [SELECT Id FROM Account WHERE Id =: employeeIds]; //NOPMD
        return newAccount;
    }
}