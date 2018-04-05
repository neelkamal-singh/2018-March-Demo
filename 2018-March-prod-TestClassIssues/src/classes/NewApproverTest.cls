@isTest(seeAllData=true)
public class NewApproverTest {

    static testMethod void validateSCTrigger() {

        List<User> userList = [SELECT ID,Name FROM User WHERE Name ='Matthew Gugumuck'];
        
        Sales_Concession_Request__c sc = new Sales_Concession_Request__c(); 
        if(!userList.isEmpty())
            sc.GE_LGT_Requestor__c=userList[0].ID;
        sc.GE_LGT_Concession_Status__c='Not Submitted'; 
        sc.Concession_Type__c='Rework';  
        sc.GE_LGT_Root_Cause_Error__c='GE Error - Supply Chain';
        sc.GE_LGT_Concession_Amount__c='Above $10K';
        sc.Select_Required_Approver__c='Kevin Heffernan';
        sc.GE_LGT_Actual_Amount__c=10500.00;
        sc.Agent_Comission_Paid__c='No';
        sc.GE_LGT_Project_Name__c='Auto CR Create';
        sc.GE_LGT_PO_Number__c='123456';
        sc.GE_LGT_Distributor__c='TEST';
        sc.GE_LGT_Fixture_Agency__c='TEST';
        sc.GE_LGT_Comments__c='TESTING';
        //sc.Select_Root_Cause_Issue_s__c = 'Cancellation – failed to cancel in time';
        sc.Select_Root_Cause_Issue_s__c = 'Delayed Ship Date' ;
        insert sc;
        
        //sc.Select_Required_Approver__c = 'Dan Vinton';
        sc.Select_Required_Approver__c = 'Kevin Heffernan';
        update sc;
    }


}