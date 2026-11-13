import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

public class numbers_gen {

	public static void main(String[] args) throws IOException {
		int testn = 50;
		Random rand = new Random(25566);
		for (int test = 0; test < testn; test++) {
			PrintWriter out = new PrintWriter((test < 9 ? "0" : "")
					+ (test + 1));
			switch (test) {
			case 0:
				out.println("1 1 1");
				out.println("1");
				break;
			case 1:
				out.println("1 2 1");
				out.println("1");
				break;
			case 2:
				out.println("1 100000000 1");
				out.println("1");
				break;
			case 3:
				out.println("7 1234567 9");
				out.println("1234567");
				break;
			case 4:
				out.println("7 7654321 9");
				out.println("7654321");
				break;
			case 5:
				out.println("50000 100000000 9");
				for (int i = 0; i < 50000; i++) {
					out.print((i % 2));
				}
				out.println();
				break;
			case 6:
				out.println("50000 100000000 9");
				for (int i = 0; i < 50000; i++) {
					out.print(0);
				}
				out.println();
				break;
			case 7: {
				StringBuilder sb = new StringBuilder();
				int k = 0;
				while (true) {
					if (!sb.toString().contains(k + "")) {
						if (sb.length() + ("" + k).length() > 50000) {
							break;
						}
						sb.append(k + "");
					}
					k++;
				}
				out.println(sb.length() + " " + (k - 1) + " 9");
				out.println(sb);
				break;
			}

			case 8:
				out.println("50000 100000000 9");
				for (int i = 0; i < 50000; i++) {
					out.print(i % 10);
				}
				out.println();
				break;
			case 47:
				out.println("50000 1010100 17");
				for (int i = 0; i < 50000; i++) {
					out.print(i % 2);
				}
				out.println();
				break;
			case 48:
				out.println("50000 100000000 18");
				for (int i = 0; i < 50000; i++) {
					out.print(i % 2);
				}
				out.println();
				break;
			case 49:
				out.println("50000 100000000 18");
				for (int i = 0; i < 50000; i++) {
					out.print(i % 10);
				}
				out.println();
				break;
			default:
				int n = 1 + rand.nextInt(50000);
				int c = rand.nextInt(100000001);
				int k = 1 + rand.nextInt(9);
				if (test >= 35) {
					k += 9;
				}
				out.println(n + " " + c + " " + k);
				for (int i = 0; i < n; i++) {
					out.print(rand.nextInt(10));
				}
				out.println();
				break;
			}
			out.close();
		}
	}
}
