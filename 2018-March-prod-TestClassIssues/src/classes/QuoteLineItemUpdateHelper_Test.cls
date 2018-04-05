/*
Name - QuoteLineItemUpdateHelper_Test
Author - Shyam Prasad Nayakula
Purpose - Test Class
Date - May-2016
*/
@isTest(SeeAllData=true)
public class QuoteLineItemUpdateHelper_Test 
{
    static testmethod void method1()
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
        
        
        Quote quote=TestDataUtil.createQuote('999',opp);
        insert quote;
        
        GE_LGT_EM_MaterialMaster__c matMaster=TestDataUtil.createMaterialMaster('93036710');
        insert matMaster;
        
        QuoteLineItem quoteItem=TestDataUtil.createQuoteItem('999','10');
        quoteItem.SKU__c='93058343';
        insert quoteItem;
        
        List<QuoteLineItem> qliList=new List<QuoteLineItem>();
        qliList.add(quoteItem);
        
        QuoteLineItemUpdateHelper qlih=new QuoteLineItemUpdateHelper();
        qlih.removeLeadingZeros(qliList);
       // below code will provide coverage for delete QuoteLineItem cases
        delete qliList;
    }
}