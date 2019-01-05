public class BusScheduleCache {
	private Cache.OrgPartition part;
    
    public BusScheduleCache(){
        part = new Cache.OrgPartition('local.BusSchedule');
    }
    
    public void putSchedule(String busLine, Time[] schedule){
        part.put(busLine, schedule);
    }
    
    public Time[] getSchedule(String busLine){
        Time[] reqSchedule = new List<Time>();           
        Object obj = part.get(busLine);
		
        Time t2;
        if (obj != null) {
        	t2 = (Time)obj;
        }
        if (t2 != null) {
        	reqSchedule.add(t2);
        }
        else {
            Time t3 = Time.newInstance(8,0,0,0);
            if (t3 != null){
            	reqSchedule.add(t3);
            }
            Time t4 = Time.newInstance(17,0,0,0);
            if (t4 != null){
                reqSchedule.add(t4);
            }
        }     
        return reqSchedule;
    }
}