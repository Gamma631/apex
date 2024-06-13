public with sharing class Sosl {
    public Sosl() {

    }

    public List<List<sObject>> FindTom() {
        return [FIND 'TOM' IN NAMES FIELDS RETURNING Lead(Name), Contact(Name)];
    }

    public List<List<sObject>> SearchAccounts() {
        return [FIND 'a AND o' IN ALL FIELDS RETURNING Account(Id, Name)];
    }

    public List<List<sObject>> FindPhone() {
        return [FIND '1000' IN PHONE FIELDS RETURNING Account(Name), Lead(Name), Contact(Name)];
    }
}