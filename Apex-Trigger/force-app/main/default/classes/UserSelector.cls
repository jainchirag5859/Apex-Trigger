public with sharing class UserSelector {
    public static Id groupIds(){
        Id idOfGroup = [SELECT Id FROM Group WHERE Name ='Admins' LIMIT 1].Id;
        return IdOfGroup;
    }

    public static Id adimProfileIds(){
        Id adminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        return adminProfileId;
    }
}