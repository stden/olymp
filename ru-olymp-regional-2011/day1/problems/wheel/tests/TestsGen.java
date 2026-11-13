import java.io.*;
import java.util.*;

public class TestsGen {
	static int testcount = 0;

	static int MAX = 1000;
	
	static int MAXK = (int) 1e9;
	
	static int MAXN = 100;

	static Random random = new Random(59773412);

	static void write(int[] arr, int a, int b, int k) {
		try {
			PrintWriter out = new PrintWriter(
					String.format("%02d", ++testcount));
			System.out.println("Generating test #" + testcount);
			out.println(arr.length);
			for (int i = 0; i < arr.length; i++) {
				if (i > 0) {
					out.print(" ");
				}
				out.print(arr[i]);
			}
			out.println();
			out.println(a + " " + b + " " + k);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	static int[] randArr(int n) {
		int[] ret = new int[n];
		for (int i = 0; i < n; i++) {
			ret[i] = random.nextInt(MAX) + 1;
		}
		return ret;
	}

	static void writeRand(int n, int max) {
		int[] arr = randArr(n);
		int b = random.nextInt(max) + 1;
		int a = random.nextInt(b) + 1;
		int t = random.nextInt(n) + 1;
		int k = (int) Math.ceil(1.0 * (b - a) / t);
		if (k < 1) {
			k = 1;
		}
		write(arr, a, b, k);
	}

	static void writeRand2(int n, int max, int maxk, boolean notone) {
		int[] arr = randArr(n);
		int b = random.nextInt(max) + 1;
		int a = random.nextInt(b) + 1;
		int k = random.nextInt(maxk) + 1;
		while ((b / k) - a / k < 4.5e8 || (notone && k == 1)) {
			b = random.nextInt(max) + 1;
			a = random.nextInt(b) + 1;
			k = random.nextInt(maxk) + 1;
		}
		write(arr, a, b, k);
	}

	static void writeRand3(int n, int max, int maxk, boolean divk) {
		int[] arr = randArr(n);
		int b = random.nextInt(max) + 1;
		int a = random.nextInt(b) + 1;
		int k = random.nextInt(maxk) + 1;
		while (divk && b % k != 0 && a % k != 0) {
			b = random.nextInt(max) + 1;
			a = random.nextInt(b) + 1;
			k = random.nextInt(maxk) + 1;
		}
		write(arr, a, b, k);
	}

	static void writeMax() {
		int[] arr = randArr(MAXN);
		int b = MAXK;
		int a = 1;
		int k = 1;
		write(arr, a, b, k);
	}

	static void writeMin1() {
		int[] arr = randArr(3);
		int b = 1;
		int a = 1;
		int k = 1;
		write(arr, a, b, k);
	}

	static void writeMin2() {
		int[] arr = randArr(3);
		int b = 1000;
		int a = 1;
		int k = 1000000;
		write(arr, a, b, k);
	}

	public static void main(String[] args) throws IOException {
		while (new File(String.format("%02d.t", testcount + 1)).exists()) {
			testcount++;
		}
		writeMin1();
		writeMin2();
		for (int i = 0; i < 4; i++) {
			writeRand(random.nextInt(10 - 2) + 3, 100);
			writeRand3(random.nextInt(10 - 2) + 3, 100, 1000, random.nextDouble() < 0.5 ? true : false);
		}
		for (int i = 0; i < 10; i++) {
			writeRand(random.nextInt(MAXN - 2) + 3, 1000);
		}
		for (int i = 0; i < 5; i++) {
			writeRand3(random.nextInt(MAXN - 2) + 3, 1000, 1000,  random.nextDouble() < 0.5 ? true : false);
		}
		for (int i = 0; i < 15; i++) {
			writeRand(random.nextInt(MAXN - 2) + 3, MAXK);
		}
		for (int i = 0; i < 9; i++) {
			writeRand2(random.nextInt(MAXN - 2) + 3, MAXK, 10, random.nextDouble() < 0.3 ? true : false);
		}
		writeMax();
	}

}
 