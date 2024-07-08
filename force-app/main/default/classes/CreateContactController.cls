public with sharing class CreateContactController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    @AuraEnabled
    public static void createContact(Contact contact) {
        insert contact;
    }
}