trigger OrderEventTrigger on Order_Event__e (after insert) {
    List<String> OrderNums = New List<String>();
    for(Order_Event__e orEvent:Trigger.New){
        if(orEvent.Type__c == 'Shipped') OrderNums.add(orEvent.Order_Number__c);        
    }
    List<Order> OrderShipped = [SELECT Id, Status, OrderNumber FROM Order WHERE OrderNumber IN :OrderNums];
    for(Order o : OrderShipped) o.Status= 'Shipped';
    if(OrderShipped.size() > 0) UPDATE OrderShipped;
}