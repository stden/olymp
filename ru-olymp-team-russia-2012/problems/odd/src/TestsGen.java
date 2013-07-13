import static java.lang.Math.max;
import static java.lang.Math.min;
import static java.lang.System.exit;
import static java.util.Arrays.asList;

import java.io.*;
import java.util.*;

public class TestsGen {
	static class Edge {
		int from;
		int to;

		public Edge(int from, int to) {
			if (from > to) {
				int t = from;
				from = to;
				to = t;
			}
			if (from == to) {
				throw new AssertionError();
			}
			this.from = from;
			this.to = to;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + from;
			result = prime * result + to;
			return result;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Edge other = (Edge) obj;
			if (from != other.from)
				return false;
			if (to != other.to)
				return false;
			return true;
		}

	}

	static class Test {
		int n;
		Edge[] edges;

		public Test(int n, List<Edge> edges) {
			this.n = n;
			this.edges = (Edge[]) edges.toArray(new Edge[edges.size()]);
		}

		Test shuffle() {
			for (int i = 0; i < edges.length; i++) {
				int j = rand.nextInt(i + 1);
				Edge t = edges[i];
				edges[i] = edges[j];
				edges[j] = t;
			}
			int[] p = randomPermutation(n);
			for (Edge e : edges) {
				e.from = p[e.from];
				e.to = p[e.to];
				if (rand.nextBoolean()) {
					int t = e.from;
					e.from = e.to;
					e.to = t;
				}
			}
			return this;
		}
	}

	static int[] randomPermutation(int n) {
		int[] p = new int[n];
		for (int i = 0; i < n; i++) {
			int j = rand.nextInt(i + 1);
			p[i] = p[j];
			p[j] = i;
		}
		return p;
	}

	static int testNum;

	static void printTest(Test test) {
		System.err.printf("[%02d]", ++testNum);
		try {
			PrintWriter out = new PrintWriter("../tests/"
					+ String.format("%02d", testNum));
			out.println(test.n + " " + test.edges.length);
			for (Edge e : test.edges) {
				out.println((1 + e.from) + " " + (1 + e.to));
			}
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			exit(239);
		}
	}

	static final Random rand = new Random(59);
	static final int MAXN = 200000;
	static final int MAXM = 200000;

	static Test genTLTest(int density1, int density2) {
		int v = MAXN / density1;
		v &= ~1;
		int n = v * 3;
		Set<Edge> set = new HashSet<Edge>();
		for (int i = 0; i < v; i++) {
			set.add(new Edge(i, (i + 1) % v));
		}
		int[] deg = new int[v];
		TreeSet<Integer> vert = new TreeSet<Integer>();
		for (int i = 0; i < v; i++) {
			vert.add(i);
		}
		final int MAXDEG = density2;
		all: for (int i = 0; i < v; i++) {
			vert.remove(i);
			it: while (deg[i] < MAXDEG) {
				Integer z = vert.ceiling(rand.nextInt(v));
				if (z == null) {
					if (vert.isEmpty()) {
						break all;
					}
					z = vert.first();
				}
				if (set.contains(new Edge(i, z))) {
					z = vert.first();
				}
				while (set.contains(new Edge(i, z))) {
					z = vert.higher(z);
					if (z == null) {
						break it;
					}
				}
				set.add(new Edge(i, z));
				deg[z]++;
				if (deg[z] == MAXDEG) {
					vert.remove(z);
				}
				deg[i]++;
			}
		}
		for (int i = 0; i < v; i++) {
			vert.add(i);
		}
		for (int i = v; i < 2 * v; i++) {
			set.add(new Edge(i, i + v));
			Integer z = vert.ceiling(rand.nextInt(v));
			if (z == null) {
				z = vert.first();
			}
			set.add(new Edge(i, z));
			vert.remove(z);
		}
		return new Test(n, new ArrayList<Edge>(set));
	}

	static Test genRandomGraph(int n, int m) {
		Set<Edge> set = new HashSet<Edge>();
		for (int i = 0; i < m; i++) {
			int from;
			int to;
			do {
				from = rand.nextInt(n);
				to = rand.nextInt(n);
			} while (from == to || !set.add(new Edge(from, to)));
		}
		return new Test(n, new ArrayList<Edge>(set)).shuffle();
	}

	static void makeHand() {
		while (true) {
			String fName = String.format("%02d", testNum + 1);
			File file = new File(fName + ".hand");
			if (file.exists()) {
				++testNum;
				try {
					System.err.println("[" + fName + ".hand]");
					copyFile(file, new File("../tests/" + fName));
				} catch (Exception e) {
					System.err.println("couldn't copy file");
					e.printStackTrace();
					exit(238);
				}
			} else {
				break;
			}
		}
	}

	static void copyFile(File from, File to) throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(from));
		BufferedWriter out = new BufferedWriter(new FileWriter(to));
		while (true) {
			String s = br.readLine();
			if (s == null) {
				break;
			}
			out.write(s);
			out.write('\n');
		}
		out.close();
	}

	static Test getConnected(int n, int m) {
		Set<Edge> set = new HashSet<Edge>();
		for (int i = 1; i < n; i++) {
			set.add(new Edge(i, rand.nextInt(i)));
		}
		for (int i = n - 1; i < m; i++) {
			int from, to;
			do {
				from = rand.nextInt(n);
				to = rand.nextInt(n);
			} while (from == to || !set.add(new Edge(from, to)));
		}
		if (set.size() != m) {
			throw new AssertionError(n + " " + set.size() + " " + m);
		}
		return new Test(n, new ArrayList<Edge>(set));
	}

	static Test genMoreThanOneConnectedComponentRandom(int n, int m) {
		int v = 0;
		int leftEdges = m - n;
		List<Edge> edges = new ArrayList<Edge>();
		while (v < n) {
			int verticesToGet = (rand.nextInt((n - v) / 2) + 1) * 2;
			int edgesToGet = v + verticesToGet == n ? leftEdges : rand
					.nextInt(leftEdges + 1);
			if (verticesToGet >= 3) {
				edgesToGet = (int) min(
						edgesToGet,
						max(0, (long) verticesToGet * (verticesToGet - 1) / 6
								- verticesToGet));
			} else {
				edgesToGet = -1;
			}
			leftEdges -= edgesToGet;
			Test test = getConnected(verticesToGet, verticesToGet + edgesToGet);
			for (Edge e : test.edges) {
				edges.add(new Edge(e.from + v, e.to + v));
			}
			v += verticesToGet;
		}
		if (edges.size() > m) {
			throw new AssertionError();
		}
		return new Test(n, edges).shuffle();
	}

	static Test genManyComponentsTest(int n) {
		List<Edge> edges = new ArrayList<Edge>();
		for (int i = 0; i < n; i += 4) {
			for (int j = 0; j < 4; j++) {
				edges.add(new Edge(i + j, i + (j + 1 & 3)));
			}
		}
		return new Test(n, edges);
	}

	static Test genStar(int n, int m) {
		Set<Edge> set = new HashSet<Edge>();
		for (int i = 1; i < n; i++) {
			set.add(new Edge(i, 0));
		}
		for (int i = n - 1; i < m; i++) {
			int from, to;
			do {
				from = rand.nextInt(n - 1);
				to = rand.nextInt(n - 1);
			} while (from == to || !set.add(new Edge(from, to)));
		}
		return new Test(n, new ArrayList<Edge>(set));
	}

	static Test genNoSolutionTest(int n, int m) {
		int v = rand.nextInt(5) * 2 + 5;
		int u = rand.nextInt(5) * 2 + 5;
		List<Edge> edges = new ArrayList<Edge>(
				asList(genMoreThanOneConnectedComponentRandom(n - v - u, m - 2
						* (v + u)).edges));
		int z = n - v - u;
		Test test = getConnected(v, 2 * v);
		for (Edge e : test.edges) {
			edges.add(new Edge(e.from + z, e.to + z));
		}
		z += v;
		test = getConnected(u, 2 * u);
		for (Edge e : test.edges) {
			edges.add(new Edge(e.from + z, e.to + z));
		}
		return new Test(n, edges).shuffle();
	}

	public static void main(String[] args) {
		makeHand();
		printTest(genTLTest(7, 7).shuffle());
		printTest(genTLTest(6, 5).shuffle());
		printTest(genTLTest(9, 9).shuffle());
		printTest(genManyComponentsTest(200000).shuffle());
		printTest(genStar(150000, 200000).shuffle());
		printTest(genTwoStars(150000, 200000).shuffle());
		for (int[] e : new int[][] { { 10, 20 }, { 50, 150 }, { 500, 5000 },
				{ 20000, 100000 }, { 50000, 40000 }, { 60000, 10000 } }) {
			printTest(genRandomGraph(e[0], e[1]));
		}
		for (int[] e : new int[][] { { 50, 150 }, { 500, 5000 },
				{ 20000, 100000 }, { 50000, 200000 }, { 150000, 200000 } }) {
			printTest(genMoreThanOneConnectedComponentRandom(e[0], e[1]));
		}
		for (int[] e : new int[][] { { 50, 1000 }, { 10000, 20000 },
				{ 150000, 200000 } }) {
			printTest(genNoSolutionTest(e[0], e[1]));
		}
		printTest(new Test(1, new ArrayList<Edge>()));
		printTest(genCycle(200000));
		printTest(genFullGraph(500));
		printTest(genTree(200000));		
	}

	static Test genTree(int n) {
		return getConnected(n, n - 1);
	}

	static Test genFullGraph(int n) {
		List<Edge> edges = new ArrayList<Edge>();
		for (int i = 0; i < n; i++) {
			for (int j = i + 1; j < n; j++) {
				edges.add(new Edge(i, j));
			}
		}
		return new Test(n, edges);
	}

	static Test genCycle(int n) {
		List<Edge> edges = new ArrayList<Edge>();
		for (int i = 0; i < n; i++) {
			edges.add(new Edge(i, (i + 1) % n));
		}
		return new Test(n, edges).shuffle();
	}

	static Test genTwoStars(int n, int m) {
		Test t1 = genStar(n / 2, m / 2);
		Test t2 = genStar(n / 2, m / 2 - 1);
		int z = n / 2;
		List<Edge> edges = new ArrayList<Edge>();
		edges.add(new Edge(0, z));
		for (Edge e : t1.edges) {
			edges.add(e);
		}
		for (Edge e : t2.edges) {
			edges.add(new Edge(e.from + z, e.to + z));
		}
		return new Test(n, edges);
	}
}
