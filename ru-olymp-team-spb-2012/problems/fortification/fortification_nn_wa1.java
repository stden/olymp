import static java.lang.Math.abs;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Incorrect pseudo-topsort.
 * 
 * @author niyaz.nigmatullin
 *
 */
public class fortification_nn_wa1 {

	static final int MOD = 1000000007;
	static final String PROBLEM_ID;
	static {
		String s = new Throwable().getStackTrace()[0].getClassName();
		PROBLEM_ID = s.substring(0, s.indexOf('_'));
	}

	static int nextInt(BufferedReader br) throws IOException {
		int c = br.read();
		while (c <= 32) {
			c = br.read();
		}
		int ret = 0;
		while (c >= '0' && c <= '9') {
			ret = ret * 10 + c - '0';
			c = br.read();
		}
		return ret;
	}

	static List<Integer>[] edges;
	static boolean[] was;

	static int[] time;
	static int curTime;

	static int solve(int n, int[] from, int[] to) {
		edges = new List[n];
		for (int i = 0; i < n; i++) {
			edges[i] = new ArrayList<Integer>();
		}
		for (int i = 0; i < from.length; i++) {
			edges[from[i]].add(to[i]);
			edges[to[i]].add(from[i]);
		}
		was = new boolean[n];
		time = new int[n];
		curTime = n;
		for (int i = 0; i < n; i++) {
			if (was[i]) {
				continue;
			}
			dfs(i);
		}
		int answer = 1;
		for (int i = 0; i < from.length; i++) {
			int difTime = abs(time[from[i]] - time[to[i]]);
			if (difTime > 1) {
				answer = (int) ((long) answer * (difTime + 1) % MOD);
			}
		}
		return answer;
	}

	static void dfs(int v) {
		was[v] = true;
		for (int i : edges[v]) {
			if (!was[i]) {
				dfs(i);
			}
		}
		time[v] = --curTime;
	}

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(PROBLEM_ID
				+ ".in"));
		int n = nextInt(br);
		int m = nextInt(br);
		int[] from = new int[m];
		int[] to = new int[m];
		for (int i = 0; i < m; i++) {
			from[i] = nextInt(br) - 1;
			to[i] = nextInt(br) - 1;
		}
		PrintWriter out = new PrintWriter(PROBLEM_ID + ".out");
		out.println(solve(n, from, to));
		out.close();
	}
}
