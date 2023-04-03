trigger EmployeeTrigger on Employee__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) { //NOPMD
    switch on Trigger.OperationType{
        when BEFORE_INSERT{
        EmployeeTriggerHandler.beforeInsert(Trigger.new);
        }
        when AFTER_INSERT{
        EmployeeTriggerHandler.AfterInsert(Trigger.new);
        }
        when BEFORE_UPDATE{
        EmployeeTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE{
        EmployeeTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        when BEFORE_DELETE{
        EmployeeTriggerHandler.beforeDelete(Trigger.old);
        }
        when AFTER_DELETE{
        EmployeeTriggerHandler.afterDelete(Trigger.old);
        }
        when AFTER_UNDELETE{
            EmployeeTriggerHandler.afterUndelete(Trigger.new);
        }
    }
}