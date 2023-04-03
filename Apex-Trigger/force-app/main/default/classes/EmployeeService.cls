public with sharing class EmployeeService {  
    public static List<Account> getLeftEmployee(List<Employee__c> employeeList){
        List<Account> accountList = new List<Account>();
        Set<Id> employeeIds = new Set<Id>();
        for(Employee__c employee : employeeList){
            employeeIds.add(employee.Account__c);
        }
        List<Account> newAccount = new List<Account>();
        newAccount = EmployeeSelector.getEmployeeRecordRelatedToAccount(employeeList,employeeIds);
        for(Account account : newAccount){
            Integer totalEmployee = account.Employees__r.size();
            account.Left_Employee_Count_c__c = totalEmployee;
            accountList.add(account);
        }
        return accountList;
    }

    public static List<Account> getAccountUpdationListRelatedToEmployee(List<Employee__c> employeeList){
        List<Account> accountList = new List<Account>();
        Set<Id> employeeIds = new Set<Id>();
        for(Employee__c employee : employeeList){
            employeeIds.add(employee.Account__c);
        }
        List<Account> newAccount = new List<Account>();
        newAccount = EmployeeSelector.getAccountRecordRelatedToEmployee(employeeList, employeeIds);
        for(Account account : newAccount){
            account.active__c = 'Yes';
            accountList.add(account);
        }
        return accountList;
    }

    public static List<Account> getPresentEmployeeCount(List<Employee__c> employeeList){
        List<Account> accountList = new List<Account>();
        Set<Id> employeeIds = new Set<Id>();
        for(Employee__c employee : employeeList){
            employeeIds.add(employee.Account__c);

        }
        List<Account> newAccount = new List<Account>();
        newAccount = EmployeeSelector.getEmployeeRecordRelatedToAccount(employeeList, employeeIds);
        for(Account account : newAccount){
            Integer totalEmployee = account.Employees__r.size();
            account.Present_Employee_Count__c = totalEmployee;
            accountList.add(account);
        }
        return accountList;
    }
}