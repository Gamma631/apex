public with sharing class FilterAccsController {
    public String filterName { get; set; }
    
    public FilterAccsController() {
        filterName = '';
    }
    
    public PageReference filterAccs() {
        return Page.AllAccsContacts;
    }
}