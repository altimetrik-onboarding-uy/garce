<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Compensation_Rejected</fullName>
        <description>Compensation rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Compensation_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Compensation_approved</fullName>
        <description>Compensation approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Compensation_Approved</template>
    </alerts>
    <alerts>
        <fullName>Compensation_to_approve</fullName>
        <description>Compensation to approve</description>
        <protected>false</protected>
        <recipients>
            <recipient>garce.manager@altimetrik.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Compensation_Approval</template>
    </alerts>
    <alerts>
        <fullName>Send_Email</fullName>
        <description>Send Email</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Compensation</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approve_Compensation</fullName>
        <field>Status__c</field>
        <literalValue>APPROVED</literalValue>
        <name>Approve Compensation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reject_Compensation</fullName>
        <field>Status__c</field>
        <literalValue>REJECTED</literalValue>
        <name>Reject Compensation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submit_Status</fullName>
        <field>Status__c</field>
        <literalValue>SUBMITTED</literalValue>
        <name>Submit Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Send Email when creates</fullName>
        <actions>
            <name>Send_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Compensation__c.Location__c</field>
            <operation>equals</operation>
            <value>Uruguay</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
