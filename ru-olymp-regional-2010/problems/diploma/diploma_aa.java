import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Scanner;

public class diploma_aa {

	public static void myAssert(boolean u, String message) {
		if (!u) {
			throw new Error("Assertion failed!!! " + message);
		}
	}

	public static int inBounds(int x, int l, int r, String name) {
		myAssert(l <= x && x <= r, name + " not in bounds!!! " + x
				+ " not in [" + l + ".." + r + "]");
		return x;
	}

	public static void main(String[] args) throws IOException {
		Scanner in = new Scanner(new FileReader("diploma.in"));
		PrintWriter out = new PrintWriter("diploma.out");
		long w = inBounds(in.nextInt(), 1, 1000000000, "w");
		long h = inBounds(in.nextInt(), 1, 1000000000, "h");
		long n = inBounds(in.nextInt(), 1, 1000000000, "n");
		long l = 0;
		long r = Math.max(w, h) * n;
		while (r - l > 1) {
			long m = (l + r) / 2;
			long x = m / w;
			long y = m / h;
			if (x * y >= n) {
				r = m;
			} else {
				l = m;
			}
		}
		out.println(r);
		in.close();
		out.close();
	}
}
