import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const columns = [
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class AccountSearchImperative extends LightningElement {
    accountName = '';
    accounts;
    columns = columns;

    handleInputChange(event) {
        this.accountName = event.target.value;
        this.loadAccounts();
    }

    loadAccounts() {
        getAccounts({ accountName: this.accountName })
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                console.error('Error fetching accounts:', error);
            });
    }
}