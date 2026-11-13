import java.io.*;
import java.lang.reflect.Array;
import java.util.*;

public class Gen {

	static int done = 0;

	static final Random rand = new Random(556668949239L);

	final int maxA = 10000, maxN = 100000, maxM = 100000;

	int a, b;
	int[][] g;
	int[] color;

	class Edge {
		int a, b;

		public Edge(int a, int b) {
			super();
			this.a = a;
			this.b = b;
		}
	}

	void print() throws IOException {
		done++;
		System.err.println(done);
		PrintWriter out;
		if (done < 10)
			out = new PrintWriter("../tests/0" + String.valueOf(done));
		else
			out = new PrintWriter("../tests/" + String.valueOf(done));

		out.println(g.length);
		for (int i = 0; i < g.length; i++) {
			out.print(color[i] + " " + g[i].length);
			for (int j : g[i]) {
				out.print(" " + j);
			}
			out.println();
		}
		out.println(a + " " + b);

		out.close();
	}

	void genSample() {
		g = new int[6][];
		color = new int[] { 1, 2, 2, 1, 1, 1 };
		a = 15;
		b = 40;
		g[0] = new int[] { 3, 4, 5 };
		g[1] = new int[] { 4 };
		g[2] = new int[] { 5, 6 };
		g[3] = new int[] { 6 };
		g[4] = new int[] {};
		g[5] = new int[] {};
	}

	void genTest2() {
		g = new int[4][];
		color = new int[] { 1, 1, 2, 2 };
		a = 100;
		b = 101;
		g[0] = new int[] {};
		g[1] = new int[] { 3 };
		g[2] = new int[] {};
		g[3] = new int[] { 1 };
	}

	void genTest3() {
		g = new int[4][];
		color = new int[] { 2, 1, 2, 1 };
		a = 1;
		b = 1;
		g[0] = new int[] { 2 };
		g[1] = new int[] { 3 };
		g[2] = new int[] {};
		g[3] = new int[] {};
	}

	void genTest4() {
		g = new int[7][];
		color = new int[] { 2, 2, 1, 2, 2, 1, 1 };
		a = 19;
		b = 9;
		g[0] = new int[] { 2, 3 };
		g[1] = new int[] { 4, 5 };
		g[2] = new int[] { 6, 7 };
		g[3] = new int[] {};
		g[4] = new int[] {};
		g[5] = new int[] {};
		g[6] = new int[] {};
	}

	void genTest5() {
		g = new int[8][];
		color = new int[] { 2, 2, 1, 2, 2, 1, 1, 2 };
		a = 19;
		b = 9;
		g[0] = new int[] { 2, 3 };
		g[1] = new int[] { 4, 5 };
		g[2] = new int[] { 6, 7 };
		g[3] = new int[] {};
		g[4] = new int[] {};
		g[5] = new int[] { 8 };
		g[6] = new int[] {};
		g[7] = new int[] {};
	}

	void genTest6() {
		g = new int[1][];
		color = new int[] { 1 };
		a = 243;
		b = 31;
		g[0] = new int[] {};
	}

	void genTest7() {
		g = new int[6][];
		color = new int[] { 1, 2, 1, 1, 2, 2 };
		a = 119;
		b = 1005;
		g[0] = new int[] { 2, 3, 5 };
		g[1] = new int[] { 5 };
		g[2] = new int[] { 5 };
		g[3] = new int[] { 5 };
		g[4] = new int[] {};
		g[5] = new int[] { 5 };
	}

	void genTest8() {
		g = new int[8][];
		color = new int[] { 1, 2, 2, 1, 2, 2, 1, 1 };
		a = rand.nextInt(maxA) + 1;
		b = rand.nextInt(maxA) + 1;
		g[0] = new int[] {};
		g[1] = new int[] { 1 };
		g[2] = new int[] { 1 };
		g[3] = new int[] { 2, 3 };
		g[4] = new int[] { 2, 3, 4 };
		g[5] = new int[] { 7 };
		g[6] = new int[] { 1, 5 };
		g[7] = new int[] { 1, 5 };
	}

	void genTest9() {
		g = new int[4][];
		color = new int[] { 1, 1, 1, 1 };
		a = rand.nextInt(maxA) + 1;
		b = rand.nextInt(maxA) + 1;
		g[0] = new int[] { 2, 4 };
		g[1] = new int[] { 3, 4 };
		g[2] = new int[] {};
		g[3] = new int[] {};
	}

	void genTest10() {
		g = new int[maxN][];
		color = new int[maxN];
		for (int i = 0; i < maxN; i++) {
			color[i] = i % 2 + 1;
		}
		a = maxA;
		b = maxA;
		for (int i = 0; i < maxN - 1; i++) {
			g[i] = new int[] { i + 2 };
		}
		g[maxN - 1] = new int[0];
	}

	void genTest11() {
		g = new int[7][];
		color = new int[] { 2, 2, 1, 1, 1, 1, 1 };
		a = rand.nextInt(maxA) + 1;
		b = rand.nextInt(maxA) + 1;
		g[0] = new int[] { 4 };
		g[1] = new int[] { 4 };
		g[2] = new int[] { 4 };
		g[3] = new int[] { 6, 7 };
		g[4] = new int[] { 1, 2, 4 };
		g[5] = new int[] {};
		g[6] = new int[] {};
	}

	void genTest12() {
		g = new int[12][];
		color = new int[] { 1, 2, 2, 2, 1, 1, 2, 2, 1, 2, 2, 1 };
		a = rand.nextInt(maxA) + 1;
		b = rand.nextInt(maxA) + 1;
		g[0] = new int[] { 2, 3, 4 };
		g[1] = new int[] { 5 };
		g[2] = new int[] { 5 };
		g[3] = new int[] { 6 };
		g[4] = new int[] { 7, 8 };
		g[5] = new int[] { 7, 8 };
		g[6] = new int[] {};
		g[7] = new int[] {};
		g[8] = new int[] { 10, 11 };
		g[9] = new int[] { 12 };
		g[10] = new int[] { 12 };
		g[11] = new int[] {};
	}

	void genTest13() {
		g = new int[4][];
		color = new int[] { 2, 1, 2, 1 };
		a = rand.nextInt(maxA) + 1;
		b = rand.nextInt(maxA) + 1;
		g[0] = new int[] {};
		g[1] = new int[] {};
		g[2] = new int[] {};
		g[3] = new int[] {};
	}

	void genTest14() {
		g = new int[5][];
		color = new int[] { 1, 2, 2, 2, 2 };
		a = rand.nextInt(maxA) + 1;
		b = rand.nextInt(maxA) + 1;
		g[0] = new int[] { 2, 3, 4 };
		g[1] = new int[] {};
		g[2] = new int[] {};
		g[3] = new int[] {};
		g[4] = new int[] { 2, 3, 4 };

	}

	class Item implements Comparable<Item> {
		int a, b;

		public Item(int a, int b) {
			super();
			this.a = a;
			this.b = b;
		}

		@Override
		public int compareTo(Item o) {
			if (a == o.a) {
				return b - o.b;
			}
			return a - o.a;
		}
	}

	void genRandomTest(int a, int b) {
		ArrayList<Integer>[] gList = new ArrayList[maxN];
		TreeSet<Item> was = new TreeSet<Gen.Item>();
		for (int i = 0; i < maxN; i++) {
			gList[i] = new ArrayList<Integer>();
		}
		g = new int[maxN][];
		color = new int[maxN];
		for (int i = 0; i < maxN; i++) {
			color[i] = rand.nextInt(2) + 1;
		}
		this.a = a;
		this.b = b;
		ArrayList<Integer> name = new ArrayList<Integer>();
		for (int i = 0; i < maxN; i++) {
			name.add(i);
		}
		Collections.shuffle(name);
		for (int i = 0; i < maxM; i++) {
			while (true) {
				int ii = rand.nextInt(maxN - 1);
				int jj = rand.nextInt(maxN - ii - 1) + 1;
				if (!was.contains(new Item(ii, ii + jj))) {
					was.add(new Item(ii, ii + jj));
					gList[name.get(ii)].add(name.get(ii + jj) + 1);
					break;
				}
			}
		}
		for (int i = 0; i < maxN; i++) {
			g[i] = new int[gList[i].size()];
			for (int j = 0; j < gList[i].size(); j++) {
				g[i][j] = gList[i].get(j);
			}
		}
	}

	public void run() throws IOException {
		File dir = new File("../tests");
		if (!dir.exists())
			dir.mkdir();
		done = 0;

		genSample();
		print();

		genTest2();
		print();

		genTest3();
		print();

		genTest4();
		print();

		genTest5();
		print();

		genTest6();
		print();

		genTest7();
		print();

		genTest8();
		print();

		genTest9();
		print();

		genTest10();
		print();

		genTest11();
		print();

		genTest12();
		print();

		genTest13();
		print();

		genTest14();
		print();
		
		for (int i = 0; i < 4; i++) {
			genRandomTest(1, 1000);
			print();
		}
		
		for (int i = 0; i < 4; i++) {
			genRandomTest(100, 100);
			print();
		}
		
		for (int i = 0; i < 4; i++) {
			genRandomTest(1000, 2);
			print();
		}
		
		for (int i = 0; i < 4; i++) {
			genRandomTest(10000, 10000);
			print();
		}
	}

	public static void main(String[] args) throws IOException {
		new Gen().run();
	}
}
