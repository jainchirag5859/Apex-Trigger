public with sharing class UserTriggerHandler {
    public static void beforeInsert(List<User> newList){
        validateGroupOnUserProfiles(newList);
    }
    
    public static void afterInsert(List<User> newList){ //NOPMD
        
    }
    
    public static void beforeUpdate(List<User> newList, Map<Id, User> oldMap){ //NOPMD
        
    }

    public static void afterUpdate(List<User> newList, Map<Id, User> oldMap){ //NOPMD

    }

    public static void beforeDelete(List<User> oldList){ //NOPMD
        
    }

    public static void afterDelete(List<User> oldList){ //NOPMD
        
    }

    //29. Whenever a new User having profile "System Administrator" is inserted and is Active, add the user to the public group "Admins". Create a public group named Admins.
    private static void validateGroupOnUserProfiles(List<User> oldList){
        List<GroupMember> groupMembers = new List<GroupMember>();
        groupMembers = UserService.getGroupMembers(oldList);

        if (!groupMembers.isEmpty()){
            insert groupMembers; //NOPMD
        }
    }

}