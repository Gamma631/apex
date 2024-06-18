public with sharing class DMLMethods {
    public DMLMethods() {

    }

    public List<Contact> contacts = new List<Contact>();
    public List<Account> accounts = new List<Account>();

    public void SpawnContacts() {
        List<Contact> cons = new List<Contact>();
        for (int i = 0; i < 200; i++) {
            Contact con = new Contact(
                LastName = 'Contact' + i
            );
            cons.add(con);
        }
        contacts = cons;
        insert cons;
    }

    public void CreateHomes() {
        List<Account> accs = new List<Account>();
        for (int i = 0; i < 3; i++) {
            Account acc = new Account(
                Name = 'Home' + i
            );
            accs.add(acc);
        }
        accounts = accs;
        insert accs;
    }

    public void Relocate() { //this is an evil challenge as the createddate field is only on the system documentation, which is separate from any other object
        List<Contact> cons = [SELECT CreatedDate FROM Contact ORDER BY CreatedDate DESC LIMIT 50];
        for (Contact con : cons) {
            contacts.remove(con);
        }
        delete cons;
    }

    public void AssignHomes() {
        for (Contact con : contacts) {
            con.AccountId = accounts[Math.floor(Math.random() * 3)].Id;
        }
        update cons;
    }
}