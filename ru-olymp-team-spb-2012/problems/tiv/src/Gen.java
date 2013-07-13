import java.io.*;
import java.util.*;

public class Gen {

	static int done = 0;

	static ArrayList<String> data = new ArrayList<String>();

	static final Random rand = new Random(556668949239L);
	static final int MAX_COUNT = 10;
	static final int MAX_LENGTH = 9;
	static final int MAX_VALUE = (int) 1e9 - 1;

	static void print() throws IOException {
		done++;
		System.err.println(done);
		PrintWriter out;
		if (done < 10)
			out = new PrintWriter("../tests/0" + String.valueOf(done));
		else
			out = new PrintWriter("../tests/" + String.valueOf(done));

		out.println(data.size());
		for (int i = 0; i < data.size(); i++) {
			out.println(data.get(i));
		}
		data.clear();
		out.close();
	}

	static void crypto(ArrayList<Integer> num) throws IOException {
		ArrayList<Integer> key = new ArrayList<Integer>();
		for (int i = 0; i < 10; i++)
			key.add(i);
		Collections.shuffle(key, rand);
		String[] st = new String[num.size()];
		for (int i = 0; i < num.size(); i++)
			st[i] = num.get(i).toString();
		for (int i = 0; i < num.size(); i++) {
			String t = "";
			for (int j = 0; j < st[i].length(); j++) {
				t += (char) ('a' + key.get((int)(st[i].charAt(j) - '0')));
			}
			data.add(t);
		}
	}

	static void genNo(int cnt, int value) throws IOException {
		ArrayList<Integer> ch = new ArrayList<Integer>();

		for (int i = 0; i < cnt - 1; i++)
			ch.add(rand.nextInt(value) + 1);
		ch.add(ch.get(rand.nextInt(cnt - 1)));
		Collections.sort(ch);
		crypto(ch);
		print();
	}

	static void genSpecialNo(int len) throws IOException {
		for (int i = 0; i < 10; i++) {
			String t = "";
			t += (char) ('a' + i);
			for (int j = 1; j < len; j++)
				t += "a";
			data.add(t);
		}
		Collections.shuffle(data, rand);
		print();
	}

	static void genRandom(int cnt, int value) throws IOException {
		ArrayList<Integer> ch = new ArrayList<Integer>();
		ch.add(rand.nextInt(value / cnt));
		for (int i = 1; i < cnt; i++)
			ch.add(rand.nextInt(value / cnt) + 1 + ch.get(i - 1));
		crypto(ch);
		print();
	}

	static void genYes(int cnt, int len) throws IOException {
		for (int i = 0; i < cnt; i++) {
			String t = "";
			for (int j = 0; j < len; j++)
				t += (char) ('a' + rand.nextInt(10));
			data.add(t);
		}
		Collections.sort(data);
		print();
	}

	static void genRandomSame(int cnt, int len) throws IOException {
		for (int i = 0; i < cnt; i++) {
			String t = "";
			for (int j = 0; j < len; j++)
				t += (char) ('a' + rand.nextInt(10));
			data.add(t);
			if (rand.nextInt(100) < 30 && i < cnt - 1) {
				data.add(t);
				i++;
			}
		}
		Collections.sort(data);
		print();
	}

    static void genRandom2(int cnt, int len) throws IOException {
		for (int i = 0; i < cnt; i++) {
			String t = "";
			for (int j = 0; j < len; j++)
				t += (char) ('a' + rand.nextInt(10));
			data.add(t);
		}
		print();
	}

    static void genRandom3(int cnt, int len) throws IOException {
		for (int i = 0; i < cnt; i++) {
			String t = "";
			int sz = 1 + rand.nextInt(len);
			for (int j = 0; j < sz; j++)
				t += (char) ('a' + rand.nextInt(10));
			data.add(t);
		}
		print();
	}

	static void genSimple() throws IOException {
		data.add("a");
		data.add("da");
		data.add("dd");
		data.add("cc");
		print();
        data.add("a");
        data.add("j");
        data.add("jb");
        data.add("ac");
        print();
	}

	public static void main(String[] args) throws IOException {
		File dir = new File("../tests");
		if (!dir.exists())
			dir.mkdir();
		done = 0;
		genSimple();

		// Impossible
		genNo(MAX_COUNT, MAX_VALUE);
		genSpecialNo(MAX_LENGTH);
		genNo(2, 1);
		genNo(MAX_COUNT, 1000);
		genNo(5, 100);
		genSpecialNo(5);

		// Yes
		genSpecialNo(1);
		for (int i = 3; i < 10; i += 2)
			genYes(10, i);
		
        genYes(5, 6);
		genYes(4, 8);

		// Random test
        for (int i = 3; i < 10; i += 2)
			genRandom2(10, i);
		
		// Random test
        for (int i = 3; i < 10; i += 2)
			genRandom3(10, i);
		
		// Random test
        for (int i = 3; i < 10; i += 2)
			genRandomSame(10, i);
		
        genRandom2(5, 6);
		genRandom2(4, 8);
        
		for (int i = 3; i < 10; i++)
			genRandom(i, MAX_VALUE / (int) Math.pow(10, (9 - i) / 2));
		
		for (int i = 0; i < 5; i++)
			genRandom(MAX_COUNT, MAX_VALUE);
		return;
	}
}
