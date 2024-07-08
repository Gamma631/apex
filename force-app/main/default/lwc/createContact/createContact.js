import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/CreateContactController.getAccounts';
import createContact from '@salesforce/apex/CreateContactController.createContact';

export default class ContactForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track accountId = '';
    @track accountOptions = [];

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(account => {
                return { label: account.Name, value: account.Id };
            });
        } else if (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading accounts',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        }
    }

    handleSubmit() {
        const fields = {
            firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
            accountId: this.accountId
        };

        createContact({ contact: fields })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created successfully',
                        variant: 'success',
                    }),
                );

                this.firstName = '';
                this.lastName = '';
                this.email = '';
                this.accountId = '';
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating contact',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
}
