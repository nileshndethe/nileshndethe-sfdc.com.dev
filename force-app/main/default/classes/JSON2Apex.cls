public class JSON2Apex {

    public class Attributes {
        public String type;
        public String url;
    }

    public class Records {
        public Attributes attributes;
        //public String Id;
        public String ApexClassOrTriggerId;
        public Integer NumLinesCovered;
        public Integer NumLinesUncovered;
    }


    public Integer size;
    public Integer totalSize;
    public Boolean done;
    public Object queryLocator;
    public String entityTypeName;
    public List<Records> records;

    
    public static JSON2Apex parse(String json) {
        return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
    }
}