import static java.lang.System.currentTimeMillis;

import java.io.*;
import java.util.*;

/**
 * 
 * @author niyaz.nigmatullin
 * 
 */
public class billboard_nn_n2km2 {
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
		List<boolean[]> f = new ArrayList<boolean[]>();
		int answer = 0;
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				boolean[] z = new boolean[k];
				for (int e = 0; e < k; e++) {
					z[e] = (c[e][i][j] == '*');
				}
				boolean ok = true;
				for (boolean[] d : f) {
					if (Arrays.equals(d, z)) {
						ok = false;
						break;
					}
				}
				if (ok) {
					f.add(z);
					++answer;
				}
			}
		}
		return (answer);
	}
}
