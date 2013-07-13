import static java.util.Arrays.fill;

import java.io.*;

/**
 * Solution for problem billboard.
 * 
 * Iterate over all letters and do the partition on equivalence classes in
 * linear time, since every class can partition to two.
 * 
 * @author niyaz.nigmatullin
 * 
 */
public class billboard_nn {
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
		int[][] curClass = new int[n][m];
		int allClasses = 1;
		for (char[][] d : c) {
			int[][] next = new int[n][m];
			int[] used = new int[allClasses];
			int[] newOne = new int[allClasses];
			fill(used, -1);
			fill(newOne, -1);
			int newClasses = allClasses;
			for (int i = 0; i < n; i++) {
				for (int j = 0; j < m; j++) {
					int cl = curClass[i][j];
					int on = d[i][j] == '*' ? 1 : 0;
					if (used[cl] < 0 || used[cl] == on) {
						used[cl] = on;
						next[i][j] = cl;
					} else {
						if (newOne[cl] < 0) {
							newOne[cl] = newClasses++;
						}
						next[i][j] = newOne[cl];
					}
				}
			}
			curClass = next;
			allClasses = newClasses;
		}
		return allClasses;
	}
}
