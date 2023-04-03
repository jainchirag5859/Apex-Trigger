trigger UserTrigger on User (before insert, before update, before delete, after insert, after update, after delete, after undelete) { //NOPMD
    switch on Trigger.OperationType{
        when BEFORE_INSERT{
            UserTriggerHandler.beforeInsert(Trigger.new);
        }
        when AFTER_INSERT{
            UserTriggerHandler.AfterInsert(Trigger.new);
        }
        when BEFORE_UPDATE{
            UserTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE{
            UserTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        when BEFORE_DELETE{
            UserTriggerHandler.beforeDelete(Trigger.old);
        }
        when AFTER_DELETE{
            UserTriggerHandler.afterDelete(Trigger.old);
        }
    }
}