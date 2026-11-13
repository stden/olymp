import java.io.*;
import java.util.*;

public class processing_pk {

	BufferedReader br;
	PrintWriter out;
	StringTokenizer st;

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

	class ProcessResult {
		String result;
		ArrayList<Integer> sertificate;
		
		ProcessResult(String input) {
			if (input.length() % 2 == 1) {
				result = input;
				sertificate = new ArrayList<Integer>();
				return;
			}
			String left = input.substring(0, input.length() / 2);
			String right = input.substring(input.length() / 2);
			ProcessResult lRes = new ProcessResult(left);
			ProcessResult rRes = new ProcessResult(right);
			if (lRes.result.compareTo(rRes.result) < 0) {
				result = lRes.result + rRes.result;
				sertificate = lRes.sertificate;
				sertificate.addAll(rRes.sertificate);
				sertificate.add(0);
			} else {
				result = rRes.result + lRes.result;
				sertificate = lRes.sertificate;
				sertificate.addAll(rRes.sertificate);
				sertificate.add(1);
			}
		}
	}
	
	public void solve() throws IOException {
		String s = nextToken();
		String t = nextToken();
		ProcessResult resS = new ProcessResult(s);
		ProcessResult resT = new ProcessResult(t);
		if (resS.result.equals(resT.result)) {
			out.println("Yes");
			ArrayList<Integer> genSertificate = gen(resS.sertificate, resT.sertificate);
			for (int i = 0; i < genSertificate.size(); i++) {
				out.print(genSertificate.get(i));
				if (i < genSertificate.size() - 1)
					out.print(' ');
			}
			out.println();
		} else {
			out.println("No");
		}
		//System.err.println(resS.sertificate.toString());
		//System.err.println(resT.sertificate.toString());
	}

	private ArrayList<Integer> gen(ArrayList<Integer> s1,
			ArrayList<Integer> s2) {
		if (s1.size() == 0)
			return new ArrayList<Integer>();
		if (s1.size() == 1) {
			ArrayList<Integer> res = new ArrayList<Integer>();
			res.add(s1.get(0) ^ (s2.get(0)));
			return res;
		}
		ArrayList<Integer> l1 = new ArrayList<Integer>(s1.subList(0, s1.size() / 2));
		ArrayList<Integer> r1 = new ArrayList<Integer>(s1.subList(s1.size() / 2, s1.size() - 1));
		ArrayList<Integer> l2 = new ArrayList<Integer>(s2.subList(0, s2.size() / 2));
		ArrayList<Integer> r2 = new ArrayList<Integer>(s2.subList(s2.size() / 2, s2.size() - 1));
		int l = s1.get(s1.size() - 1);
		int r = s2.get(s2.size() - 1);
		if (l == r) {
			ArrayList<Integer> res = gen(l1, l2);
			res.addAll(gen(r1, r2));
			res.add(0);
			return res;
		}
		if (l == 1) {
			ArrayList<Integer> res = gen(l1, r2);
			res.addAll(gen(r1, l2));
			res.add(1);
			return res;
		}
		ArrayList<Integer> res = gen(l1, r2);
		res.addAll(gen(r1, l2));
		res.add(1);
		return res;
		
	}

	public void run() {
		try {
			br = new BufferedReader(new InputStreamReader(System.in));
			out = new PrintWriter(System.out);

			br = new BufferedReader(new FileReader("processing.in"));
			out = new PrintWriter("processing.out");
			int n = nextInt();
			for (int i = 0; i < n; i++) {
			solve();
			}

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new processing_pk().run();
	}
}