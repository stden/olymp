import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

public class TestGen {
	static Random rand = new Random(1);
	Test tests[] = {

	new Test("n = 3, все числа различны, ответ 0", 1000, 100, 15),
			new Test("n = 3, все числа различны, ответ 1", 115, 115, 90),
			new Test("n = 3, все числа различны, ответ 2", 852, 105, 55),
			new Test("n = 3, все числа различны, ответ 3", 725, 25, 103),
			new Test("n = 5, все числа различны, ответ 4", 625, 933, 175, 17, 241),

	};

	public void run() throws IOException {
		comments = new PrintWriter("tests.lst");
		for (Test t : tests) {
			write(t);
		}
		write(genRand(10, 0.3,5));
		write(genRand(100 - rand.nextInt(50), 0.99, 25));
		write(genRand(100 - rand.nextInt(50), 0.5, 50));
		write(genMax(100, 1, 0, true, 900, false, 6));
		write(genMax(100, 1, 0.01, true, 500, false, 7));
		write(genRand(100000 - rand.nextInt(50000), 0.99, 7));
		write(genRand(100000 - rand.nextInt(50000), 0.5, 1));
		write(genRand(100000, 0.9, 1));
		write(genRand(100000, 0.2, 1));
		write(genMax(100000, 1, 0, true, 900, false, 6));
		write(genMax(100000, 1, 0.01, true, 500, false, 7));
		write(genMax(100000, 13, 0.1, false, 250, false, 8));
		write(genMax(100000, 3, 0.1, true, 550, false, 9));
		write(genMax(100000, 1013, 0.09, false, 750, true, 1));
		write(genLast(100000));

		comments.close();
	}

	class Test {
		int[] a;
		String comment;

		public Test(String comment, int... a) {
			super();
			this.comment = comment;
			this.a = a;
		}

	}

	private int testCount = 0;
	PrintWriter comments;

	private void write(Test t) {
		try {
			++testCount;
			System.err.println(testCount);
			comments.println(t.comment);
			String filename = testCount / 10 + "" + testCount % 10;
			PrintWriter out = new PrintWriter(filename);
			out.println(t.a.length);
			for (int i = 0; i < t.a.length; i++) {
				if (i != 0) {
					out.print(" ");
				}
				out.print(t.a[i]);

			}
			out.println();
			out.flush();
			out.close();
		} catch (IOException ex) {
			throw new RuntimeException(ex);
		}
	}

	void myAssert(boolean b) {
		if (!b)
			throw new AssertionError();
	}

	Test genRand(int n, double endWithFive, int minSolve) {
		while (true) {
			int[] a = new int[n];
			for (int i = 0; i < a.length; i++) {
				if (rand.nextDouble() < endWithFive) {
					a[i] = rand.nextInt(100) * 10 + 5;
				} else {
					do {
						a[i] = rand.nextInt(1000) + 1;
					} while (a[i] % 10 == 5);
				}
			}
			int solve = solve(a);
			if (solve < minSolve) {
				continue;
			}
			return new Test("n = " + n + ", числа случайные, ответ " + solve, a);
		}
	}

	Test genMax(int n, int maximums, double errors, boolean lastFive, int minAns, boolean maxMod10equal5, int minSolve) {
		while (true) {
			int[] a = new int[n];
			int max;
			do {
				max = 1000 - (int) (Math.abs(rand.nextGaussian()) * 100);
			} while ((max % 10 == 5) ^ maxMod10equal5);
			int prev = rand.nextInt(minAns / 10 - 1) * 10 + 15;
			for (int i = 0; i < a.length; i++) {
				if (rand.nextDouble() < errors) {
					do {
						a[i] = rand.nextInt(max) + 1;
					} while (a[i] % 10 == 5);
				} else {
					a[i] = rand.nextInt(prev / 10) * 10 + 5;
					prev = a[i];
					while (prev < 10 || (prev < 100 && rand.nextInt(3) == 0)) {
						prev = rand.nextInt(minAns / 10) * 10 + 5;
					}
				}

			}
			for (int i = 0; i < maximums; i++) {
				int maxpos = n / 2 + rand.nextInt(n / 2);
				a[maxpos] = max;
			}
			if (lastFive) {
				do {
					a[n - 1] = rand.nextInt(max - 1) + 1;
				} while (a[n - 1] % 10 != 5);
			} else {
				do {
					a[n - 1] = rand.nextInt(max - 1) + 1;
				} while (a[n - 1] % 10 == 5);
			}
			int solve = solve(a);
			if (solve < minSolve)
				continue;
			return new Test("n = " + n + ", максимальный тест, ответ " + solve, a);
		}
	}

	Test genLast(int n) {
		int[] a = new int[n];
		for (int i = 0; i < a.length; i++) {
			a[i] = rand.nextInt(995) + 6;
		}
		boolean any = true;
		while (any) {
			any = false;
			for (int i = 0; i < a.length; i++) {
				if (a[i] % 10 == 5 && i + 1 < a.length && a[i + 1] < a[i]) {
					any = true;
					a[i] = rand.nextInt(995) + 6;
				}
			}
		}
		int mini = 0;
		for (int i = 0; i < a.length; i++) {
			if (a[i] <= a[mini]) {
				mini = i;
			}
		}
		a[mini] = 5;
		a[mini + 1] = rand.nextInt(4) + 1;
		return new Test("n = " + n + ", специальный тест, ответ " + solve(a), a);

	}

	int solve(int[] a) {

		int win = 0;
		for (int i = 0; i < a.length; i++) {
			if (a[i] > a[win]) {
				win = i;
			}
		}
		int max = 0;
		for (int i = win + 1; i < a.length - 1; i++) {
			if (a[i] % 10 == 5 && a[i] > a[i + 1]) {
				max = Math.max(max, a[i]);
			}
		}
		if (max == 0) {
			return 0;
		}
		int pos = 0;
		for (int i = 0; i < a.length; i++) {
			if (a[i] > max) {
				pos++;
			}
		}
		return pos + 1;
	}

	public static void main(String[] args) throws IOException {
		new TestGen().run();
	}

}
