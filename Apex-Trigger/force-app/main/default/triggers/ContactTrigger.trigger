trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete) { //NOPMD
    switch on Trigger.OperationType{
        when BEFORE_INSERT{
            ContactTriggerHandler.beforeInsert(Trigger.new);
        }
        when AFTER_INSERT{
            ContactTriggerHandler.AfterInsert(Trigger.new);
        }
        when BEFORE_UPDATE{
            ContactTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE{
            ContactTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        when BEFORE_DELETE{
            ContactTriggerHandler.beforeDelete(Trigger.old);
        }
        when AFTER_DELETE{
            ContactTriggerHandler.afterDelete(Trigger.old);
        }
    }
}