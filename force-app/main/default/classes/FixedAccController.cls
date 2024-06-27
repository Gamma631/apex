public with sharing class FixedAccController {
    public transient Account acc { get; set; }
    public String userLang { get; set; }
    public String aboutMe { get; set; }
    public Boolean showGreeting { get; set; }

    public FixedAccController() {
        String acc = '001aj00000HTPneAAH';
        acc = [SELECT Id, Name, Phone, Website, Industry FROM Account WHERE Id = :accId LIMIT 1];

        showGreeting = false;
        userLang = UserInfo.getLanguage();
        
        if (userLang == 'es') {
            aboutMe = 'Sobre mí: Soy un desarrollador apasionado por la tecnología y la innovación.';
        } 
        else {
            aboutMe = 'About Me: I am a developer passionate about technology and innovation.';
        }
    }

    public void showGreetingAction() {
        showGreeting = true;
    }
}