import static java.util.Arrays.fill;

import java.io.*;
import java.util.*;

/**
 * 
 * 
 * @author niyaz.nigmatullin
 * 
 */
public class billboard_nn_n2m2k {
	static final String PROBLEM_ID;
	static {
		String s = new Throwable().getStackTrace()[0].getClassName();
		PROBLEM_ID = s.substring(0, s.indexOf('_'));
	}

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(PROBLEM_ID
				+ ".in"));
		PrintWriter out = new PrintWriter(PROBLEM_ID + ".out");
		String[] z = br.readLine().split(" ");
		int k = Integer.parseInt(z[0]);
		int n = Integer.parseInt(z[1]);
		int m = Integer.parseInt(z[2]);
		char[][][] c = new char[k][n][];
		for (int i = 0; i < k; i++) {
			for (int j = 0; j < n; j++) {
				c[i][j] = br.readLine().toCharArray();
			}
		}
		out.println(solve(k, n, m, c));
		out.close();
		br.close();
	}

	static int solve(int k, int n, int m, char[][][] c) {
		List<int[]>[] f = new List[k + 1];
		for (int i = 0; i < k + 1; i++) {
			f[i] = new ArrayList<int[]>();
		}
		int answer = 0;
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				int cnt = 0;
				for (int e = 0; e < k; e++) {
					if (c[e][i][j] == '*') {
						++cnt;
					}
				}
				int[] z = new int[cnt];
				cnt = 0;
				for (int e = 0; e < k; e++) {
					if (c[e][i][j] == '*') {
						z[cnt++] = e;
					}
				}
				boolean ok = true;
				for (int[] d : f[cnt]) {
					if (Arrays.equals(d, z)) {
						ok = false;
						break;
					}
				}
				if (ok) {
					f[cnt].add(z);
					++answer;
				}
			}
		}
		return (answer);
	}
}
