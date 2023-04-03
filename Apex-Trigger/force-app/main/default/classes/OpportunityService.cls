public with sharing class OpportunityService {
    public static List<Account> updateOppoertunityAmountRelatedToAccount(List<Opportunity> newList) {
        List<Account> accounts = new List<Account>();
        for(Opportunity opportunity : newList){
            if(opportunity.AccountId != NULL){
                Account accountInstance = new Account();
                if(opportunity.AccountId != NULL){
                    accountInstance.Id = opportunity.AccountId;
                }
                if(opportunity.Amount != NULL){
                    accountInstance.Recent_Opportunity_Amount__c = opportunity.Amount;
                }
                accounts.add(accountInstance);
            }
        }
        return accounts;
    }

    public static void getDescriptionForOpportunity(List<Opportunity> newList){
        for (Opportunity opportunity : newList) {
            if(opportunity.Amount != NULL && opportunity.Amount > 100000){
                opportunity.Description = 'Hot Opportinity';
            }
        }
    }

    public static void setDescriptionAccordingToStage(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        for (Opportunity opportunity : newList) {
            if((oldMap == NULL && opportunity.StageName != NULL && opportunity.StageName == 'Closed Won') || (opportunity.StageName != NULL && opportunity.StageName == 'Closed Won' && oldMap.get(opportunity.Id).StageName != opportunity.StageName)){
                opportunity.Description = 'Opportunity is Closed Won';
            }
            else if((oldMap == NULL && opportunity.StageName != NULL && opportunity.StageName == 'Closed Lost') || (opportunity.StageName != NULL && opportunity.StageName == 'Closed Lost' && oldMap.get(opportunity.Id).StageName != opportunity.StageName)){
                opportunity.Description = 'Opportunity is Closed Lost';
            }
            else if((oldMap == NULL && opportunity.StageName != NULL) || (opportunity.StageName != NULL && oldMap.get(opportunity.Id).StageName != opportunity.StageName)){
                opportunity.Description = 'Opportunity is Open';
            }
        }
    }

    public static List<Task> generateTaskWhenStageUpdated(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        List<Task> newTask = new List<Task>();
        for(Opportunity opportunities : newList){
            if(opportunities.StageName != oldMap.get(opportunities.Id).StageName){
                Task taskInstance = new Task();
                taskInstance.WhatId = opportunities.Id;
                taskInstance.OwnerId = opportunities.OwnerId;
                taskInstance.Subject = 'Task1';
                taskInstance.Status = 'Not Started';
                taskInstance.Priority = 'High';
                newTask.add(taskInstance);
            }
        }
        return newTask;
    }

    public static void setRuleForClosedLostReason(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        for(Opportunity opportunities : newList){
            if(opportunities.StageName != oldMap.get(opportunities.Id).StageName){
                if(opportunities.StageName == 'Closed Lost' && opportunities.Closed_Lost_Reason__c == NULL){
                    opportunities.addError('Please populate Closed Lost Reason on opportunity.');
                }
            }
        }
    }

    public static void validationOnDeletion(List<Opportunity> oldList){
        Id systemAdminID = OpportunitySelector.getSystemAdminIds();
        for(Opportunity opportunities : oldList){
            if(UserInfo.getProfileId() != systemAdminID){
                opportunities.addError('Account cannot be deleted !');
            }
        }
    }

    public static List<Account> getAnnualRevenueToAccount(List<Opportunity> oldList){
        List<Account> accountList = new List<Account>();
        Set<Id> opportunityIds = new Set<Id>();
        for(Opportunity opportunity : oldList){
            opportunityIds.add(opportunity.AccountId);  
        }
        List<Account> newAccount = new List<Account>();
        Decimal totalAmount = 0;
        newAccount = OpportunitySelector.getOpportunityRecordRelatedToAccount(oldList, opportunityIds);
        for(Account account : newAccount){
            for(Opportunity newOpportunities : account.Opportunities){
                totalAmount = totalAmount + newOpportunities.Amount;
            }
            account.AnnualRevenue = totalAmount;
            accountList.add(account);
        }
        return accountList;
    }
}