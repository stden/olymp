import java.io.*;
import java.util.*;

public class Gen {

	static int done = 0;
	static ArrayList<Integer> data = new ArrayList<Integer>();

	static final Random rand = new Random(556668949239L);
	static final int MAX_N = 20;
	static final int MAX_M = 10;
	static final int MAX_C = 1000;
	static final int MAX_CATS = 30;

	static void print() throws IOException {
		done++;
		System.err.println(done);
		PrintWriter out;
		if (done < 10)
			out = new PrintWriter("../tests/0" + String.valueOf(done));
		else
			out = new PrintWriter("../tests/" + String.valueOf(done));

		out.println(data.get(0) + " " + data.get(1) + " " + data.get(2));
		for (int i = 3; i < data.size(); i++) {
			out.print(data.get(i));
			if (i != data.size() - 1)
				out.print(" ");
		}
		out.println();
		data.clear();
		out.close();
	}

	static long nextLong(long max) {
		return Math.abs(rand.nextLong()) % max;
	}

	static void genRandomTest(int n, int m)
			throws IOException {
		data.add(n);
		data.add(m);
		data.add(rand.nextInt(MAX_C) + 1);
		for (int i = 0; i < n * m; i++)
			data.add(rand.nextInt(MAX_CATS) + 1);
		print();
	}

	static void genSample1() throws IOException {
		data.add(2);
		data.add(3);
		data.add(10);
		
		data.add(3);
		data.add(5);
		data.add(2);
		data.add(4);
		data.add(10);
		data.add(5);

		print();
	}

	public static void main(String[] args) throws IOException {
		File dir = new File("../tests");
		if (!dir.exists())
			dir.mkdir();
		done = 0;
		genSample1();

		for (int i = 0; i < 20; i++)
			genRandomTest(1 + rand.nextInt(MAX_N), 1 + rand.nextInt(MAX_M));
		for (int i = 0; i < 3; i++)
			genRandomTest(MAX_N, MAX_M);
		
		return;
	}
}