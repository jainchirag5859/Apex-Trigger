public with sharing class ContactSelector {
    public static List<Contact> getEmailsRelatedToContact(){
        List<Contact> contacts = [SELECT Id, Email FROM Contact]; //NOPMD
        return contacts;
    }
}