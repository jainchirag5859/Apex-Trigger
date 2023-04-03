public with sharing class ContactTriggerHandler {
    public static void beforeInsert(List<Contact> newList){ //NOPMD
    
    }
    
    public static void afterInsert(List<Contact> newList){ //NOPMD
        sendEmailFromContact(newList);
        validateDuplicateContactByEmail(newList);
    }
    
    public static void beforeUpdate(List<Contact> newList, Map<Id, Contact> oldMap){ //NOPMD
        
    }

    public static void afterUpdate(List<Contact> newList, Map<Id, Contact> oldMap){ //NOPMD

    }

    public static void beforeDelete(List<Contact> oldList){ //NOPMD
        
    }

    public static void afterDelete(List<Contact> oldList){ //NOPMD
        
    }

    //21. Upon contact creation an email should be sent to email populated on Contact with specified template.
    private static void sendEmailFromContact(List<Contact> newList){
        List<Messaging.SingleEmailMessage> eMails =  new List<Messaging.SingleEmailMessage>();
        eMails = ContactService.getEmailTemplateFromContact(newList);
        if(!eMails.isEmpty()) {
            Messaging.sendEmail(eMails);
        }
    }

    //30. Write a trigger on contact to prevent duplicate records based on Contact Email.
    private static void validateDuplicateContactByEmail(List<Contact> newList){
        ContactService.getDuplicationRuleByEmail(newList);
    }
}