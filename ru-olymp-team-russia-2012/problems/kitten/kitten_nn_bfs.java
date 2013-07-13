import static java.lang.Math.abs;
import static java.lang.Math.min;

import java.io.*;
import java.util.*;

public class kitten_nn_bfs {
	static final String PROBLEM_ID;
	static {
		String s = new Throwable().getStackTrace()[0].getClassName();
		PROBLEM_ID = s.substring(0, s.indexOf('_'));
	}

	public static void main(String[] args) throws IOException {
		Scanner sc = new Scanner(new File(PROBLEM_ID + ".in"));
		PrintWriter out = new PrintWriter(PROBLEM_ID + ".out");
		int n = sc.nextInt();
		int m = sc.nextInt();
		int xStart = sc.nextInt();
		int yStart = sc.nextInt();
		int xMiddle = sc.nextInt();
		int yMiddle = sc.nextInt();
		int xFinish = sc.nextInt();
		int yFinish = sc.nextInt();
		out.println(solve(n, m, xStart, yStart, xFinish, yFinish, xMiddle,
				yMiddle));
		out.close();
		sc.close();
	}

	static final int MOD = 1000000007;

	static int solve(int n, int m, int x1, int y1, int x3, int y3, int x2,
			int y2) {
		if (x1 == x2 && x2 == x3) {
			if (y1 <= y2 && y2 <= y3 || y1 >= y2 && y2 >= y3) {
				return 1;
			}
			long ans = abs(y1 - y3);
			if (x1 > 1 && x1 < n) {
				ans *= 2;
			}
			return (int) (ans % MOD);
		}
		if (y1 == y2 && y2 == y3) {
			if (x1 <= x2 && x2 <= x3 || x1 >= x2 && x2 >= x3) {
				return 1;
			}
			long ans = abs(x1 - x3);
			if (y1 > 1 && y1 < m) {
				ans *= 2;
			}
			return (int) (ans % MOD);
		}
		State.init(n, m, x1, y1, x2, y2, x3, y3);
		int all = min(dist(x1, y1, x2, y2), dist(x3, y3, x2, y2));
		int[][][] ways = new int[all + 1][all + 1][all + 1];
		boolean[][][] was = new boolean[all + 1][all + 1][all + 1];
		Queue<State> q = new ArrayDeque<State>();
		ways[0][0][0] = 1;
		q.add(new State(0, 0, 0));
		long answer = 0;
		while (!q.isEmpty()) {
			State v = q.poll();
			final int val = ways[v.steps][v.h1][v.h2];
			if (v.steps == all) {
				answer += (long) val * v.getWaysFinish();
				answer %= MOD;
			}
			for (int add1 = 0; add1 < 2; add1++) {
				for (int add2 = 0; add2 < 2; add2++) {
					final int a = v.steps + 1;
					final int b = v.h1 + add1;
					final int c = v.h2 + add2;
					State newState = new State(a, b, c);
					if (!newState.isValid()) {
						continue;
					}
					ways[a][b][c] += val;
					ways[a][b][c] %= MOD;
					if (!was[a][b][c]) {
						q.add(newState);
						was[a][b][c] = true;
					}
				}
			}
		}
		return (int) (answer);
	}

	static final int[][] C;
	static final int MAXN = 200;
	static {
		C = new int[MAXN + 1][MAXN + 1];
		for (int i = 0; i <= MAXN; i++) {
			C[i][0] = 1;
			for (int j = 1; j <= i; j++) {
				C[i][j] = C[i - 1][j - 1] + C[i - 1][j];
				if (C[i][j] >= MOD) {
					C[i][j] -= MOD;
				}
			}
		}
	}

	static class State {
		int steps;
		int h1;
		int h2;

		int a1;
		int b1;
		int a2;
		int b2;

		static int n;
		static int m;
		static int x1;
		static int y1;
		static int x2;
		static int y2;
		static int x3;
		static int y3;

		static int dx1;
		static int dy1;
		static int dx2;
		static int dy2;

		static void init(int n, int m, int x1, int y1, int x2, int y2, int x3,
				int y3) {
			State.n = n;
			State.m = m;
			State.x1 = x1;
			State.y1 = y1;
			State.x2 = x2;
			State.y2 = y2;
			State.x3 = x3;
			State.y3 = y3;
			dx1 = getDir(x1, x2);
			dy1 = getDir(y1, y2);
			dx2 = getDir(x3, x2);
			dy2 = getDir(y3, y2);
		}

		private static int getDir(int x1, int x2) {
			int ret = Integer.signum(x1 - x2);
			return ret == 0 ? 1 : ret;
		}

		int getWaysFinish() {
			return ways(abs(x1 - a1), abs(y1 - b1))
					* ways(abs(x3 - a2), abs(y3 - b2));
		}

		public State(int steps, int h1, int h2) {
			this.steps = steps;
			this.h1 = h1;
			this.h2 = h2;
			a1 = x2 + dx1 * h1;
			b1 = y2 + dy1 * (steps - h1);
			a2 = x2 + dx2 * h2;
			b2 = y2 + dy2 * (steps - h2);
		}

		boolean isValid() {
			if (!isGood(a1, b1, x1, y1) || !isGood(a2, b2, x3, y3)) {
				return false;
			}
			if (a1 == a2 && b1 == b2) {
				return false;
			}
			return true;
		}

		private boolean isGood(int a, int b, int x1, int y1) {
			final int dx = Integer.signum(x1 - x2);
			final int dy = Integer.signum(y1 - y2);
			if (dx != 0 && Integer.signum(a - x1) == dx || dx == 0
					&& Integer.signum(a - x1) != dx) {
				return false;
			}
			if (dy != 0 && Integer.signum(b - y1) == dy || dy == 0
					&& Integer.signum(b - y1) != dy) {
				return false;
			}
			return true;
		}

	}

	static int ways(int a, int b) {
		if (a < 0 || b < 0) {
			return 0;
		}
		return C[a + b][b];
	}

	static int dist(int x1, int y1, int x2, int y2) {
		return abs(x1 - x2) + abs(y1 - y2);
	}

}
