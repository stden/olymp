import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

public class advert_nn {
	static final String PROBLEM_ID;
	static {
		String s = new Throwable().getStackTrace()[0].getClassName();
		PROBLEM_ID = s.substring(0, s.indexOf('_'));
	}

	public static void main(String[] args) throws IOException {
		Scanner sc = new Scanner(new File(PROBLEM_ID + ".in"));
		int n = sc.nextInt();
		int w = sc.nextInt();
		int h = sc.nextInt();
		int[] a = new int[n];
		int[] b = new int[n];
		for (int i = 0; i < n; i++) {
			a[i] = sc.nextInt();
			b[i] = sc.nextInt();
		}
		double l = 0;
		double r = 1e10;
		double m = (l + r) * .5;
		while (l != m && r != m) {
			if (check(w, h, a, b, m)) {
				l = m;
			} else {
				r = m;
			}
			m = (l + r) * .5;
		}
		PrintWriter out = new PrintWriter(PROBLEM_ID + ".out");
		out.println(r);
		out.close();
	}

	static boolean check(int w, int h, int[] a, int[] b, double k) {
		double z = 0;
		int n = a.length;
		int last = Integer.MIN_VALUE;
		double width = 0;
		for (int i = 0; i < n; i++) {
			if (a[i] * k > w) {
				return false;
			}
			if (last == b[i] && a[i] * k + width <= w) {
				width += a[i] * k;
			} else {
				width = a[i] * k;
				z += b[i] * k;
			}
			last = b[i];
		}
		return z <= h;
	}
}
