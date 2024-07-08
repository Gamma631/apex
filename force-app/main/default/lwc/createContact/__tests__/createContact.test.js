import { createElement } from 'lwc';
import CreateContact from 'c/createContact'; // Adjust path based on your component location
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import { ShowToastEventName } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/CreateContactController.getAccounts';
import createContact from '@salesforce/apex/CreateContactController.createContact';

jest.mock('@salesforce/apex/CreateContactController.createContact', () => {
    return {
        default: jest.fn()
    };
});

const mockGetAccounts = registerApexTestWireAdapter(getAccounts);

describe('c-create-contact', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('renders create contact form', () => {
        const element = createElement('c-create-contact', {
            is: CreateContact
        });
        document.body.appendChild(element);

        const inputs = element.shadowRoot.querySelectorAll('lightning-input');
        expect(inputs.length).toBe(3);

        const combobox = element.shadowRoot.querySelector('lightning-combobox');
        expect(combobox).not.toBeNull();

        const button = element.shadowRoot.querySelector('lightning-button');
        expect(button).not.toBeNull();
    });

    it('handles input change', () => {
        const element = createElement('c-create-contact', {
            is: CreateContact
        });
        document.body.appendChild(element);

        const input = element.shadowRoot.querySelector('lightning-input[data-id="firstName"]');
        input.value = 'John';
        input.dispatchEvent(new CustomEvent('change'));

        expect(element.firstName).toBe('John');
    });

    it('handles combobox change', () => {
        const element = createElement('c-create-contact', {
            is: CreateContact
        });
        document.body.appendChild(element);

        const combobox = element.shadowRoot.querySelector('lightning-combobox');
        combobox.value = '0015g00000X8ZBBAA3';
        combobox.dispatchEvent(new CustomEvent('change'));

        expect(element.accountId).toBe('0015g00000X8ZBBAA3');
    });

    it('creates contact and shows success toast', async () => {
        const element = createElement('c-create-contact', {
            is: CreateContact
        });
        document.body.appendChild(element);

        createContact.mockResolvedValue();

        const button = element.shadowRoot.querySelector('lightning-button');
        button.click();

        await Promise.resolve();

        expect(createContact).toHaveBeenCalled();
        expect(createContact.mock.calls[0][0]).toEqual({
            firstName: '',
            lastName: '',
            email: '',
            accountId: ''
        });

        const toastEvent = new CustomEvent(ShowToastEventName, {
            detail: {
                title: 'Success',
                message: 'Contact created successfully',
                variant: 'success',
            }
        });
        expect(element.dispatchEvent).toHaveBeenCalledWith(toastEvent);
    });

    it('shows error toast on create contact failure', async () => {
        const element = createElement('c-create-contact', {
            is: CreateContact
        });
        document.body.appendChild(element);

        createContact.mockRejectedValue({ body: { message: 'Error creating contact' } });

        const button = element.shadowRoot.querySelector('lightning-button');
        button.click();

        await Promise.resolve();

        expect(createContact).toHaveBeenCalled();

        const toastEvent = new CustomEvent(ShowToastEventName, {
            detail: {
                title: 'Error creating contact',
                message: 'Error creating contact',
                variant: 'error',
            }
        });
        expect(element.dispatchEvent).toHaveBeenCalledWith(toastEvent);
    });

    it('loads accounts options', async () => {
        const element = createElement('c-create-contact', {
            is: CreateContact
        });
        document.body.appendChild(element);

        mockGetAccounts.emit([{ Id: '0015g00000X8ZBBAA3', Name: 'Test Account' }]);

        await Promise.resolve();

        const combobox = element.shadowRoot.querySelector('lightning-combobox');
        expect(combobox.options.length).toBe(1);
        expect(combobox.options[0].label).toBe('Test Account');
        expect(combobox.options[0].value).toBe('0015g00000X8ZBBAA3');
    });

    it('shows error toast on wire failure', async () => {
        const element = createElement('c-create-contact', {
            is: CreateContact
        });
        document.body.appendChild(element);

        mockGetAccounts.error({ body: { message: 'Error loading accounts' } });

        await Promise.resolve();

        const toastEvent = new CustomEvent(ShowToastEventName, {
            detail: {
                title: 'Error loading accounts',
                message: 'Error loading accounts',
                variant: 'error',
            }
        });
        expect(element.dispatchEvent).toHaveBeenCalledWith(toastEvent);
    });
});