import java.io.*;
import java.util.*;

public class Gen {

	static int done = 0;

	static final Random rnd = new Random(556668949239L);
	static final int maxLen = 100;

	static ArrayList<String> ans;

	static void print() {
		done++;
		System.err.println(done);
		PrintWriter out;

		try {
			if (done < 10)
				out = new PrintWriter("../tests/0" + String.valueOf(done));
			else
				out = new PrintWriter("../tests/" + String.valueOf(done));
			for (int i = 0; i < ans.size() - 1; i++)
				out.print(ans.get(i) + " ");
			out.println(ans.get(ans.size() - 1));
			ans.clear();
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static void genSample() {
		ans.add("team ''''school ''olympiad'''");
		print();
	}

	static String randomWord(int len) {
		int wordLen = (len + 1) / 2 + rnd.nextInt(1 + len / 2);
		wordLen = Math.min(wordLen, len);
		int totalQuotes = len - wordLen;
		int startQuotes = rnd.nextInt(totalQuotes + 1);
		char[] word = new char[len];
		Arrays.fill(word, '\'');
		for (int i = startQuotes; i < startQuotes + wordLen; i++)
			word[i] = (char) ('a' + rnd.nextInt(26));
		return new String(word);
	}

	public static void genRandomTest(int len, int maxWordLen) {
		int totalLen = -1;
		while (totalLen < len) {
			String newStr = randomWord(Math.min(rnd.nextInt(maxWordLen) + 1, len - totalLen - 1));
			if (totalLen + newStr.length() + 1 > maxLen || newStr.length() == 0) 
				break;
			totalLen += newStr.length() + 1;
			ans.add(newStr);
		}
		print();
	}

	public static void main(String[] args) throws IOException {
		File dir = new File("../tests");
		if (!dir.exists())
			dir.mkdir();
		done = 0;

		ans = new ArrayList<String>();
		// Sample
		genSample();
		
		for (int i = 0; i < 5; i++)
			genRandomTest(Math.min(10, maxLen), 5);
		for (int i = 0; i < 10; i++)
			genRandomTest(maxLen, 20);
		for (int i = 0; i < 10; i++)
			genRandomTest(maxLen, maxLen);
		for (int i = 0; i < 2; i++)
			genRandomTest(maxLen, 1);
		for (int i = 0; i < 5; i++)
			genRandomTest(maxLen, 2);
		for (int i = 0; i < 5; i++)
			genRandomTest(maxLen, 3);
	}
}
