import static java.lang.Math.abs;
import static java.lang.Math.max;
import static java.lang.Math.min;

import java.io.*;
import java.util.Arrays;
import java.util.Scanner;

public class kitten_nn {
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

	static int solve(int n, int m, int x1, int y1, int x3, int y3, int x2,
			int y2) {
		boolean mon1 = isMonotonic(x1, x2, x3);
		boolean mon2 = isMonotonic(y1, y2, y3);
		if (mon1 && mon2) {
			return (int) ((long) getCountSimplePaths(abs(x1 - x2), abs(y1 - y2))
					* getCountSimplePaths(abs(x2 - x3), abs(y2 - y3)) % MOD);
		}
		if (x1 == x2 && x2 == x3) {
			long ans = abs(y1 - y3);
			if (x1 > 1 && x1 < n) {
				ans *= 2;
			}
			return (int) (ans % MOD);
		}
		if (y1 == y2 && y2 == y3) {
			long ans = abs(x1 - x3);
			if (y1 > 1 && y1 < m) {
				ans *= 2;
			}
			return (int) (ans % MOD);
		}
		if (mon1) {
			long way1 = getCountSimplePaths(abs(x2 - x3), abs(y2 - y3));
			long way2 = getCountSimplePaths(abs(x2 - x3) - 1, abs(y2 - y3));
			long way3 = getCountSimplePaths(abs(x1 - x2) - 1, abs(y1 - y2));
			long way4 = getCountSimplePaths(abs(x1 - x2), abs(y1 - y2) - 1);
			long answer = way3 * way1 + way2 * way4;
			return (int) (answer % MOD);
		}
		if (mon2) {
			long way1 = getCountSimplePaths(abs(x2 - x3), abs(y2 - y3) - 1);
			long way2 = getCountSimplePaths(abs(x2 - x3), abs(y2 - y3));
			long way3 = getCountSimplePaths(abs(x1 - x2) - 1, abs(y1 - y2));
			long way4 = getCountSimplePaths(abs(x1 - x2), abs(y1 - y2) - 1);
			long answer = way3 * way1 + way2 * way4;
			return (int) (answer % MOD);
		}
		if (isStrictlyMonotonic(x1, x3, x2) && isStrictlyMonotonic(y1, y3, y2)
				|| isStrictlyMonotonic(x3, x1, x2)
				&& isStrictlyMonotonic(y3, y1, y2)) {
			int answer = (getLastWay1(n, m, x1, y1, x2, y2, x3, y3) + getLastWay1(
					m, n, y1, x1, y2, x2, y3, x3)) % MOD;
			return answer;
		}

		if (isMonotonic(x1, x3, x2) && isMonotonic(y1, y3, y2)
				|| isMonotonic(x3, x1, x2) && isMonotonic(y3, y1, y2)) {
			int answer = (getLastWay1(n, m, x1, y1, x2, y2, x3, y3) + getLastWay1(
					m, n, y1, x1, y2, x2, y3, x3)) % MOD;
			return answer;
		}
		return getLastWay2(n, m, x1, y1, x2, y2, x3, y3);
	}

	private static boolean isMonotonic(int x1, int x2, int x3) {
		return x1 <= x2 && x2 <= x3 || x1 >= x2 && x2 >= x3;
	}

	private static boolean isStrictlyMonotonic(int x1, int x2, int x3) {
		return x1 < x2 && x2 < x3 || x1 > x2 && x2 > x3;
	}

	static int getLastWay1(int n, int m, int x1, int y1, int x2, int y2,
			int x3, int y3) {
		int passX = min(abs(x2 - x3), abs(x2 - x1));
		int passY = min(abs(y2 - y3), abs(y2 - y1));
		int longX = max(abs(x2 - x3), abs(x2 - x1));
		int longY = max(abs(y2 - y3), abs(y2 - y1));
		int[][] dp = new int[passY + 1][passY + 1];
		for (int i = 1; i <= passY; i++) {
			dp[0][i] = 1;
		}
		for (int it = 0; it < passX; it++) {
			int[][] next = new int[passY + 1][passY + 1];
			for (int i = 1; i <= passY; i++) {
				for (int j = 0; j <= passY; j++) {
					dp[i][j] += dp[i - 1][j];
					if (dp[i][j] >= MOD) {
						dp[i][j] -= MOD;
					}
				}
			}
			for (int i = 0; i <= passY; i++) {
				for (int j = 1; j <= passY; j++) {
					dp[i][j] += dp[i][j - 1];
					if (dp[i][j] >= MOD) {
						dp[i][j] -= MOD;
					}
				}
			}
			for (int i = 0; i <= passY; i++) {
				for (int j = i + 1; j <= passY; j++) {
					int sum = getSum(dp, 0, i + 1, i, j);
					next[i][j] = sum;
				}
			}
			dp = next;
		}
		int ret = 0;
		for (int i = 0; i < passY; i++) {
			long way1 = dp[i][passY];
			long way2 = getCountSimplePaths(longX - passX - 1, longY - i);
			ret += way1 * way2 % MOD;
			ret %= MOD;
		}
		return ret;
	}

	static int getLastWay2(int n, int m, int x1, int y1, int x2, int y2,
			int x3, int y3) {
		int passX = min(abs(x2 - x3), abs(x2 - x1));
		int passY = min(abs(y2 - y3), abs(y2 - y1));
		int longX = max(abs(x2 - x3), abs(x2 - x1));
		int longY = max(abs(y2 - y3), abs(y2 - y1));
		int[][] dp = new int[passY + 1][passY + 1];
		for (int i = 1; i <= passY; i++) {
			dp[0][i] = 1;
		}
		int ret = 0;
		ret = (int) ((long) getCountSimplePaths(longX - 1, passY)
				* getCountSimplePaths(passX, longY - passY - 1) % MOD);
		for (int it = 0; it < passX; it++) {
			int[][] next = new int[passY + 1][passY + 1];
			for (int i = 1; i <= passY; i++) {
				for (int j = 0; j <= passY; j++) {
					dp[i][j] += dp[i - 1][j];
					if (dp[i][j] >= MOD) {
						dp[i][j] -= MOD;
					}
				}
			}
			for (int i = 0; i <= passY; i++) {
				for (int j = 1; j <= passY; j++) {
					dp[i][j] += dp[i][j - 1];
					if (dp[i][j] >= MOD) {
						dp[i][j] -= MOD;
					}
				}
			}
			for (int i = 0; i < passY; i++) {
				long sum = getSum(dp, 0, i + 1, i, passY);
				long way1 = getCountSimplePaths(longX - it - 2, passY - i);
				long way2 = getCountSimplePaths(passX - it - 1, longY - passY
						- 1);
				ret += sum * way1 % MOD * way2 % MOD;
				if (ret >= MOD) {
					ret -= MOD;
				}
			}
			for (int i = 0; i <= passY; i++) {
				for (int j = i + 1; j <= passY; j++) {
					int sum = getSum(dp, 0, i + 1, i, j);
					next[i][j] = sum;
				}
			}
			dp = next;
		}
		return ret;
	}

	static int getSum(int[][] dp, int x1, int y1, int x2, int y2) {
		if (x1 > x2 || y1 > y2) {
			return 0;
		}
		int ret = dp[x2][y2];
		if (x1 > 0) {
			ret -= dp[x1 - 1][y2];
			if (ret < 0) {
				ret += MOD;
			}
		}
		if (y1 > 0) {
			ret -= dp[x2][y1 - 1];
			if (ret < 0) {
				ret += MOD;
			}
		}
		if (x1 > 0 && y1 > 0) {
			ret += dp[x1 - 1][y1 - 1];
			if (ret >= MOD) {
				ret -= MOD;
			}
		}
		return ret;
	}

	static int getCountSimplePaths(int n, int m) {
		if (n < 0 || m < 0) {
			return 0;
		}
		return C[n + m][n];
	}

}
