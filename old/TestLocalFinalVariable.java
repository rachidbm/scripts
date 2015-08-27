
public class TestLocalFinalVariable {

	private static final int ROUNDS = 10000000;
	
	public static void main(String[] args) {
		TestLocalFinalVariable t = new TestLocalFinalVariable();
		t.startTest();
	}
	
	public void startTest() {
		System.out.println("Warming up.");
		// Warming up
		for(int i=0; i<ROUNDS; i++) {
			methodWithFinalVariables();
			methodWithoutFinalVariables();
//			methodWithFinalVariables2();
//			methodWithoutFinalVariables2();
		}
				
		System.out.println("Warming up finished, running the test.");
		
		testFinals();		
		testNoFinals();
		testNoFinals();
		testFinals();
		
//		testFinals2();
//		testNoFinals2();
	}
	
	private void testFinals() {
		long start = System.currentTimeMillis();
		for(int i=0; i<ROUNDS; i++) {
			methodWithFinalVariables();
		}
		System.out.println("with finals: " + (System.currentTimeMillis()-start) + " ms");		
	}	
	private void testNoFinals() {
		long start = System.currentTimeMillis();
		for(int i=0; i<ROUNDS; i++) {
			methodWithoutFinalVariables();
		}
		System.out.println("no finals: " + (System.currentTimeMillis()-start) + " ms");		
	}
	
	private void testFinals2() {
		long start = System.currentTimeMillis();
		for(int i=0; i<ROUNDS; i++) {
			methodWithFinalVariables2();
		}
		System.out.println("2 with finals: " + (System.currentTimeMillis()-start) + " ms");		
	}	
	private void testNoFinals2() {
		long start = System.currentTimeMillis();
		for(int i=0; i<ROUNDS; i++) {
			methodWithoutFinalVariables2();
		}
		System.out.println("2 no finals: " + (System.currentTimeMillis()-start) + " ms");		
	}
	
	public long methodWithFinalVariables() {
		final long test4 = System.currentTimeMillis();
		return test4;
	} 
	public long methodWithoutFinalVariables() {
		long test4 = System.currentTimeMillis();
		return test4;
	}
	
	public String  methodWithFinalVariables2() {
		final String test = "This is a local String which never gonna change";
		return test+" addition";
	} 
	public String methodWithoutFinalVariables2() {
		String test = "This is a local String which never gonna change";
		return test+" addition";
	}	
}
