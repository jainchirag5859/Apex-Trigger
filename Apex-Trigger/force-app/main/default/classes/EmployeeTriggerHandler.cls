public class EmployeeTriggerHandler { //NOPMD
    public static void beforeInsert(List<Employee__c> newList){ //NOPMD
    }
    
    public static void afterInsert(List<Employee__c> newList){ //NOPMD
        //updateAccountRelatedToEmployee(newList);
    }
    
    public static void beforeUpdate(List<Employee__c> newList, Map<Id, Employee__c> oldMap){ //NOPMD
        
    }

    public static void afterUpdate(List<Employee__c> newList, Map<Id, Employee__c> oldMap){ //NOPMD
        //updateAccountRelatedToEmployee(newList);
    }

    public static void beforeDelete(List<Employee__c> oldList){ //NOPMD
        
    }

    public static void afterDelete(List<Employee__c> oldList){ //NOPMD
        //updateAccountRelatedToEmployee(oldList);
    }

    public static void afterUndelete(List<Employee__c> newList){
        updateAccountRelatedToEmployee(newList);
    }

    //17 When the Employee record is deleted then update 'Left Employee Count' on Account.
    private static void updateLeftEmployeeRelatedToAccount(List<Employee__c> oldList){
        List<Account> accountList = new List<Account>();
        accountList = EmployeeService.getLeftEmployee(oldList);
        if(!accountList.isEmpty()){
            update accountList; //NOPMD
        }
    }

    //19. When the Employee record is undeleted then update 'Left Employee Count' on Account.
    private static void updateEmployeeAfterUndelete(List<Employee__c> employeeList){
        List<Account> accountList = new List<Account>();
        accountList = EmployeeService.getLeftEmployee(employeeList);
        if(!accountList.isEmpty()){
            update accountList; //NOPMD
        }
    }

    //18. Undelete Employee record and set Active as true.
    private static void updateAccountRelatedToEmployee(List<Employee__c> employeeList){
        List<Account> accountList = new List<Account>();
        accountList = EmployeeService.getAccountUpdationListRelatedToEmployee(employeeList);
        if(!accountList.isEmpty()){
            update accountList; //NOPMD
        }
    }

    //20.When the Employee record is inserted, deleted and undeleted then update 'Present Employee Count' on related Account. [Parent-Child SOQL]
    private static void updatePresentEmployeeOnAccount(List<Employee__c> employeeList){
        List<Account> accountList = new List<Account>();
        accountList = EmployeeService.getPresentEmployeeCount(employeeList);
        if(!accountList.isEmpty()){
            update accountList; //NOPMD
        }
    }
}