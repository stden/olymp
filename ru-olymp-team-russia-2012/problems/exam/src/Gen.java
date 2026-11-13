import java.io.PrintWriter;
import java.io.File;
import java.util.Random;
import java.util.ArrayList;

class Gen {
	public static void main(String[] args) throws Exception {
		new Gen().run();
	}
	
	int curTest;
	Random rnd = new Random(1729);
	final String testsDir = "../tests/";
	final int boundsGroups = 4;
	final int[] boundsN = {10, 1000, 10000, 	 100000};
	final int[] boundsX = {10, 1000, 1000000000, 1000000000};
	final int maxN = boundsN[boundsGroups - 1];
	final int maxX = boundsX[boundsGroups - 1];
		
	public void run() throws Exception {
		curTest = 0;
		new File(testsDir).mkdir();
		genHandTests();
		genSpecialTests();
		genAllSmallTests();
		genMonotonicTests();
		genFewValues();
		genSawTests();
		genHollowTests();
		genRandomTests();
	}

	void outputMultiTest(int[][] testsArray) throws Exception {
		ArrayList<Test> tests = new ArrayList<Test>();
		for (int[] test: testsArray)
			tests.add(new Test(test));
		outputMultiTest(tests);
	}

	void genHandTests() throws Exception {
		int[][] testsArray = {{3, 2, 0, 1}, {1, 5, 1}};
		outputMultiTest(testsArray);
	}

	void genAllCases(int base, int length) throws Exception {
		ArrayList<Test> tests = new ArrayList<Test>();
		for (int num = 0; num < (int) Math.pow(base, length); ++num) {
			int[] test = new int[length];
			int value = num;
			for (int i = 0; i < length; ++i) {
				test[i] = value % base;
				value /= base;
			}
			tests.add(new Test(test));
		}
		outputMultiTest(tests);
	}

	void genAllSmallTests() throws Exception {
		genAllCases(10, 4);
		genAllCases(5, 5);
		genAllCases(2, 12);
	}

	void genSpecialTests() throws Exception {
		int[][] testsArray = {{3, 2, 0, 1}, {1, 5, 1}};
		outputMultiTest(testsArray);
	}

	Test genEqual(int n, int x) {
		int[] test = new int[n];
		int value = rnd.nextInt(x + 1);
		for (int i = 0; i < n; ++i)
			test[i] = value;
		return new Test(test);
	}

	Test genIncreasing(int n, int x) {
		int[] test = new int[n];
		int sum = 0;
		for (int i = 0; i < n; ++i) {
			int tmp = rnd.nextInt(x / (n - i) + 1);
			sum += tmp;
			test[i] = sum;
			x -= tmp;
		}
		return new Test(test);
	}

	int[] arrayReverse(int[] a) {
		int n = a.length;
		for (int i = 0; i < n - i - 1; ++i) {
			int tmp = a[i];
			a[i] = a[n - i - 1];
			a[n - i - 1] = tmp;
		}
		return a;
	}

	Test genDecreasing(int n, int x) {
		Test t = genIncreasing(n, x);
		t.test = arrayReverse(t.test);
		return t;
	}

	void genMonotonicTests() throws Exception {
		ArrayList<Test> tests = new ArrayList<Test>();
		for (int i = 0; i < boundsGroups - 1; ++i) {
			tests.add(genEqual(boundsN[i], boundsX[i]));
			tests.add(genIncreasing(boundsN[i], boundsX[i])); 
			tests.add(genDecreasing(boundsN[i], boundsX[i]));
		}
		outputMultiTest(tests);
	}

	void genSawTests() throws Exception {
		ArrayList<Test> tests = new ArrayList<Test>();
		for (int i = 0; i < boundsGroups - 1; ++i)
			for (int odd = 0; odd < 2; ++odd)
				tests.add(genSawTest(odd, boundsN[i], boundsX[i]));
		outputMultiTest(tests);
	}

	Test genSawTest(int odd, int n, int inf) {
		int[] test = new int[n];
		for (int i = 0; i < n; ++i)
			test[i] = (i % 2 == odd) ? inf : 0;
		return new Test(test);
	}

	void genFewValues() throws Exception {
		int[] valuesCnt = {5, 100};
		for (int cnt: valuesCnt) {
			Test t = genRandomTest(maxN, cnt);
			for (int i = 0; i < t.test.length; ++i)
				t.test[i] *= maxX / cnt;
			outputMultiTest(t);
		}
	}

	void genHollowTests() throws Exception {
		int n = maxN, inf = maxX;
		int[] hollowsCnt = {1, 2, (int) Math.pow(n, 1.0 / 3.0), (int) Math.pow(n, 1.0 / 2.0), (int) Math.pow(n, 2.0 / 3.0)};
		for (int h: hollowsCnt)
			outputMultiTest(genHollowTest(h, n, inf));
	}

	int[] genOneHollow(int n) {
		if (n >= 10)
			n -= rnd.nextInt(n / 10);
		int[] a = genDecreasing(n / 2, maxX).test;
		int[] b = genIncreasing(n / 2, maxX).test;
		int[] result = new int[a.length + b.length];
		int pos = 0;
		for (int i = 0; i < a.length; ++i)
			result[pos++] = a[i];
		for (int i = 0; i < b.length; ++i)
			result[pos++] = b[i];
		return result;
	}

	Test genHollowTest(int h, int n, int inf) {
		int[] test = new int[n];
		int pos = 0;
		for (int i = 0; i < h; ++i) {
			int[] tmp = genOneHollow(n / h);
			for (int j = 0; j < tmp.length; ++j)
				test[pos++] = tmp[j];
		}
		return new Test(test);
	}

	void genRandomTests() throws Exception {
		int n = maxN, inf = maxX;
		int[] testsCnt = {1, (int) Math.pow(n, 1.0 / 3.0), (int) Math.pow(n, 1.0 / 2.0), (int) Math.pow(n, 2.0 / 3.0), n};
		for (int t: testsCnt)
			genRandomMultiTest(t, n, inf); 
	}
	
	void genRandomMultiTest(int t, int n, int inf) throws Exception {
		ArrayList<Test> tests = new ArrayList<Test>();
		for (int i = 0; i < t; ++i)
			tests.add(genRandomTest(n / t, inf));
		outputMultiTest(tests);
	}

	Test genRandomTest(int n, int inf) {
		if (n >= 10)
			n -= rnd.nextInt(n / 10);
		int[] test = new int[n];
		for (int i = 0; i < n; ++i)
			test[i] = rnd.nextInt(inf + 1);
		return new Test(test);
	}

	void outputMultiTest(Test t) throws Exception {
		ArrayList<Test> tests = new ArrayList<Test>();
		tests.add(t);
		outputMultiTest(tests);
	}

	void outputMultiTest(ArrayList<Test> tests) throws Exception {
		curTest++;
		System.out.print("Test " + curTest + "... ");
		String fileName = testsDir + ((curTest < 10) ? "0" : "") + curTest;
		PrintWriter out = new PrintWriter(new File(fileName));
		int sum = 0;
		out.println(tests.size());
		for (Test test: tests) {
			test.output(out);
			sum += test.test.length;
		}
		check(sum <= maxN, "sum is too large!");
		out.close();
		System.out.println("ok (" + tests.size() + " tests)");
	}

	class Test {
		int[] test;
		void output(PrintWriter out) {
			check(test.length >= 1, "test is empty");
			out.println(test.length);
			for (int i = 0; i < test.length; ++i) {
				check((0 <= test[i]) && (test[i] <= maxX), "x is out of bounds");
				out.print(test[i]);
				if (i != test.length - 1)
					out.print(' ');
			}
			out.println();	
		}
		Test(int[] test) {
			this.test = test;
		}
	}

	void check(boolean t, String msg) {
		if (!t) {
			System.err.println(msg);
			throw new RuntimeException(msg);
		}
	}
}