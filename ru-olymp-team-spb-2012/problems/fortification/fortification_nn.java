import java.io.*;

/**
 * Main correct solution. Pretty fast non-recursive DFS implementation.
 * 
 * @author niyaz.nigmatullin
 * 
 */
public class fortification_nn {

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

	static int solve(int n, int[] from, int[] to) {
		int[] deg = new int[n];
		for (int i = 0; i < from.length; i++) {
			deg[from[i]]++;
			deg[to[i]]++;
		}
		int[][] edges = new int[n][];
		for (int i = 0; i < n; i++) {
			edges[i] = new int[deg[i]];
		}
		for (int i = 0; i < from.length; i++) {
			edges[from[i]][--deg[from[i]]] = to[i];
			edges[to[i]][--deg[to[i]]] = from[i];
		}
		int[] stack = new int[n];
		boolean[] was = new boolean[n];
		int answer = 1;
		for (int start = 0; start < n; start++) {
			if (was[start]) {
				continue;
			}
			int countVertices = 0;
			int countEdges = 0;
			stack[0] = start;
			was[start] = true;
			int tail = 1;
			while (tail > 0) {
				int v = stack[--tail];
				++countVertices;
				for (int i : edges[v]) {
					++countEdges;
					if (was[i]) {
						continue;
					}
					was[i] = true;
					stack[tail++] = i;
				}
			}
			countEdges >>= 1;
			if (countVertices == countEdges) {
				answer = (int) ((long) answer * countVertices % MOD);
			}
		}
		return answer;
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
