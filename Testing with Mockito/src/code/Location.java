package code;

public class Location {
	private final LocationService locationService;	
	private static LocationPoint checkPoint;
	
	public void SetCheckPoint(LocationPoint checkPoint) {
		Location.checkPoint = checkPoint;
	}
	public LocationPoint GetCheckPoint() {
		return Location.checkPoint;
	}
	 
    public Location(LocationService locationService) {
        this.locationService = locationService;
    }
 
    public LocationPoint locate(int x, int y) {
        if (x < 0 || y < 0) {
            return new LocationPoint(Math.abs(x), Math.abs(y));
        } else {
            return locationService.geoLocate(new LocationPoint(x, y));
        }
    }
    public void printCalculationStatus(LocationPoint locationPoint) {    	
    	if (locationService.printStatus(locationPoint).equals("OK")) {
    		checkPoint = locationPoint;
    		System.out.print("OK");
    	} else {
    		throw new NullPointerException("null object");    		
    	}   	
    }
}
