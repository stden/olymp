// Задача "Клавиатура"
// Региональный этап Всероссийской олимпиады по информатике
// Автор задачи: Федор Царев, tsarev@rain.ifmo.ru
// Автор решения: Маским Носенко, nosenkomax@gmail.com
import java.util.*;
import java.io.*;

public class keyboard_mn implements Runnable {

	public static void main(String args[]) {
		new Thread(new keyboard_mn()).start();
	}

	BufferedReader br;
	StringTokenizer st;
	PrintWriter out;
	private String FNAME = "keyboard";
	boolean eof = false;

	@Override
	public void run() {
		try {
			Locale.setDefault(Locale.US);
			br = new BufferedReader(new FileReader(FNAME + ".in"));
			out = new PrintWriter(FNAME + ".out");
			solve();
			br.close();
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
			System.exit(566);
		}
	}

	String nextToken() {
		while (st == null || !st.hasMoreTokens()) {
			try {
				st = new StringTokenizer(br.readLine());
			} catch (IOException e) {
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
	
	void My_Assert(boolean b, String s) {
		if (!b) 
			throw new Error("Assertion " + s);
	}

	private void solve() {
		int n = nextInt();
		My_Assert(1 <= n && n <= 100, "n out of range: " + n);
		int[] c = new int[n];
		for (int i = 0; i < n; i++) {
			c[i] = nextInt();
			My_Assert(1 <= c[i] && c[i] <= 100000, "c[" + (i + 1) + "] out of range: " + c[i]);
		}
		int k =nextInt();
		My_Assert(1 <= k && k <= 100000, "k out of range: " + k);
		
		int[] cnt = new int[n];
		Arrays.fill(cnt, 0);
		for (int i = 0; i < k; i++) {
			int t = nextInt();
			My_Assert(1 <= t && t <= n, "p[" + (i + 1) + "] out of range: " + t);
			cnt[t - 1]++;
		}
		
		for (int i = 0; i < n; i++)
			if (cnt[i] <= c[i])
				out.println("no");
			else
				out.println("yes");
		
	}
}