@isTest(SeeAllData=true)
public class BA003_AttachProductToQLItems_Test 
{
    static testmethod void testBatch()
    {
        Id recOppTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard').getRecordTypeId();
        ID recAccTypeID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('End User').getRecordTypeId();
        Account acc=TestDataUtil.createAccount();
        acc.GE_LGT_EM_SAPUniqueIdentifier__c='1230011644-2FR1-20-10-SP';
        acc.recordtypeid=recAccTypeID;
        insert acc;
        
        Opportunity opp=TestDataUtil.createOpportunity(acc);
        opp.recordtypeid=recOppTypeID;
        insert opp;
        
        SAP_Quote__c sapQuote=TestDataUtil.createSAPQuote('999');
        sapQuote.Strategic_SAPUniqueId__c='1230011644-2FR1-20-10-SP';
        sapQuote.Agent_SAPUniqueId__c='1230011644-2FR1-20-10-SP';
        sapQuote.GE_Opportunity_Id__c='TestGE123';
        sapQuote.Converted_to_Quote__c=TRUE;
        insert sapQuote;
        
        SAP_Quote_LineItem__c sapQuoteItem=TestDataUtil.createSAPQuoteLineItem('999','10');
        insert sapQuoteItem;
        
        Quote quote=TestDataUtil.createQuote('999',opp);
        insert quote;
        
        GE_LGT_EM_MaterialMaster__c matMaster=TestDataUtil.createMaterialMaster('TEST123564');
        insert matMaster;
        
        QuoteLineItem quoteItem=TestDataUtil.createQuoteItem('999','10');
        insert quoteItem;
        
        List<QuoteLineItem> qliList = new List<QuoteLineItem>();
        qliList.add(quoteItem);
        
        Test.startTest();
        //Database.executeBatch(new BA002_SyncQuoteWithSAPQuote());
        BA003_AttachProductToQLItems batch=new BA003_AttachProductToQLItems();
        batch.start(NULL);
        batch.execute(NULL,qliList);
        Test.stopTest();
    }
}