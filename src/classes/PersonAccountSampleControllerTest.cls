@isTest
private class PersonAccountSampleControllerTest {
    
    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    static testMethod void PersonAccountSampleControllerTest() {
        
        System.runAs(testAdminUser) {
            
            PersonAccountSampleController cls = new PersonAccountSampleController();
            cls.contact.LastName = 'Yoshikawa';
            cls.contact.FirstName = 'Taiki';
            cls.personAccount.AccountNumber = 'A0001';
            cls.personAccount.Phone = '000-111-2222';
            cls.personAccount.Website = 'https://tyoshikawa1106.github.io/';
            cls.personAccount.PersonBirthdate = System.today();
            cls.personAccount.PersonEmail = 'sample@example.com';

            Test.startTest();

            cls.doSave();

            Test.stopTest();

            Account result = [SELECT Id,LastName,FirstName,AccountNumber,Phone,Website,PersonBirthdate,PersonEmail
                                                                     FROM Account WHERE AccountNumber = 'A0001' LIMIT 1];
            System.assertEquals(result.LastName, 'Yoshikawa');
            System.assertEquals(result.FirstName, 'Taiki');
            System.assertEquals(result.AccountNumber, 'A0001');
            System.assertEquals(result.Phone, '000-111-2222');
            System.assertEquals(result.Website, 'https://tyoshikawa1106.github.io/');
            System.assertEquals(result.PersonBirthdate, System.today());
            System.assertEquals(result.PersonEmail, 'sample@example.com');
        }
    }
}