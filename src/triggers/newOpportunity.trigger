trigger newOpportunity on Opportunity (after insert) 
{
    List<Job__c> newJobs = new List<Job__c> {};
    
    for (Opportunity opp : trigger.new)
    {
        newJobs.add(new Job__c(Type__c = 'Fax Message', Priority__c = 1, Opportunity__c = opp.Id));
        newJobs.add(new Job__c(Type__c = 'Email Message', Priority__c = 5, Opportunity__c = opp.Id));        
    }
    
    insert newJobs;
}