import java.io.*;
import java.util.*;

public class exam_va implements Runnable {
	public static void main(String[] args) {
		new Thread(new exam_va()).run();
	}

	BufferedReader br;
	StringTokenizer in;
	PrintWriter out;

	public String nextToken() throws IOException {
		while (in == null || !in.hasMoreTokens()) {
			in = new StringTokenizer(br.readLine());
		}

		return in.nextToken();
	}

	public int nextInt() throws IOException {
		return Integer.parseInt(nextToken());
	}

	public long nextLong() throws IOException {
		return Long.parseLong(nextToken());
	}

	public double nextDouble() throws IOException {
		return Double.parseDouble(nextToken());
	}

	public void solve() throws IOException {
		int n = nextInt();

		int[] a = new int[n + 2];
		long diff = 0;
		for (int i = 0; i < n; i++) {
			a[i + 1] = nextInt();
			if (i != 0)
				diff += Math.max(a[i] - a[i + 1], 0);
		}

		if (diff <= a[1]) {
			out.println(0);
			return;
		}

		diff -= a[1];

		a[0] = Integer.MAX_VALUE;
		a[n + 1] = Integer.MAX_VALUE;

		long[] add = new long[n + 1];

		ArrayList<Integer> v = new ArrayList<Integer>();
		v.add(0);
		for (int i = 1; i < n + 2; i++) {
			while (a[v.get(v.size() - 1)] < a[i]) {
				int z = a[v.get(v.size() - 1)];
				v.remove(v.size() - 1);
				add[i - v.get(v.size() - 1) - 1] += Math.min(
						a[v.get(v.size() - 1)], a[i])
						- z;

			}
			v.add(i);
		}

		long ans = 0;
		for (int i = 0; i < add.length; i++) {
			long can = Math.min(add[i], diff);
			diff -= can;
			ans += can * i;
		}

		out.println(ans);
	}

	public void run() {
		try {
			br = new BufferedReader(new FileReader("exam.in"));
			out = new PrintWriter("exam.out");

			int t = nextInt();
			for (int i = 0; i < t; i++) {
				solve();
			}

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
