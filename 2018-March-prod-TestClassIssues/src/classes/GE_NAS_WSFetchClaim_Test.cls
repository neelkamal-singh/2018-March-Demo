@isTest
public class GE_NAS_WSFetchClaim_Test
{
    static testMethod void claimTest()   
    {
        List<TriggerSwitch__c> switchList=TestDataUtil.insertTriggerSwitches();
        insert switchList;
        ID userID = UserInfo.getUserID();
        ID recAcTypeID = [SELECT ID FROM RecordType WHERE SOBJECTTYPE='Account' AND NAME='NA Service Bill To Account'].ID;
        ID reccTypeID = [SELECT ID FROM RecordType WHERE SOBJECTTYPE='Contact' AND NAME='NA Service Contact'].ID;
        ID reccaseTypeID = [SELECT ID FROM RecordType WHERE SOBJECTTYPE='Case' AND NAME='North America'].ID;
        
        Account acc = new Account(RecordTypeId = recAcTypeId,Name='Test Ac',CurrencyIsoCode='USD',accountnumber='9854678');
        insert acc;
        Contact ct= new Contact(RecordTypeId = reccTypeId,LastName='Contact',FirstName='Claim',Email='test@ge.com',AccountId=acc.ID,OwnerID=userID,GE_LGT_Row_Id__c='1-4O3JE7');
        insert ct; 
        
        GE_NAS_Product_Master__c prd=new GE_NAS_Product_Master__c();
        prd.GE_NAS_Product_Code__c='3090';
        prd.GE_NAS_Unit_Type__c ='Test';   
        insert prd;    
        
        Case c = TestDataUtil.createCase(acc);
        c.RecordTypeId = reccaseTypeID;
        c.Contactid=ct.id;
        c.Subject='TEST1';
        c.Type='Account Management';
        c.GE_NAS_Invoice__c='836999';
        c.GE_NAS_SR_Number__c='123424';
        c.GE_NAS_Claim__c='123424';
        c.GE_NAS_Sub_Type__c='CPRD Maintenance';
        c.GE_NAS_Product_Code__c=prd.id;    
        c.Priority='Medium';
        c.Status='Open';
        c.GE_NAS_RowId__c='LHNBY';
        insert c; 
        
        case cs=[select id,casenumber,ownerid,Accountid,GE_NAS_Claim__c,Account.accountnumber,Contactid,GE_NAS_RowId__c,Status,Priority,GE_NAS_SR_Number__c,GE_NAS_Sub_Type__c,GE_NAS_Invoice__c,GE_NAS_Product_Code__r.GE_NAS_Product_Code__c,Type from case where id=:c.id];                                    
        GE_NAS_Claim__c claimobj=new GE_NAS_Claim__c();        
        claimobj.NAS_WS_SRNumber__c=cs.casenumber;
        claimobj.GE_NAS_Claim_Amount__c=185.23;
        claimobj.GE_NAS_Collector_Name__c='Test';
        claimobj.NAS_WS_Collector_Phone__c='Test';
        claimobj.GE_NAS_Claim_Code__c='Test';
        claimobj.GE_NAS_Claim_Type__c='Test';
        claimobj.NAS_WS_PickTicket__c='Test';     
        claimobj.GE_NAS_Debit_Memo_Number__c='Test';      
        claimobj.GE_NAS_Claim_Number__c='123424';  
        insert claimobj;
        claimobj.GE_NAS_Claim_Number__c=c.GE_NAS_Claim__c;
        upsert claimobj;
        GE_NAS_WSFetchClaim fetchc= new GE_NAS_WSFetchClaim(cs);
        fetchc.fetchSFDCClaim();
        fetchc.fetchWSClaim(); 
        //fetchc.claimobj=claimobj;
        fetchc.UpdateClaim();
        ApexPages.StandardController sc=new ApexPages.StandardController(c);  
        GE_NAS_WSFetchClaim fetchc1= new GE_NAS_WSFetchClaim(sc);
    }    

static testMethod void fetchclaimTest()   
    {
        List<TriggerSwitch__c> switchList=TestDataUtil.insertTriggerSwitches();
        insert switchList;
        Profile p = [SELECT Id FROM Profile WHERE Name='GE_NAS_Super_User'];
         User u=OpportunityTriggerHelper_Test.createuser(p.id,'North America',true);
       
        ID userID = UserInfo.getUserID();
        ID recAcTypeID = [SELECT ID FROM RecordType WHERE SOBJECTTYPE='Account' AND NAME='NA Service Bill To Account'].ID;
        ID reccTypeID = [SELECT ID FROM RecordType WHERE SOBJECTTYPE='Contact' AND NAME='NA Service Contact'].ID;
        ID reccaseTypeID = [SELECT ID FROM RecordType WHERE SOBJECTTYPE='Case' AND NAME='North America'].ID;
        
        System.runAs(u){
            
        Account acc = new Account(RecordTypeId = recAcTypeId,Name='Test Ac',CurrencyIsoCode='USD',accountnumber='9854678');
        insert acc;
        Contact ct= new Contact(RecordTypeId = reccTypeId,LastName='Contact',FirstName='Claim',Email='test1@ge.com',AccountId=acc.ID,GE_LGT_Row_Id__c='1-4O3JE7');
        insert ct; 
        
        GE_NAS_Product_Master__c prd=new GE_NAS_Product_Master__c();
        prd.GE_NAS_Product_Code__c='3090';
        prd.GE_NAS_Unit_Type__c ='Test';   
        insert prd;    
        

        Case c = TestDataUtil.createCase(acc);
        c.RecordTypeId = reccaseTypeID;
        c.Contactid=ct.id;
        c.Subject='TEST1';
        c.Type='Account Management';
        c.GE_NAS_Invoice__c='836999';
        c.GE_NAS_SR_Number__c='123424';
        c.GE_NAS_Sub_Type__c='CPRD Maintenance';
        c.GE_NAS_Product_Code__c=prd.id;    
        c.Priority='Medium';
        c.Status='Open';
        c.GE_NAS_RowId__c='LHNBY';
        insert c; 
        
        case cs=[select id,casenumber,ownerid,Accountid,GE_NAS_Claim__c,Account.accountnumber,Contactid,GE_NAS_RowId__c,Status,Priority,GE_NAS_SR_Number__c,GE_NAS_Sub_Type__c,GE_NAS_Invoice__c,GE_NAS_Product_Code__r.GE_NAS_Product_Code__c,Type from case where id=:c.id];                                    
        GE_NAS_Claim__c claimobj=new GE_NAS_Claim__c();        
        claimobj.NAS_WS_SRNumber__c=cs.casenumber;
        claimobj.GE_NAS_Claim_Amount__c=185.23;
        claimobj.GE_NAS_Collector_Name__c='Test';
        claimobj.NAS_WS_Collector_Phone__c='Test';
        claimobj.GE_NAS_Claim_Code__c='Test';
        claimobj.GE_NAS_Claim_Type__c='Test';
        claimobj.NAS_WS_PickTicket__c='Test';     
        claimobj.GE_NAS_Debit_Memo_Number__c='Test';      
        claimobj.GE_NAS_Claim_Number__c= c.GE_NAS_SR_Number__c; 
        insert claimobj;
        claimobj.GE_NAS_Claim_Number__c=c.GE_NAS_Claim__c;
        upsert claimobj;
        
        ApexPages.StandardController sc=new ApexPages.StandardController(c);  
        GE_NAS_WSFetchClaim fetchc1= new GE_NAS_WSFetchClaim(sc);
        GE_NAS_WSFetchClaim fetchc= new GE_NAS_WSFetchClaim(sc);
        c.GE_NAS_Claim__c='';
        fetchc.fetchSFDCClaim();
        fetchc.fetchWSClaim(); 
        GE_NAS_Claim__c claim= [select GE_NAS_mailMessageNew__c,NAS_WS_DisputeDate__c,NAS_WS_CWCErrorDescription__c,NAS_WS_Comments__c,GE_NAS_Processed_Flag__c from GE_NAS_Claim__c where GE_NAS_Claim_Number__c=:c.GE_NAS_Claim__c LIMIT 1];        
        fetchc.UpdateClaim();
        }
    }
}