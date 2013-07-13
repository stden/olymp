import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Correct recursive DFS implementation.
 * 
 * @author niyaz.nigmatullin
 *
 */
public class fortification_nn_rec {

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
	static int countEdges;

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
		int answer = 1;
		for (int i = 0; i < n; i++) {
			if (was[i]) {
				continue;
			}
			countEdges = 0;
			int countVertices = dfs(i);
			countEdges >>= 1;
			if (countVertices == countEdges) {
				answer = (int) ((long) answer * countVertices % MOD);
			}
		}
		return answer;
	}

	static int dfs(int v) {
		was[v] = true;
		int ret = 1;
		for (int i : edges[v]) {
			countEdges++;
			if (!was[i]) {
				ret += dfs(i);
			}
		}
		return ret;
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
