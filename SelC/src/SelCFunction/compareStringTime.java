package SelCFunction;

public class compareStringTime {

	// a : ���ϴ� ���� �ð�
	// b : Ŭ���� ���� �ð�
	public static boolean compare(String a, String b) {
		
		String[] a_ar = a.split("[:]");
		String[] b_ar = b.split("[:]");
		
		int aH = Integer.parseInt(a_ar[0]);
		int aM = Integer.parseInt(a_ar[1]);
		int bH = Integer.parseInt(b_ar[0]);
		int bM = Integer.parseInt(b_ar[1]);
		
		if(bH < aH) {
			return false;
		} else if(bH==aH) {
			if(bM < aM) {
				return false;
			} else if(bM==aM) {
				return true;
			}
		}
		
		return true;
	}
	
}
