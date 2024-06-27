import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const columns = [
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class AccountSearchWire extends LightningElement {
    accountName = '';
    accounts;
    columns = columns;

    @wire(getAccounts, { accountName: '$accountName' })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }

    handleInputChange(event) {
        this.accountName = event.target.value;
    }
}