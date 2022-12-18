package junit;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.atLeastOnce;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.any;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;

import code.Location;
import code.LocationPoint;
import code.LocationService;

public class LocationTest {

	@Mock
	private LocationService OurMockLoc;
	private Location location;
	private LocationPoint locationPoint;

	@BeforeEach
	public void setUp() throws Exception {
		OurMockLoc = Mockito.mock(LocationService.class);
		location = new Location(OurMockLoc);
		locationPoint = new LocationPoint(1, 2);
		location.SetCheckPoint(locationPoint);
	}

	/**
	 * Define method that check if the points are equals
	 */
	private boolean checkIflocationPointEquals(LocationPoint p1, LocationPoint p2) {
		return p1.getX() == p2.getX() && p1.getY() == p2.getY();
	}
	
	// check functionality: both x && y are positive
	// input data: LocatoinPoint (1,2), LocatoinPoint (1,2)
	// expected result: true
	@Test
	public void locateTest_X_And_Y_Positive() {
		LocationPoint expectedResult = locationPoint;
		when(OurMockLoc.geoLocate(any(LocationPoint.class))).thenReturn(expectedResult);
		LocationPoint actualresult = location.locate(1, 2);
		assertTrue(checkIflocationPointEquals(expectedResult, actualresult));
	}
	
	// check functionality: x positive && y is negative
	// input data: LocatoinPoint (1,-2), LocatoinPoint (1,2)
	// expected result: true
	@Test
	public void locateTest_X_Positive_Y_Neagtive() {
		LocationPoint expectedResult = locationPoint;
		LocationPoint actualresult = location.locate(1, -2);
		assertTrue(checkIflocationPointEquals(expectedResult,actualresult));
	}
	
	// check functionality: x negative && y is positive
	// input data: LocatoinPoint (-1,2), LocatoinPoint (1,2)
	// expected result: true
	@Test
	public void locateTest_X_Negative_Y_Positive() {
		LocationPoint expectedResult = locationPoint;
		LocationPoint actualresult = location.locate(-1, 2);
		assertTrue(checkIflocationPointEquals(expectedResult, actualresult));
	}

	// check functionality: both x && y are negative
	// input data: LocatoinPoint (-1,-2), LocatoinPoint (1,2)
	// expected result: true
	@Test
	public void locateTestX_And_Y_Neagtive() {
		LocationPoint expectedResult = locationPoint;
		LocationPoint actualresult = location.locate(-1, -2);
		assertTrue(checkIflocationPointEquals(expectedResult,actualresult));
	}

	// check functionality: print when point is null
	// input data: String ("null Object"), null
	// expected result: true
	@Test
	public void printTestCalculationStatusNullPoint() {
		String expectedResult = new String("null object");
		when(OurMockLoc.printStatus(any(LocationPoint.class))).thenReturn("No point");
		try {
			location.printCalculationStatus(null);
			fail();
		} catch (NullPointerException e) {
			assertTrue(expectedResult.equals(e.getMessage()));
		}
	}

	// check functionality: point is not null
	// input data: LocationPoint (1,2)
	// expected result: true
	@Test
	void printTestCalculationStatusExistPoint() {
		LocationPoint expectedResult = locationPoint;
		when(OurMockLoc.printStatus(any(LocationPoint.class))).thenReturn("OK");
		location.printCalculationStatus(expectedResult);
		LocationPoint actualresult = location.GetCheckPoint();
		verify(OurMockLoc, atLeastOnce()).printStatus(Mockito.any(LocationPoint.class));
		assertEquals(actualresult,expectedResult);
	}

}