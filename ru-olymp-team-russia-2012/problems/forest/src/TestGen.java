import java.io.*;
import java.util.*;

public class TestGen {

	PrintWriter out;
	Random rnd;
	int tNumber;

	class Test {
		int[][] a;

		void printTest() throws IOException {
			if (tNumber < 10)
				out = new PrintWriter("../tests/0" + tNumber);
			else
				out = new PrintWriter("../tests/" + tNumber);
			tNumber++;
			out.println(a.length + " " + a[0].length);

			for (int i = 0; i < a.length; i++) {
				for (int j = 0; j < a[i].length; j++) {
					if (a[i][j] == 0)
						a[i][j] = 100;
					out.print(a[i][j]);
					if (j < a[i].length - 1)
						out.print(' ');
				}
				out.println();
			}
			out.close();
		}

		private void screwKPoints(int n, int m, int k) {
			for (int i = 0; i < k; i++) {
				int t = rnd.nextInt(98) + 1;

				int x = rnd.nextInt(n - 2) + 1;
				int y = rnd.nextInt(m - 2) + 1;
				a[x][y] = t;
				a[x - 1][y] = t + 2;
				a[x + 1][y] = t + 2;
				a[x][y - 1] = t + 2;
				a[x][y + 1] = t + 2;
			}

		}

		void genSample() throws IOException {
			a = new int[3][4];
			for (int i = 0; i < 3; i++) {
				Arrays.fill(a[i], 1);
			}
			a[2][0] = 3;
			a[0][3] = 2;
			a[1][1] = 5;
			a[1][2] = 5;
			printTest();
		}

		void genRandom(int n, int m, int maxK) throws IOException {
			a = new int[n][m];
			for (int i = 0; i < n; i++) {
				for (int j = 0; j < m; j++) {
					a[i][j] = rnd.nextInt(maxK) + 1;
				}
			}
			printTest();
		}

		private void genOneStepOfSimpleSpiral(int sx, int fx, int sy, int fy) {
			if (sx >= fx)
				return;
			if (sy >= fy)
				return;
			for (int i = sx; i < fx; i++) {
				a[i][sy] = 1;
				a[i][fy - 1] = 1;
			}
			for (int i = sy; i < fy; i++) {
				a[sx][i] = 1;
				a[fx - 1][i] = 1;
			}
			if (sx >= fx - 4 || sy >= fy - 4) {
				return;
			}
			a[sx][sy + 1] = 0;

			a[sx + 1][sy + 2] = 1;
			genOneStepOfSimpleSpiral(sx + 2, fx - 2, sy + 2, fy - 2);
		}

		private void setLabels(int n, int m, int maxK) {
			Queue<Integer> q = new ArrayDeque<Integer>();

			for (int i = 0; i < n; i++) {
				for (int j = 0; j < m; j++) {
					int cnt = 0;
					if (i > 0)
						cnt += a[i - 1][j];
					if (i < n - 1)
						cnt += a[i + 1][j];
					if (j > 0)
						cnt += a[i][j - 1];
					if (j < m - 1)
						cnt += a[i][j + 1];
					if (cnt == 1)
						q.add(i * m + j);
				}
			}

			if (rnd.nextBoolean()) {
				q.add(q.poll());
			}

			while (maxK > 1) {
				int t = q.poll();
				int i = t / m;
				int j = t % m;
				a[i][j] = maxK;
				maxK--;
				if (i > 0 && a[i - 1][j] == 1)
					q.add((i - 1) * m + j);
				if (i < n - 1 && a[i + 1][j] == 1)
					q.add((i + 1) * m + j);
				if (j > 0 && a[i][j - 1] == 1)
					q.add((i) * m + j - 1);
				if (j < m - 1 && a[i][j + 1] == 1)
					q.add((i) * m + j + 1);
			}
		}

		public void genSimpleSpiral(int n, int m, int k) throws IOException {
			a = new int[n][m];

			genOneStepOfSimpleSpiral(0, n, 0, m);
			setLabels(n, m, k);
			printTest();
		}

		private void init() {
			for (int i = 0; i < a.length; i++)
				Arrays.fill(a[i], 1);
		}

		public void genStrangeZigzag(int n, int m, int k, int l, boolean b)
				throws IOException {
			int s = 0;
			if (rnd.nextBoolean())
				s = m - 1;
			a = new int[n][m];
			if (b)
				init();
			System.err.println(l);
			for (int i = 0; i < n; i++) {
				for (int j = 0; j < m; j++) {
					if (i % 2 == l % 2) {
						a[i][j] = 1;
					}
					if (i % 4 == (l + 1) % 4) {
						if (i > l && j == m - s - 1 || i < l && j == s) {
							a[i][j] = 1;
						}
					}

					if (i % 4 == (l + 3) % 4) {
						if (i < l && j == m - s - 1 || i > l && j == s) {
							a[i][j] = 1;
						}
					}
				}
			}

			setZigZagLabels(n, m, l, s, k);
			printTest();
		}

		private void setZigZagLabels(int n, int m, int l, int s, int k) {
			if (s == 0) {
				for (int i = 0; i * 2 < k; i++) {
					a[l][i] = k - i * 2;
				}
			} else {
				for (int i = 0; i * 2 < k; i++) {
					a[l][m - i - 1] = k - i * 2;
				}
			}
			k--;

			int t = 0;
			if (l % 2 != t % 2)
				t++;
			if (l != 0) {
				if (a[t + 1][0] == 0) {
					for (int i = 0; 2 * i < k; i++) {
						a[t][i] = k - i * 2;
					}
				} else {
					for (int i = 0; 2 * i < k; i++) {
						a[t][m - i - 1] = k - i * 2;
					}
				}
			}
			t = n - 1;
			if (l % 2 != t % 2)
				t--;
			if (l != t) {
				if (a[t - 1][0] == 0) {
					for (int i = 0; 2 * i < k; i++) {
						a[t][i] = k - i * 2;
					}
				} else {
					for (int i = 0; i * 2 < k; i++) {
						a[t][m - i - 1] = k - i * 2;
					}
				}
			}
			for (int i = 0; i < n; i++) {
				for (int j = 0; j < m; j++) {
					if (a[i][j] < 0)
						a[i][j] = 1;
				}
			}
		}

		public void genTestWithStars(int n, int m, int k) throws IOException {
			a = new int[n][m];
			init();
			for (int t = 0; t < k; t++) {
				int h = rnd.nextInt(10) + 10;
				int x = rnd.nextInt(n - 2 * h) + h;
				int y = rnd.nextInt(m - 2 * h) + h;
				for (int d = 0; h - d > 1; d += 2) {
					int dist = d / 2;
					for (int i = -dist; i < dist + 1; i++) {
						a[x + i][y - (dist - Math.abs(i))] = h - d;
						a[x + i][y + (dist - Math.abs(i))] = h - d;
					}

				}
			}
			if (a.length > 10) {
				int zz = rnd.nextInt(5) + 3;
				screwKPoints(a.length, a[0].length, zz);
			}

			printTest();
		}

		public void genTestWithPoints(int n, int m, int k) throws IOException {
			a = new int[n][m];
			init();
			for (int i = 2; i <= k; i++) {
				while (true) {
					int x = rnd.nextInt(n);
					int y = rnd.nextInt(m);
					if (a[x][y] == 1) {
						a[x][y] = i;
						break;
					}
				}
			}
			if (a.length > 10) {
				int zz = rnd.nextInt(5) + 3;
				screwKPoints(a.length, a[0].length, zz);
			}

			printTest();
		}

		public void genTestWithPointsAtAngles(int n, int m, int k)
				throws IOException {
			a = new int[n][m];
			init();
			for (int i = 2; i <= k; i++) {
				while (true) {
					int x = rnd.nextInt(n / 6);
					int y = rnd.nextInt(m / 6);
					if (i % 2 == 0) {
						x = n - rnd.nextInt(n / 6) - 1;
						y = m - rnd.nextInt(m / 6) - 1;
					}
					// System.err.println(x + " " + y );
					if (a[x][y] == 1) {
						a[x][y] = i;
						break;
					}
				}
			}
			
			if (a.length > 10) {
				int zz = rnd.nextInt(5) + 3;
				screwKPoints(a.length, a[0].length, zz);
			}

			
			printTest();

		}

		public void genDiagonalTest(int n, int m, int k) throws IOException {
			a = new int[n][m];
			init();

			for (int i = 2; i <= k; i++) {
				if (i % 2 == 0) {
					a[i / 2][i / 2] = i;
				} else {
					a[n - i / 2][m - i / 2] = i;
				}
			}
			
			if (a.length > 10) {
				int zz = rnd.nextInt(5) + 3;
				screwKPoints(a.length, a[0].length, zz);
			}
			
			printTest();
		}
	}

	public void solve() throws IOException {
		tNumber = 1;
		rnd = new Random(31);
		Test t = new Test();
		t.genSample();

		t.genRandom(1, 1, 100);
		t.genRandom(3, 2, 3);
		t.genRandom(5, 4, 5);

		t.genRandom(1, 100, 10);
		t.genRandom(100, 1, 10);
		t.genRandom(100, 100, 30);

		t.genSimpleSpiral(9, 9, 10);
		t.genSimpleSpiral(97, 97, 98);

		t.genStrangeZigzag(100, 100, 98, 0, false);
		t.genStrangeZigzag(100, 100, 98, rnd.nextInt(100), false);
		t.genStrangeZigzag(100, 100, 98, 99, false);

		t.genStrangeZigzag(100, 100, 98, 0, true);
		t.genStrangeZigzag(100, 100, 98, rnd.nextInt(100), true);
		t.genStrangeZigzag(100, 100, 98, 99, true);

		t.genTestWithStars(100 - rnd.nextInt(2), 100 - rnd.nextInt(2), 2);
		t.genTestWithStars(100 - rnd.nextInt(2), 100 - rnd.nextInt(2), 5);
		t.genTestWithStars(100 - rnd.nextInt(2), 100 - rnd.nextInt(2), 10);

		t.genTestWithPoints(100 - rnd.nextInt(2), 100 - rnd.nextInt(2), 100);
		t.genTestWithPointsAtAngles(100 - rnd.nextInt(2), 100 - rnd.nextInt(2),
				100);
		t.genDiagonalTest(100 - rnd.nextInt(2), 100 - rnd.nextInt(2), 100);
	}

	public void run() {
		try {

			solve();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new TestGen().run();
	}
}
