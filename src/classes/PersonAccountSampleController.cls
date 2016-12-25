public with sharing class PersonAccountSampleController {

    public Account personAccount {get; set;}
    public Contact contact {get; set;}
    private RecordType recordType = new RecordType();

    /**
     * コンストラクタ
     */
    public PersonAccountSampleController() {
        try {
            // 姓と名の入力変数初期化
            this.contact = new Contact();
            // レコードタイプ[個人取引先]取得
            this.recordType = this.getRecordType();
            // 取引先情報取得
            this.personAccount = new Account(RecordTypeId = this.recordType.Id);
        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return;
        }
    }

    /**
     * 保存
     */
    public void doSave() {
        try {
            // 姓と名の値をセット
            this.personAccount.LastName = this.contact.LastName;
            this.personAccount.FirstName = this.contact.FirstName;
            // 保存処理
            insert this.personAccount;
            // 初期化
            this.personAccount = new Account(RecordTypeId = this.recordType.Id);
            this.contact = new Contact();
            // メッセージ
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'OK!!!!!'));
        } catch(DmlException e) {
            ApexPages.addMessages(e);
            return;
        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return;
        }
    }

    /**
     * レコードタイプ[個人取引先]取得
     */
    private RecordType getRecordType() {
        return [SELECT Id FROM RecordType WHERE DeveloperName = 'PersonAccount' AND SObjectType = 'Account' LIMIT 1];
    }
}