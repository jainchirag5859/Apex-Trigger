public with sharing class PositionService {
    public static void getDefaultValuesForPosition(List<Position__c> newList) {
        for (Position__c position : newList) {
            if(position.Max_Pay__c == NULL && position.Min_Pay__c == NULL && position.Open_Date__c == NULL){
                position.Open_Date__c = Date.today();
                position.Max_Pay__c = 15000;
                position.Min_Pay__c = 10000;
            }
        }
    }
}