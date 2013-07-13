import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

public class TestGen {
	static Random rand = new Random(1);
	Test tests[] = {
			new Test(2, 2),
			new Test(3, 2),
			new Test(4, 2),
			new Test(6, 2),
			new Test(10, 2),
			new Test(360, 2),
			new Test(420, 2),
			new Test(498, 2),
			new Test(360, 2),
			new Test(720, 2),
			new Test(840, 2),
			new Test(994, 2),
			new Test(996, 2),
			new Test(999, 2),
			new Test(1000, 2),

			new Test(8648640, 2),
			new Test(10810800, 2),
			new Test(14414400, 2),
			new Test(17297280, 2),
			new Test(21621600, 2),
			new Test(32432400, 2),
			new Test(36756720, 2),
			new Test(43243200, 2),
			new Test(61261200, 2),
			new Test(73513440, 2),
			new Test(67108864, 2),
			new Test(2 * 3 * 5 * 7 * 11 * 13 * 17 * 19, 2),
			new Test(2 * 5 * 7 * 11 * 13 * 17 * 19 * 23, 2),
			new Test(91891800, 2),
			new Test(100000000, 2),

			new Test(71022710, 3),
			new Test(36256200, 7),
			new Test(80641848, 8),
			new Test(14504435, 3),
			new Test(78239979, 4),
			new Test(31482675, 5),
			new Test(80641848, 6),
			new Test(60493860, 4),
			new Test(60493860, 9),
			new Test(67108864, 3),
			new Test(2 * 3 * 5 * 7 * 11 * 13 * 17 * 19, 9),
			new Test(2 * 5 * 7 * 11 * 13 * 17 * 19 * 23, 6),
			new Test(73513440, 3),
			new Test(73513440, 4),
			new Test(73513440, 5),
			new Test(73513440, 6),
			new Test(73513440, 7),
			new Test(73513440, 9),
			new Test(73513440, 10),
			new Test(100000000, 10),

	};
	final int[] INTERESTING_N = {
			1,
			2,
			4,
			6,
			12,
			24,
			36,
			48,
			60,
			120,
			180,
			240,
			360,
			720,
			840,
			1260,
			1680,
			2520,
			5040,
			7560,
			10080,
			15120,
			20160,
			25200,
			27720,
			45360,
			50400,
			55440,
			83160,
			110880,
			166320,
			221760,
			277200,
			332640,
			498960,
			554400,
			665280,
			720720,
			1081080,
			1441440,
			2162160,
			2882880,
			3603600,
			4324320,
			6486480,
			7207200,
			8648640,
			10810800,
			14414400,
			17297280,
			21621600,
			32432400,
			36756720,
			43243200,
			61261200,
			73513440,
			// 100000000,
			110270160,
			122522400,
			147026880,
			183783600,
			245044800,
			294053760,
			367567200,
			551350800,
			698377680,
			735134400,
			1102701600,
			1396755360
	};

	public void run() throws IOException {
		comments = new PrintWriter("tests.lst");
		for (Test t : tests) {
			write(t);
		}

		comments.close();
	}

	class Test {
		int n, k;
		String comment;

		public Test(String comment, int n, int k) {
			super();
			this.comment = comment;
			this.n = n;
			this.k = k;
		}

		public Test(int n, int k) {
			super();
			this.comment = "n = " + n + ", k = " + k + ", ответ " + solve(n, k);
			this.n = n;
			this.k = k;
		}

	}

	private int testCount = 0;
	PrintWriter comments;

	private void write(Test t) {
		try {
			++testCount;
			System.err.println(testCount + " " + t.comment);
			comments.println(t.comment);
			String filename = testCount / 10 + "" + testCount % 10;
			PrintWriter out = new PrintWriter(filename);
			out.println(t.n + " " + t.k);
			out.flush();
			out.close();
		} catch (IOException ex) {
			throw new RuntimeException(ex);
		}
	}

	void myAssert(boolean b) {
		if (!b)
			throw new AssertionError();
	}

	void rec(int prev, int last, int product, int count) {
		if (count == k) {
			ans++;
			return;
		}
		for (int i = last + 1; i < ndivisors.length; i++) {
			long pr = (long) product * ndivisors[i];
			if (pr > n)
				return;
			if (product * pow(ndivisors[i], k - count) > n)
				return;
			if (gcd(prev, ndivisors[i]) == 1) {
				rec(ndivisors[i], i, (int) pr, count + 1);
			}
		}
	}

	int[] ndivisors;
	int ans;
	int n, k;

	private int gcd(int a, int b) {
		if (b == 0)
			return a;
		return gcd(b, a % b);
	}

	private int[] divisors(int n) {
		ArrayList<Integer> al = new ArrayList<Integer>();
		for (int i = 1; i * i <= n; i++) {
			if (n % i == 0) {
				al.add(i);
				if (n / i != i) {
					al.add(n / i);
				}
			}
		}
		int[] ret = new int[al.size()];
		for (int i = 0; i < ret.length; i++) {
			ret[i] = al.get(i);
		}
		Arrays.sort(ret);
		return ret;
	}

	private double pow(int a, int pow) {
		return Math.pow(a, pow);
	}

	int solve(int n, int k) {
		this.n = n;
		assert 2 <= n && n <= 1e8;
		this.k = k;
		assert 2 <= k && k <= 10;
		ndivisors = divisors(n);
		ans = 0;
		rec(1, -1, 1, 0);
		return ans;
	}

	public static void main(String[] args) throws IOException {
		new TestGen().run();
	}

}
