public with sharing class DMLMethods {
    public DMLMethods() {

    }

    public void SpawnContacts() {
        List<Contact> contacts = new List<Contact>();
        for (int i = 0; i < 200; i++) {
            Contact con = new Contact(
                LastName = 'Contact' + i
            );
            contacts.add(con);
        }
        insert contacts;
    }

    public void CreateHomes() {
        List<Account> accs = new List<Account>();
        for (int i = 0; i < 3; i++) {
            Account acc = new Account(
                Name = 'Home' + i
            );
            accs.add(acc);
        }
        insert accs;
    }

    public void Relocate() { //this is an evil challenge as the createddate field is not on the contacts documentation haha
        List<Contact> contacts = [SELECT CreatedDate FROM Contact ORDER BY CreatedDate DESC LIMIT 50];
        delete contacts;
    }
}