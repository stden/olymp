import java.io.*;
import java.util.*;

public class TestGen {

	BufferedReader br;
	PrintWriter out;
	StringTokenizer st;
	Random rnd;
	int tNumber;

	class Test {
		ArrayList<String> s;
		ArrayList<String> t;

		void printTest() throws FileNotFoundException {
			if (tNumber < 10)
				out = new PrintWriter("../tests/0" + tNumber);
			else
				out = new PrintWriter("../tests/" + tNumber);
			tNumber++;
			out.println(s.size());
			for (int i = 0; i < s.size(); i++) {
				out.println(s.get(i));
				out.println(t.get(i));
			}
			out.close();
		}

		void genSamples() throws IOException {
			s = new ArrayList<String>();
			t = new ArrayList<String>();
			s.add("abacabab");
			t.add("baababca");
			s.add("abacabab");
			t.add("bbaaabca");
			printTest();
		}

		void genHellTest() throws FileNotFoundException {
			s = new ArrayList<String>();
			t = new ArrayList<String>();

			for (int i = 0; i < 256; i++) {
				for (int j = 0; j < 256; j++) {
					s.add(get(i));
					t.add(get(j));
					if (s.size() > 10000) {
						printTest();
						s = new ArrayList<String>();
						t = new ArrayList<String>();
					}
				}
			}
		}

		private String get(int i) {
			String res = "";
			for (int j = 0; j < 8; j++) {
				res = res + (char) ('a' + i % 2);
				i /= 2;
			}
			return res;
		}

		void genRandYes(int l) {
			char[] c = new char[l];
			for (int i = 0; i < l; i++) {
				c[i] = (char) (rnd.nextInt(26) + 'a');
			}
			String s = new String(c);
			String t = genRand(s, 0);
			this.s.add(s);
			this.t.add(t);
		}

		void genRandSwapNo(int l) {
			char[] c = new char[l];
			for (int i = 0; i < l; i++) {
				c[i] = (char) (rnd.nextInt(26) + 'a');
			}
			String s = new String(c);
			String t = genRand(s, 0);
			int x = rnd.nextInt(l);
			int y = rnd.nextInt(l);
			char tmp = c[x];
			c[x] = c[y];
			c[y] = tmp;
			s = new String(c);
			this.s.add(s);
			this.t.add(t);
		}

		void genRandChangeNo(int l) {
			char[] c = new char[l];
			for (int i = 0; i < l; i++) {
				c[i] = (char) (rnd.nextInt(26) + 'a');
			}
			String s = new String(c);
			String t = genRand(s, 0);
			int x = rnd.nextInt(l);
			c[x] = (char) (rnd.nextInt(26) + 'a');
			s = new String(c);
			this.s.add(s);
			this.t.add(t);
		}

		void genLargeTuimNo(int k, int x) throws FileNotFoundException {
			s = new ArrayList<String>();
			t = new ArrayList<String>();
			int l = 65536;
			char[] c = new char[l];
			for (int i = 0; i < l; i++) {
				c[i] = (char) (calc(i / x) + 'a');
			}
			String t = new String(c);
			for (int i = 0; i < k; i++) {
				int y = rnd.nextInt((l / x - 1)) * x;
				for (int z = y; z < y + x; z++) {
					char tmp = c[z + x];
					c[z + x] = c[z];
					c[z] = tmp;
				}
			}
			String s = new String(c);
			this.s.add(s);
			this.t.add(t);
			printTest();
		}

		void genLargeTuimNox2(int k) throws FileNotFoundException {
			s = new ArrayList<String>();
			t = new ArrayList<String>();
			int l = 65536;
			char[] c = new char[l];
			for (int i = 0; i < l; i++) {
				c[i] = (char) (calc(i / 2) + 'a');
			}
			String t = new String(c);
			for (int i = 0; i < k; i++) {
				int x = rnd.nextInt(l / 2 - 1) * 2;
				char tmp = c[x + 2];
				c[x + 2] = c[x];
				c[x] = tmp;
				tmp = c[x + 3];
				c[x + 3] = c[x + 1];
				c[x + 1] = tmp;
			}
			String s = new String(c);
			this.s.add(s);
			this.t.add(t);
			printTest();
		}



		void genInterestingTest() throws FileNotFoundException {
			s = new ArrayList<String>();
			t = new ArrayList<String>();
			int l = 32768;
			char[] c = new char[l];
			for (int i = 0; i < l; i++) {
				c[i] = (char) (calc(i) + 'a');
			}
			char[] tc = c.clone();
			c[0] = 'b';
			c[1] = 'b';
			c[2] = 'a';
			c[3] = 'a';
			String t = genRand(new String(tc), 0) + genRand(new String(c), 0);
			String s = genRand(new String(c), 0) + genRand(new String(tc), 0);
			
			this.s.add(s);
			this.t.add(t);
			printTest();
		}

		void genAnotherInterestingTest(int d) throws FileNotFoundException {
			s = new ArrayList<String>();
			t = new ArrayList<String>();
			int l = 32768;
			char[] c = new char[l];
			for (int i = 0; i < l; i++) {
				c[i] = (char) (calc(i) + 'a');
			}
			char[] tc = c.clone();
			for (int i = 0; i < d; i++) {
				tc[i] = 'a';
			}
			for (int i = 0; i < d; i++) {
				tc[d + i] = 'b';
			}
			
			for (int i = 0; i < d / 2; i++) {
				c[i] = 'a';
				c[d + i] = 'a';
			}
			for (int i = 0; i < d; i++) {
				c[d + i + d / 2] = 'b';
				c[i + d / 2] = 'b';
			}
			


			String t = genRand(new String(tc), 0) + genRand(new String(c), 0);
			String s = genRand(new String(c), 0) + genRand(new String(tc), 0);
			
			this.s.add(s);
			this.t.add(t);
			printTest();
		}

		
		private int calc(int i) {
			int res = 0;
			while (i > 0) {
				res += i % 2;
				i /= 2;
			}
			return res % 2;
		}

		private String genRand(String s, int k) {

			if (s.length() == 1)
				return s;
			String left = s.substring(0, s.length() / 2);
			String right = s.substring(s.length() / 2);
			if ((rnd.nextBoolean())) {
				return genRand(left, 0) + genRand(right, 0);
			} else {
				return genRand(right, 0) + genRand(left, 0);
			}
		}

		private String genFull(String s) {

			if (s.length() == 1)
				return s;
			String left = s.substring(0, s.length() / 2);
			String right = s.substring(s.length() / 2);
				return genFull(right) + genFull(left);
			
		}



		Test() {
			s = new ArrayList<String>();
			t = new ArrayList<String>();
		}
	}

	public String nextToken() throws IOException {
		while ((st == null) || (!st.hasMoreTokens()))
			st = new StringTokenizer(br.readLine());
		return st.nextToken();
	}

	public int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	public double nextDouble() throws IOException {
		return Double.parseDouble(nextToken());
	}

	public long nextLong() throws IOException {
		return Long.parseLong(nextToken());
	}

	public void solve() throws IOException {
		tNumber = 1;
		rnd = new Random(31);
		Test t = new Test();

		t.genSamples();

		t.genHellTest();

		t = new Test();

		for (int l = 1; l < 16; l++) {
			t.genRandYes(1 << l);
		}
		t.printTest();

		t = new Test();
		t.genRandYes(1 << 16);
		t.printTest();

		t = new Test();
		for (int l = 1; l < 15; l++) {
			t.genRandSwapNo(1 << l);
			t.genRandChangeNo(1 << l);
		}
		t.printTest();

		t = new Test();
		t.genRandSwapNo(1 << 15);
		t.genRandChangeNo(1 << 15);
		t.printTest();

		t = new Test();
		t.genRandSwapNo(1 << 16);
		t.printTest();

		t = new Test();
		t.genRandChangeNo(1 << 16);
		t.printTest();

		for (int k = 0; k < 500; k += 100) {
			for (int x = 1; x <= 8; x *= 2) {
				t.genLargeTuimNo(k, x);
			}
		}
		
		t.genInterestingTest();

		for (int i = 2; i <= 1024; i *= 4) {
			t.genAnotherInterestingTest(i);
		}
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			solve();

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new TestGen().run();
	}
}