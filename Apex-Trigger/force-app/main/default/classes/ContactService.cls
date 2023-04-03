public with sharing class ContactService {
    public static List<Messaging.SingleEmailMessage> getEmailTemplateFromContact(List<Contact> newList){
        List<Messaging.SingleEmailMessage> eMails =  new List<Messaging.SingleEmailMessage>();
    
        for(Contact contact: newList) {
                Messaging.SingleEmailMessage mailInstance = new Messaging.SingleEmailMessage();
                String name = ((contact.FirstName != NULL) ? contact.FirstName : '') + contact.LastName;
                mailInstance.setTargetObjectId(contact.Id);
                mailInstance.setReplyTo(contact.Email);
                mailInstance.setSenderDisplayName(name);
                mailInstance.setSubject('New Contact is Created');
                String body = 'Hi';
                body += name + ' is your new Contact.';
                mailInstance.setHtmlBody(body);
                eMails.add(mailInstance);
        }
        return eMails;
    }

    public static void getDuplicationRuleByEmail(List<Contact> newList){
        Set<String> contactEmails = new Set<String>();
        List<Contact> contacts = ContactSelector.getEmailsRelatedToContact();

        for (Contact contact : contacts) {
            if (contact.Email != NULL) {
                contactEmails.add(contact.Email);
            }
        }

        for (Contact contact : newList) {
            if (contactEmails.contains(contact.Email)) {
                contact.addError('This email is exist in another contact you can not create contact with this email');
            }
        }
    }
}