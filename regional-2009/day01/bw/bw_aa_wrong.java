//Задача "Черное и белое"
//Региональный Этап Всероссийской Олимпиады Школьников по Информатике
//Автор задачи: Федор Царев, tsarev@rain.ifmo.ru
//Автор решения: Антон Ахи, akhi@rain.ifmo.ru
//Невеное решение, перепутана последовательность описывающая операцию
import java.io.*;
import java.util.*;
import java.math.*;

public class bw_aa_wrong implements Runnable {

	public static void main(String[] args) {
		new Thread(new bw_aa_wrong()).start();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	boolean eof = false;
	Random rand = new Random(this.hashCode());

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

	String FNAME = "bw_aa".substring(0, "bw_aa".indexOf('_'));

	private void solve() throws IOException {
		int w = nextInt();
		inBounds(w, 1, 100, "w");
		int h = nextInt();
		inBounds(h, 1, 100, "h");
		char[][] a = new char[h][];
		char[][] b = new char[h][];
		for (int i = 0; i < b.length; i++) {
			a[i] = nextToken().toCharArray();
			inBounds(a[i].length, w, w, "a[" + i + "].length");
		}
		for (int i = 0; i < b.length; i++) {
			b[i] = nextToken().toCharArray();
			inBounds(b[i].length, w, w, "b[" + i + "].length");
		}
		char[] c = nextToken().toCharArray();
		inBounds(c.length, 4, 4, "c.length");
		for (int i = 0; i < c.length; i++) {
			inBounds(c[i], '0', '1', "c[" + i + "]");
		}
		int[][] d = new int[2][2];
		d[0][0] = c[0] - '0';
		d[1][0] = c[1] - '0';
		d[0][1] = c[2] - '0';
		d[1][1] = c[3] - '0';
		for (int i = 0; i < a.length; i++) {
			for (int j = 0; j < a[i].length; j++) {
				inBounds(a[i][j], '0', '1', "a[" + i + "][" + j + "]");
				inBounds(b[i][j], '0', '1', "b[" + i + "][" + j + "]");
				out.print(d[a[i][j] - '0'][b[i][j] - '0']);
			}
			out.println();
		}
	}

}
