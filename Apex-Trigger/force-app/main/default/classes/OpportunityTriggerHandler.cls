public with sharing class OpportunityTriggerHandler {
    public static void beforeInsert(List<Opportunity> newList){ //NOPMD
        setDescriptionForOpportunity(newList);
        updateDescriptionAccordingToStage(newList,NULL);
    }

    public static void afterInsert(List<Opportunity> newList){ //NOPMD
        recentOpportunitiesAmountOnAccount(newList);
        updateAnnualRevenueToAccount(newList);
    }

    public static void beforeUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap){ //NOPMD
        updateDescriptionAccordingToStage(newList,oldMap);
        validateRuleForClosedLostReason(newList, oldMap);
    }

    public static void afterUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap){ //NOPMD
        createTaskWhenStageUpdated(newList,oldMap);
        updateAnnualRevenueToAccount(newList);
    }

    public static void beforeDelete(List<Opportunity> oldList){ //NOPMD
        validateDeleteOpportunityOnProfiles(oldList);
    }

    public static void afterDelete(List<Opportunity> oldList){ //NOPMD
        updateAnnualRevenueToAccount(oldList);
    }

    private static void setDescriptionForOpportunity(List<Opportunity> newList){
        OpportunityService.getDescriptionForOpportunity(newList);
    }

    private static void recentOpportunitiesAmountOnAccount(List<Opportunity> newList){
        List<Account> account = OpportunityService.updateOppoertunityAmountRelatedToAccount(newList);
        if(!account.isEmpty()){
            update account; //NOPMD
        }
    }

    //2. update Description on creation or updation of Opportunity record
    private static void updateDescriptionAccordingToStage(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        OpportunityService.setDescriptionAccordingToStage(newList,oldMap);
    }

    //7. When a Opportunity Stage (field) is changed, create a Task record on Opportunity and assign it to Logged In User/Opportunity Owner / Any User.
    private static void createTaskWhenStageUpdated(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        List<Task> newTask = new List<Task>();
        newTask = OpportunityService.generateTaskWhenStageUpdated(newList,oldMap);
        if(!newTask.isEmpty()){
            insert newTask; //NOPMD
        }
    }

    //12. & 26. When an opportunity is updated to Closed Lost and Closed Lost Reason (field) is not populated then throw validation error that 'Please populate Closed Lost Reason' on opportunity. [before update]
    private static void validateRuleForClosedLostReason(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        OpportunityService.setRuleForClosedLostReason(newList,oldMap);
    }

    //14. If an opportunity is closed then, no one should be able to delete it except the user having a System Administrator profile.
    private static void validateDeleteOpportunityOnProfiles(List<Opportunity> oldList){
        OpportunityService.validationOnDeletion(oldList);
    }

    //23. When any Opportunity is created with amount populated or Opportunity Amount is updated then populate total Amount on Account Level for all related opportunities in Annual Revenue Field. If opportunity is deleted or undeleted then update Amount on Account as well. (Hint: rollup summary)
    private static void updateAnnualRevenueToAccount(List<Opportunity> oldList){
        List<Account> accountList = new List<Account>();
        accountList = OpportunityService.getAnnualRevenueToAccount(oldList);
        if(!accountList.isEmpty()){
            update accountList; //NOPMD
        }
    }
}