import java.io.*;
import java.util.*;

public class TestsGen implements Runnable {
	public static void main(String[] args) {
		if (args.length < 1) {
			for (I = 1; (new File(getName(I) + ".t")).exists(); I++)
				;
		} else {
			I = Integer.parseInt(args[0]);
		}
		new Thread(new TestsGen()).start();
	}

	PrintWriter out;

	Random rand = new Random(64395786L);

	static int I;

	static String getName(int i) {
		return ((i < 10) ? "0" : "") + i;
	}

	void open() {
		try {
			System.out.println("Generating test " + I);
			out = new PrintWriter(getName(I));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	void close() {
		out.close();
		I++;
	}

	String randString(int len, String alpha) {
		StringBuilder ans = new StringBuilder();
		int k = alpha.length();
		for (int i = 0; i < len; i++) {
			ans.append(alpha.charAt(rand.nextInt(k)));
		}
		return ans.toString();
	}

	long rand(long l, long r) {
		return l + (rand.nextLong() >>> 1) % (r - l + 1);
	}
	/*
	 * returns random value in [l, r]
	 */
	int rand(int l, int r) {
		return l + rand.nextInt(r - l + 1);
	}
	

	final int MAXAB = 1000000;
	final int MAX = 100000;
	/*
	 * a_i ? b_i
	 */
	void genRand(int n, int m, int p, int MAXAB, double prob) {
		open();
		out.println(n + " " + m + " " + p);
		for (int i = 0; i < n; i++) {
			int a = rand(-MAXAB, MAXAB);
			int b = rand(-MAXAB, a);
			if (rand.nextDouble() >= prob) {
				b = rand(a, MAXAB);
			}
			int c = rand(1, p - 1);
			int d = rand(c + 1, p);
			out.println(a + " " + b + " " + c + " " + d);
		}
		close();
	}
	
	/*
	 * Maximum difference between a and b 
	 */
	void genMax(int n, int m, int p, int a) {
		open();
		out.println(n + " " + m + " " + p);
		for (int i = 0; i < n; i++) {
			int b = -a;
			int c = rand(1, p - 1);
			int d = rand(c + 1, p);
			out.println(a + " " + b + " " + c + " " + d);
		}
		close();
	}
	
		
	/*
	 * All passengers come in and come out on the same station 
	 */
	void genFlashmob(int n, int m, int p) {
		open();
		out.println(n + " " + m + " " + p);
		int c = rand(1, p - 1);
		int d = rand(c + 1, p);
		for (int i = 0; i < n; i++) {
			int a = rand(-MAXAB, MAXAB);
			int b = rand(-MAXAB, MAXAB);
			out.print(a + " " + b + " " + c + " " + d);
			out.println();
		}
		close();
	}
	
	/*
	 * All passengers come in and come out on the same station
	 * Maximum difference between a and b 
	 */
	void genMaxFlash(int n, int m, int p, int a) {
		open();
		out.println(n + " " + m + " " + p);
		int c = rand(1, p - 1);
		int d = rand(c + 1, p);
		for (int i = 0; i < n; i++) {
			out.println(a + " " + (-a) + " " + c + " " + d);
		}
		close();
	}
	
	
	public void solve() throws IOException {
		// N, M, P <= 100; |a|, |b| < 100, a > b
		genRand(1, 1, 2, 1, 0);
		genRand(1, 1, 2, 1, 1);
		genRand(10, 3, 6, 100, 100);
		for (int i = 0; i < 3; i++) {
			genRand(rand(1, 100), rand(1, 100), rand(2, 100), 100, 0);
		}
		genMax(100, 60, 10, 100);
		for (int i = 0; i < 3; i++) {
			genMax(rand(1, 100), rand(1, 100), rand(2, 100), 100);
		}
		for (int i = 0; i < 3; i++) {
			genFlashmob(rand(1, 100), rand(1, 100), rand(2, 100));
		}
		
		//N, M, P <= 100
		for (int i = 0; i < 5; i++) {
			genRand(rand(1, 100), rand(1, 100), rand(2, 100), MAXAB, rand.nextDouble());
		}
		genMax(100, 100, 10, MAXAB);
		for (int i = 0; i < 3; i++) {
			genMax(rand(1, 100), rand(1, 100), rand(2, 100), MAXAB);
			genMax(rand(1, 100), rand(1, 100), rand(2, 100), -MAXAB);
		}
		
		for (int i = 0; i < 3; i++) {
			genFlashmob(rand(1, 100), rand(1, 100), rand(2, 100));
		}
		genMaxFlash(rand(80, 100), rand(80, 100), rand(80, 100), MAXAB);
		genMaxFlash(rand(80, 100), rand(80, 100), rand(80, 100), -MAXAB);
		
		
		//P <= 100
		
		for (int i = 0; i < 3; i++) {
			genRand(rand(10000, MAX), rand(10000, MAX), rand(2, 100), MAXAB,  rand.nextDouble());
		}
		for (int i = 0; i < 3; i++) {
			genFlashmob(rand(10000, MAX), rand(10000, MAX), rand(2, 100));
		}
		genRand(MAX, MAX / 2, rand(1, 100), rand(10000, MAXAB), 0.5);
		genRand(MAX / 2, MAX, rand(1, 100), rand(10000, MAXAB), 0.5);
		genMax(MAX, MAX / 2, rand(1, 100), rand(10000, MAXAB));
		genMaxFlash(MAX, rand(MAX / 2, MAX), rand(2, 100), rand(10000, MAXAB));
		
		//10000 <= P <= 100000
		for (int i = 0; i < 3; i++) {
			genRand(rand(10000, MAX), rand(10000, MAX), rand(10000, MAX), MAXAB, rand.nextDouble());
		}
		for (int i = 0; i < 3; i++) {
			genFlashmob(rand(10000, MAX), rand(10000, MAX), rand(10000, MAX));
		}
		genRand(MAX, MAX / 2, MAX, rand(10000, MAXAB), 0.5);
		genRand(MAX, MAX, MAX, MAXAB, 0.5);
		genMax(MAX, MAX, MAX, -MAXAB);
		genMaxFlash(MAX, rand(MAX / 2, MAX), rand(10000, MAX), rand(10000, MAXAB));
		
	}

	public void run() {
		try {
			solve();
		} catch (Throwable e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}
}
