trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete){ //NOPMD
    switch on Trigger.OperationType{
        when BEFORE_INSERT{
            AccountTriggerHandler.beforeInsert(Trigger.new);
        }
        
        when AFTER_INSERT{
            AccountTriggerHandler.AfterInsert(Trigger.new);
        }

        when BEFORE_UPDATE{
            AccountTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }

        when AFTER_UPDATE{
            AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        
        when BEFORE_DELETE{
            AccountTriggerHandler.beforeDelete(Trigger.old);
        }
        
        when AFTER_DELETE{
            AccountTriggerHandler.afterDelete(Trigger.old);
        }
    }
}