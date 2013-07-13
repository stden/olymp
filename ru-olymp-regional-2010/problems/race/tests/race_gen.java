import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Random;

public class race_gen {

	public static String randString(Random rand, int n) {
		StringBuilder sb = new StringBuilder();
		while (n-- > 0) {
			int x = rand.nextInt(2 * 26);
			if (x < 26) {
				sb.append((char) (x + 'a'));
			} else {
				sb.append((char) (x - 26 + 'A'));
			}
		}
		return sb.toString();
	}

	public static void main(String[] args) throws IOException {
		Random rand = new Random(210934739092378465L);
		for (int test = 1; test <= 25; test++) {
			PrintWriter out = new PrintWriter((test < 10 ? "0" : "") + test);
			switch (test) {
			case 1:
				out.println("1 1");
				out.println("Akhi");
				out.println("127");
				break;
			case 2:
				out.println("2 1");
				out.println("a");
				out.println("128");
				out.println("A");
				out.println("127");
				break;
			case 3:
				out.println("2 100");
				out.println("a");
				for (int i = 0; i < 100; i++) {
					if (i > 0) {
						out.print(" ");
					}
					out.print(rand.nextBoolean() ? "1" : "257");
				}
				out.println();
				out.println("A");
				for (int i = 0; i < 100; i++) {
					if (i > 0) {
						out.print(" ");
					}
					out.print(rand.nextBoolean() ? "1" : "257");
				}
				out.println();
				break;
			case 4:
				out.println((2 * 26) + " 100");
				for (int j = 0; j < 26; j++) {
					out.println((char) (j + 'a'));
					int sum = 127;
					for (int i = 0; i < 100; i++) {
						if (i > 0) {
							out.print(" ");
						}
						int x = sum / (100 - i);
						sum -= x;
						out.print(x);
					}
					out.println();
				}
				for (int j = 0; j < 26; j++) {
					out.println((char) (j + 'A'));
					int sum = 127;
					for (int i = 0; i < 100; i++) {
						if (i > 0) {
							out.print(" ");
						}
						int x = sum / (100 - i);
						sum -= x;
						out.print(x);
					}
					out.println();
				}
				break;
			case 5:
				out.println((2 * 26) + " 100");
				for (int j = 0; j < 26; j++) {
					out.println("AAA" + (char) (j + 'a'));
					int sum = 127;
					ArrayList<Integer> al = new ArrayList<Integer>();
					for (int i = 0; i < 100; i++) {
						int x = sum / (100 - i);
						sum -= x;
						al.add(x);
					}
					Collections.shuffle(al);
					for (int i = 0; i < al.size(); i++) {
						if (i > 0) {
							out.print(" ");
						}
						out.print(al.get(i));
					}
					out.println();
				}
				for (int j = 0; j < 26; j++) {
					out.println("AA" + (char) (j + 'A'));
					int sum = 127;
					ArrayList<Integer> al = new ArrayList<Integer>();
					for (int i = 0; i < 100; i++) {
						int x = sum / (100 - i);
						sum -= x;
						al.add(x);
					}
					Collections.shuffle(al);
					for (int i = 0; i < al.size(); i++) {
						if (i > 0) {
							out.print(" ");
						}
						out.print(al.get(i));
					}
					out.println();
				}
				break;
			case 6:
			case 7:
			case 8:
			case 9:
			case 10: {
				int n = 1 + rand.nextInt(100);
				int m = 1 + rand.nextInt(100);
				int worst = m + 1 + rand.nextInt(127 - m);
				int winner = rand.nextInt(n);
				HashSet<String> hs = new HashSet<String>();
				out.println(n + " " + m);
				for (int i = 0; i < n; i++) {
					String s = randString(rand, 9);
					while (hs.contains(s)) {
						s = randString(rand, 9);
					}
					hs.add(s);
					out.println(s);
					int sum = worst - (i == winner ? 1 : 0);
					ArrayList<Integer> al = new ArrayList<Integer>();
					for (int j = 0; j < m; j++) {
						int x = sum / (m - j);
						sum -= x;
						al.add(x);
					}
					Collections.shuffle(al);
					for (int j = 0; j < al.size(); j++) {
						if (j > 0) {
							out.print(" ");
						}
						out.print(al.get(j));
					}
					out.println();
				}
			}
				break;
			case 11: {
				out.println("100 100");
				HashSet<String> hs = new HashSet<String>();
				for (int i = 0; i < 100; i++) {
					String s = randString(rand, 255);
					while (hs.contains(s)) {
						s = randString(rand, 255);
					}
					hs.add(s);
					out.println(s);
					for (int j = 0; j < 100; j++) {
						if (j > 0) {
							out.print(" ");
						}
						out.print("1000");
					}
					out.println();
				}
			}
				break;
			case 12: {
				out.println("100 100");
				HashSet<String> hs = new HashSet<String>();
				int x = rand.nextInt(100);
				for (int i = 0; i < 100; i++) {
					String s = randString(rand, 255);
					while (hs.contains(s)) {
						s = randString(rand, 255);
					}
					if (i == x && !hs.contains("AntonAkhi")) {
						s = "AntonAkhi";
					}
					hs.add(s);
					out.println(s);
					for (int j = 0; j < 100; j++) {
						if (j > 0) {
							out.print(" ");
						}
						if (i != x) {
							out.print("1000");
						} else {
							out.print("1");
						}
					}
					out.println();
				}
			}
				break;
			case 13: {
				out.println("100 100");
				HashSet<String> hs = new HashSet<String>();
				int x = rand.nextInt(100);
				for (int i = 0; i < 100; i++) {
					String s = randString(rand, 255);
					while (hs.contains(s)) {
						s = randString(rand, 255);
					}
					if (i == x && !hs.contains("AkhiAnton")) {
						s = "AkhiAnton";
					}
					hs.add(s);
					out.println(s);
					for (int j = 0; j < 100; j++) {
						if (j > 0) {
							out.print(" 255");
						} else {
							if (i == x) {
								out.print("255");
							} else {
								out.print("256");
							}
						}
					}
					out.println();
				}
			}
				break;
			case 14:
			case 15:
			case 16: {
				int n = 1 + rand.nextInt(100);
				if (test % 2 == 0) {
					n = 100;
				}
				int m = 1 + rand.nextInt(100);
				if (test / 15 == 1) {
					m = 100;
				}
				out.println(n + " " + m);
				HashSet<String> hs = new HashSet<String>();
				int x = rand.nextInt(n);
				int y = rand.nextInt(m);
				int z = rand.nextBoolean() ? 128 * 5 : 256 * 3;
				for (int i = 0; i < n; i++) {
					String s = randString(rand, 255);
					while (hs.contains(s)) {
						s = randString(rand, 255);
					}
					if (i == x && !hs.contains("Zu")) {
						s = "Zu";
					}
					hs.add(s);
					out.println(s);
					for (int j = 0; j < m; j++) {
						if (j > 0) {
							out.print(" ");
						}
						if (i == x && j == y) {
							out.print(z - 1);
						} else {
							out.print(z);
						}
					}
					out.println();
				}
			}
				break;

			case 17:
			case 18:
			case 19:
			case 20: {
				int m = 70 + rand.nextInt(31);
				out.println("2 " + m);
				out.println("PlayerOne");
				int ans = m + rand.nextInt(101 - m);
				{
					int sum = (1 << 16) + ans - 1;
					ArrayList<Integer> al = new ArrayList<Integer>();
					for (int j = 0; j < m; j++) {
						int x = sum / (m - j);
						sum -= x;
						al.add(x);
					}
					Collections.shuffle(al);
					for (int j = 0; j < al.size(); j++) {
						if (j > 0) {
							out.print(" ");
						}
						out.print(al.get(j));
					}
					out.println();
				}
				out.println("PlayerTwo");
				{
					int sum = ans;
					ArrayList<Integer> al = new ArrayList<Integer>();
					for (int j = 0; j < m; j++) {
						int x = sum / (m - j);
						sum -= x;
						al.add(x);
					}
					Collections.shuffle(al);
					for (int j = 0; j < al.size(); j++) {
						if (j > 0) {
							out.print(" ");
						}
						out.print(al.get(j));
					}
					out.println();
				}
			}

				break;

			default:
				int n = 1 + rand.nextInt(100);
				if (test % 2 == 0) {
					n = 100;
				}
				int m = 1 + rand.nextInt(100);
				if (test % 2 == 0) {
					m = 100;
				}
				out.println(n + " " + m);
				HashSet<String> hs = new HashSet<String>();
				for (int i = 0; i < n; i++) {
					String s = randString(rand, 1 + rand.nextInt(255));
					while (hs.contains(s)) {
						s = randString(rand, 1 + rand.nextInt(255));
					}
					hs.add(s);
					out.println(s);
					for (int j = 0; j < m; j++) {
						if (j > 0) {
							out.print(" ");
						}
						out.print(500 + rand.nextInt(501));
					}
					out.println();
				}
				break;
			}
			out.close();
		}
	}
}
