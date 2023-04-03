public class PositionTriggerHandler {
    public static void beforeInsert(List<Position__c> newList) {
        defaultValuesForPosition(newList);            
    }

    public static void afterInsert(List<Position__c> newList) { //NOPMD
        
    }

    public static void beforeUpdate(List<Position__c> newList, Map<Id, Position__c> oldMap) { //NOPMD

    }

    public static void afterUpdate(List<Position__c> newList, Map<Id, Position__c> oldMap) { //NOPMD

    }

    public static void beforeDelete(List<Position__c> oldList) { //NOPMD

    }

    public static void afterDelete(List<Position__c> oldList) { //NOPMD

    }

    private static void defaultValuesForPosition(List<Position__c> newList){
        PositionService.getDefaultValuesForPosition(newList);
    }
}