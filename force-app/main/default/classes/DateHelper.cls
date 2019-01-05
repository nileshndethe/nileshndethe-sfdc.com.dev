/**
 *	@author Nilesh Dethe (nilesh.ndethe@hotmail.com)
 *	@version 1.0.0
 *	@description This is a helpler class wchich uses system Date class method to provide below advaced level date helper methods -
 *		- Public String getDayOfDate(Date currentDate)  
		- Public Date getStartDayOfWeek(Date dateToCheck)
		- Public Date getEndDayOfWeek(Date dateToCheck)
		- Public Map<String,Date> getMapOfMiddleDayAndWeek(Date startDate, Date endDate)

	@Usage of the above class
		Date d1 = date.newinstance(2015, 01, 1);  
		Date d2 = date.newinstance(2015, 02, 28);  
		DateHelper dtHelper = new DateHelper();
		System.debug('Day of Date [ '+d1+' ] >>> ' + dtHelper.getDayOfDate(d1));
		System.debug('Start day of the week for a date [ '+d2+' ] >>> ' + dtHelper.getStartDayOfWeek(d2)); 
		System.debug('End day of the week for a date [ '+d2+' ] >>> ' + dtHelper.getEndDayOfWeek(d2)); 
		Map<String,Date> mapDateWeek = dtHelper.getMapOfMiddleDayAndWeek(d1,d2);
		System.debug('map of Week and middle dates for [ '+d1+ ' and '+d2+' ]  >>> '+ mapDateWeek);
		System.debug('Count of week and midle dates >>> '+ mapDateWeek.size());
 *
 **/ 
public class DateHelper 
{  
    Private Date startDate = date.newInstance(0001, 1, 1); 
	Private String startDayOfWeek = 'Sunday'; 
	Private String endDayOfWeek = 'Saturday';
    Public Date selectedDate{get;set;}  
    public String dayValue{get;set;}      
    public DateHelper()  
    {  
        selectedDate = date.today();         
    }  
  
    Public String getDayOfDate(Date currentDate)  
    {  
        List<String> listDay = new List<String>{'Saturday' , 'Sunday' , 'Monday' , 'Tuesday' , 'Wednesday' , 'Thursday' , 'Friday'};         
        selectedDate = currentDate;
		Integer remainder = Math.mod(startDate.daysBetween(selectedDate) , 7);  
        return dayValue = listDay.get(remainder);  
    }    
	
	Public Date getStartDayOfWeek(Date dateToCheck)
	{	
		String whichDay = getDayOfDate(dateToCheck);
		if(startDayOfWeek.equalsIgnoreCase(whichDay))
		{
			return dateToCheck;
		}
		else
		{	
			return dateToCheck.toStartofWeek();			
		}
	}  
	
	Public Date getEndDayOfWeek(Date dateToCheck)
	{	
		String whichDay = getDayOfDate(dateToCheck);
		if(endDayOfWeek.equalsIgnoreCase(whichDay))
		{
			return dateToCheck;
		}
		else
		{	
			Date startDay = dateToCheck.toStartofWeek();	
			return startDay.addDays(6);
		}
	} 

	public Map<String,Date> getMapOfMiddleDayAndWeek(Date startDate, Date endDate)
	{
		Map<String,Date> mapWeeks = new Map<String,Date>();
		Date startDayOfweek = getStartDayOfWeek(startDate);		
		Date endDayOfWeek = getEndDayOfWeek(endDate);	
		Integer noOfDays = startDayOfweek.daysBetween(endDayOfWeek);
		//system.debug('noOfDays >>> ' + noOfDays);
		Integer noOfWeeks = noOfDays/7;
		//system.debug('noOfWeeks >>> ' + noOfWeeks);
		Date firstWeekMiddleDate = startDayOfweek.addDays(4);		
		String firstweek = 'Week' + DateTime.newInstanceGmt(firstWeekMiddleDate, Time.NewInstance(12,0,0,0)).format('w');
		
		mapWeeks.put(firstweek,firstWeekMiddleDate);
		Date newWeekMiddleDate = firstWeekMiddleDate;
		String newWeek = firstweek;
		for(Integer count=1; count<noOfWeeks; count++)
		{
			newWeekMiddleDate = newWeekMiddleDate.addDays(7);
			//system.debug('newWeekMiddleDate ' + count +' >>> ' + newWeekMiddleDate);
			newWeek = 'Week' +  DateTime.newInstanceGmt(newWeekMiddleDate, Time.NewInstance(12,0,0,0)).format('w');
			//system.debug('newWeek '+newWeek +' >>> ' + newWeek);
			mapWeeks.put(newWeek,newWeekMiddleDate);
		}	
		return mapWeeks;
	}
}