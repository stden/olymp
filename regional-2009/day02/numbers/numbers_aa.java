//Задача "Числа"
//Региональный Этап Всероссийской Олимпиады Школьников по Информатике
//Автор задачи: Владимир Ульянцев, ulyancev@rain.ifmo.ru
//Автор решения: Антон Ахи, akhi@rain.ifmo.ru
import java.io.*;
import java.util.*;
import java.math.*;

public class numbers_aa implements Runnable {

	public static void main(String[] args) {
		new Thread(new numbers_aa()).start();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;
	Random rand = new Random(this.hashCode());

	@Override
	public void run() {
		Locale.setDefault(Locale.US);
		try {
			br = new BufferedReader(new FileReader(FNAME + ".in"));
			out = new PrintWriter(FNAME + ".out");
			solve();
			out.close();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(566);
		}
	}

	String nextToken() {
		while (st == null || !st.hasMoreTokens()) {
			try {
				st = new StringTokenizer(br.readLine());
			} catch (Exception e) {
				eof = true;
				return "0";
			}
		}
		return st.nextToken();
	}

	int nextInt() {
		return Integer.parseInt(nextToken());
	}

	long nextLong() {
		return Long.parseLong(nextToken());
	}

	double nextDouble() {
		return Double.parseDouble(nextToken());
	}

	BigInteger nextBigInteger() {
		return new BigInteger(nextToken());
	}

	void myAssert(boolean u, String message) {
		if (!u) {
			throw new Error("Assertion failed!!! " + message);
		}
	}

	void inBounds(long x, long l, long r, String name) {
		myAssert(l <= x && x <= r, name + " is not in bounds [" + l + ".." + r
				+ "]!!!");
	}

	String FNAME = "numbers_aa".substring(0, "numbers_aa".indexOf('_'));

	private void solve() throws IOException {
		int n = nextInt();
		inBounds(n, 1, 50000, "n");
		int c = nextInt();
		inBounds(c, 0, 100000000, "c");
		int k = nextInt();
		inBounds(k, 1, 18, "k");
		long P = BigInteger.TEN.pow(k).longValue();
		char[] s = nextToken().toCharArray();
		myAssert(s.length == n, "Length of string (" + s.length
				+ ") is not equal to n (" + n + ")");
		long[] a = new long[n];
		int l = 0;
		int cc = c;
		while (cc > 0) {
			l++;
			cc /= 10;
		}
		l = Math.max(l, 1);
		for (int i = 0; i < a.length; i++) {
			inBounds(s[i], '0', '9', "a[" + i + "]");
			int q = 1;
			int w = 0;
			for (int j = 0; j < l && i - j >= 0; j++) {
				w += q * (s[i - j] - '0');
				q *= 10;
				if (w <= c && (s[i - j] != '0' || j == 0)) {
					a[i] = (a[i] + (i - j - 1 >= 0 ? a[i - j - 1] : 1)) % P;
				}
			}
		}
		out.println(a[n - 1]);
	}

}
