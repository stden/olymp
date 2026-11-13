import java.io.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Random;
import java.util.StringTokenizer;

public class processing_vd {
	BufferedReader in;
	StringTokenizer str;
	PrintWriter out;
	String SK;

	String next() throws IOException {
		while ((str == null) || (!str.hasMoreTokens())) {
			SK = in.readLine();
			if (SK == null)
				return null;
			str = new StringTokenizer(SK);
		}
		return str.nextToken();
	}

	int nextInt() throws IOException {
		return Integer.parseInt(next());
	}

	double nextDouble() throws IOException {
		return Double.parseDouble(next());
	}

	long nextLong() throws IOException {
		return Long.parseLong(next());
	}

	class Answer {
		String str;
		String chg;

		public Answer(String a, String b) {
			str = a;
			chg = b;
		}
	}

	Answer getmin(String a, int st, int en) {
		if (st + 1 == en) {
			return new Answer(a.charAt(st) + "", "");
		}
		Answer a1 = getmin(a, st, (st + en) / 2);
		Answer a2 = getmin(a, (st + en) / 2, en);
		if (a1.str.compareTo(a2.str) <= 0) {
			return new Answer(a1.str + a2.str, "0" + a1.chg + a2.chg);
		} else {
			return new Answer(a2.str + a1.str, "1" + a2.chg + a1.chg);
		}

	}

	void output(String a, String b) {
		if (a.length() == 0) {
			return;
		}
		int mid = (a.length() - 1) / 2;
		String a1 = a.substring(1, mid + 1);
		String a2 = a.substring(mid + 1);
		String b1 = b.substring(1, mid + 1);
		String b2 = b.substring(mid + 1);

		if (a.charAt(0) == '0') {
			output(a1, b1);
			output(a2, b2);
		} else {
			output(a2, b2);
			output(a1, b1);
		}
		out.print(((a.charAt(0) - '0') ^ (b.charAt(0) - '0')) + " ");

	}

	void solve() throws IOException {
		String a = next();
		Answer t1 = getmin(a, 0, a.length());
		Answer t2 = getmin(next(), 0, a.length());
		if (!t1.str.equals(t2.str)) {
			out.println("No");
			return;
		}
		out.println("Yes");
		output(t1.chg, t2.chg);
		out.println();
	}

	void run() throws IOException {
		in = new BufferedReader(new FileReader("processing.in"));
		out = new PrintWriter("processing.out");
		int k = nextInt();
		for (int i = 0; i < k; i++) {
			solve();
		}
		out.close();
	}

	public static void main(String[] args) throws IOException {
		new processing_vd().run();
	}

}