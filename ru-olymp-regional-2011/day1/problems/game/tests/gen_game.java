import java.io.*;
import java.util.*;

public class gen_game implements Runnable {
	public static void main(String[] args) {
		if (args.length < 1) {
			for (I = 1; (new File(getName(I) + ".t")).exists(); I++)
				;
		} else {
			I = Integer.parseInt(args[0]);
		}
		new Thread(new gen_game()).start();
	}

	PrintWriter out;

	Random rand = new Random(6439586L);

	static int I;

	static String getName(int i) {
		return ((i < 10) ? "0" : "") + i;
	}

	void open() {
		try {
			System.out.println("Generating test " + I);
			out = new PrintWriter(getName(I));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	void close() {
		out.close();
		I++;
	}

	final String ALPHA = "abcdefghijklmnopqrstuvwxyz";

	String randString(int len, String alpha) {
		StringBuilder ans = new StringBuilder();
		int k = alpha.length();
		for (int i = 0; i < len; i++) {
			ans.append(alpha.charAt(rand.nextInt(k)));
		}
		return ans.toString();
	}

	long rand(long l, long r) {
		return l + (rand.nextLong() >>> 1) % (r - l + 1);
	}

	int rand(int l, int r) {
		return l + rand.nextInt(r - l + 1);
	}

	final int MAXN = 10000;
	final int MAXM = 100000;
	final int MAXK = 100000;

	void writeTest(int n, int m, int k) {
		open();
		out.println(n + " " + m + " " + k);
		close();
	}

	void genTest(int LN, int RN, int LM, int RM, int cmp) {
		int n = rand(LN, RN);
		int m = rand(LM, RM - 1);
		int k = m;
		if (cmp < 0) {
			m = rand(LM, RM - 2);
			k = rand(LM, RM - 2);
			if (m > k) {
				int tmp = m;
				m = k;
				k = tmp;
			}
			k += 2;
		} else if (cmp > 0) {
			k = rand(LM, RM - 1);
			if (m < k) {
				int tmp = m;
				m = k;
				k = tmp;
			}
			++m;
		} else {
			m = k = rand(LM, RM);
		}
		writeTest(n, m, k);
	}
	
	public void solve() throws IOException {
		// m < k - 1 => n * m
		// 10 tests
		
		writeTest(1, 1, 3);

		for (int i = 0; i < 2; ++i) {
			genTest(1, 1, 1, 5, -1);
		}

		for (int i = 0; i < 3; ++i) {
			genTest(10, 30, 20, 100, -1);
		}

		for (int i = 0; i < 3; ++i) {
			genTest(MAXN / 2, MAXN, MAXM / 2, MAXM, -1);			
		}

		writeTest(MAXN, MAXK - 2, MAXK);
		
		// m >= k => n * (k - 1 + m / k)
		// 10 tests

		for (int i = 0; i < 2; ++i) {
			genTest(1, 1, 1, 5, 1);
		}

		for (int i = 0; i < 3; ++i) {
			genTest(10, 30, 20, 100, 1);
		}

		for (int i = 0; i < 4; ++i) {
			genTest(MAXN / 2, MAXN, MAXM / 2, MAXM, 1);			
		}

		writeTest(MAXN, MAXK, MAXK - 2);
	}

	void myAssert(boolean e) {
		if (!e) {
			throw new Error("Assertion failed");
		}
	}

	public void run() {
		try {
			solve();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}
}