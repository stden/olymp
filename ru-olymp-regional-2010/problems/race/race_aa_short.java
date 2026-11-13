import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Scanner;

public class race_aa_short {

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
		Scanner in = new Scanner(new FileReader("race.in"));
		PrintWriter out = new PrintWriter("race.out");
		short n = (short) inBounds(in.nextInt(), 1, 100, "n");
		short m = (short) inBounds(in.nextInt(), 1, 100, "m");
		short best = Short.MAX_VALUE;
		String winner = "";
		HashSet<String> hs = new HashSet<String>();
		for (int i = 0; i < n; i++) {
			String name = in.next();
			myAssert(!hs.contains(name), "Duplicate name: " + name);
			hs.add(name);
			short res = 0;
			for (short j = 0; j < m; j++) {
				res += inBounds(in.nextInt(), 1, 1000, "t[" + (i + 1) + "]["
						+ (j + 1) + "]");
			}
			if (res < best) {
				best = res;
				winner = name;
			}
		}
		out.println(winner);
		in.close();
		out.close();
	}
}
