package code;

public class LocationService {

    public LocationPoint geoLocate(LocationPoint locationPoint) {
        return new LocationPoint(locationPoint.getX(), locationPoint.getY());
    }

    public LocationPoint generatePointWithinDistance(LocationPoint locationPoint, int distance) {
    	LocationPoint returnPointWithDistance = new LocationPoint(locationPoint.getX() + Utils.randomDistance(distance), 
    											  locationPoint.getY() + Utils.randomDistance(distance)); 
        return  returnPointWithDistance;
    }
    
    public String printStatus(LocationPoint locationPoint) {
    	if (locationPoint != null) 
    		return "OK";
    	return "No point";
    }
}
