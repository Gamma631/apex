import { LightningElement } from 'lwc';
import { subscribe, unsubscribe } from 'lightning/empApi';

export default class HighPrioCaseSub extends LightningElement {
    caseNumber;

    channelName = '/event/High_Prio_Case__e';

    subscription = null;

    connectedCallback() {
        this.subscribeToEvent();
    }

    disconnectedCallback() {
        this.unsubscribeFromEvent();
    }

    subscribeToEvent() {
        const messageCallback = (response) => {
            this.handleEventResponse(response);
        };

        subscribe(this.channelName, -1, messageCallback).then(response => {
            this.subscription = response;
        });
    }

    unsubscribeFromEvent() {
        if (this.subscription) {
            unsubscribe(this.subscription, () => {
                this.subscription = null;
            });
        }
    }

    handleEventResponse(response) {
        const eventData = response.data.payload;
        this.caseNumber = eventData.CaseNumber__c;
    }
}
