import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import java.util.*;

public class TestGen extends Thread {
	
	class Test {
		int n ,k;
		int[] c;
		int[] b;
		
		public void doCheck() {
			myAssert(1 <= n && n <= 100000, "n out of range: " + n);
			myAssert(1 <= k && k <= 100000, "k out of range: " + k);
			myAssert(c.length == n, "Length of c != n: " + c.length + " " + n);
			myAssert(b.length == k, "Length of b(keys) != k: " + b.length + " " + k);
			for (int i = 0; i < n; i++)
				myAssert(1 <= c[i] && c[i] <= 100000, "c[" + (i + 1) + "] out of range: " + c[i]);
			for (int i = 0; i < k; i++)
				myAssert(1 <= b[i] && b[i] <= n, "b[" + (i + 1) + "] out of range: " + b[i] + " " + n);
		}
	}
	
	private int testCount = 0;

	private void write(Test test) {
		try {
			++testCount;
			PrintWriter out = new PrintWriter(testCount / 10 + "" + testCount% 10);
			test.doCheck();
			out.println(test.n);
			for (int i = 0; i < test.n; i++)
				out.print(test.c[i] + (i == test.n - 1 ? "" : " "));
			out.println();
			out.println(test.k);
			for (int i = 0; i < test.k; i++)
				out.print(test.b[i] + (i == test.k - 1 ? "" : " "));
			out.println();
			out.flush();
			out.close();
		} catch (IOException ex) {
			throw new RuntimeException(ex);
		}
	}
	
	int[] randArray(int[] a) {
		int n = a.length;
		int[] r = new int[n];
		int[] b = new int[n];
		for (int i = 0; i < n; i++)
			b[i] = i;
		
		for (int i = 1; i < n; i++) {
			int t = rand.nextInt(i);
			b[i] = b[t];
			b[t] = i;
		}
		
		for (int i = 0; i < n; i++)
			r[b[i]] = a[i];
		
		return r;
	}
	
	Test randomTest(int n, int k, int maxc, boolean b) {
		Test ans = new Test();
		ans.n = n;
		ans.k = k;
		ans.c = new int[n];
		ans.b = new int[k];
		
		for (int i = 0; i < n ;i++)
			ans.c[i] = rand.nextInt(maxc) + 1;
		
		if (!b || n == 1) {
			for (int i = 0; i < k; i++)
				ans.b[i] = rand.nextInt(n) + 1;
		} else {
			int j = -1;
			for (int i = 0; i < n; i++)
				if (ans.c[i] <= k) {
					j = i;
					break;
				}
			myAssert(j != -1, "FUCK");
			for (int i = 0; i < ans.c[j]; i++)
				ans.b[i] = j + 1;
			for (int i = ans.c[j]; i < k; i++) {
				int t = rand.nextInt(n) + 1;
				while (t == j + 1) {
					t = rand.nextInt(n) + 1;
				}
				ans.b[i] = t;
			}
			
			ans.b = randArray(ans.b);				
		}
		return ans;
	}

	void myAssert(boolean b, String s) {
		if (!b)
			throw new AssertionError(s);
	}

	Random rand;

	public void run() {
		rand = new Random(255666);
		
		// short tests
//		for (int i = 0; i < 8; i++) {
//			write(randomTest(rand.nextInt(100) + 1,rand.nextInt(Short.MAX_VALUE) + 1, Short.MAX_VALUE));
//		}
		
		//big tests
		int n, k;
		for (int i = 0; i < 4; i++) {
			write(randomTest(n = rand.nextInt(100) + 1,k = rand.nextInt(Short.MAX_VALUE) + 1, 2 * k / (n) + 10, false));
		}
		
		
		
		for (int i = 4; i < 20; i++) {
			write(randomTest(n = rand.nextInt(100) + 1,k = rand.nextInt(100000) + 1, 2 * k / (n) + 10, true));
		}
	}

	public static void main(String[] args) throws IOException {
		new TestGen().start();
	}
}
