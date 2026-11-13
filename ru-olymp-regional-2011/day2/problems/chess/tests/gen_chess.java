import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

public class gen_chess {

	static PrintWriter log;

	public static void main(String[] args) throws IOException {
		log = new PrintWriter("tests.desc");
		genGroup1();
		genGroup2();
		log.close();
	}

	static Random rand = new Random(12675473);

	private static void genGroup1() throws IOException {
		for (int test = 1; test <= 25; test++) {
			log.print("тест " + (test / 10) + "" + (test % 10) + " (первая группа тестов): ");
			PrintWriter out = new PrintWriter((test / 10) + "" + (test % 10));
			switch (test) {
			case 1:
				log.println("1 1 1 1 0");
				out.println("1 1 1 1 0");
				break;
			case 2:
				log.println("1 1 1 1 1");
				out.println("1 1 1 1 1");
				break;
			case 3:
			case 4:
			case 5:
			case 6:
				log.println("2 2 " + (1 + test % 2) + " " + ((test - 1) / 2)
						+ " " + rand.nextInt(2));
				out.println("2 2 " + (1 + test % 2) + " " + ((test - 1) / 2)
						+ " " + rand.nextInt(2));
				break;
			case 7:
				log.println("3 3 2 2 0");
				out.println("3 3 2 2 0");
				break;
			case 8:
				log.println("3 3 3 3 1");
				out.println("3 3 3 3 1");
				break;
			case 9:
				log.println("3 3 1 3 0");
				out.println("3 3 1 3 0");
				break;
			case 10:
				log.println("3 3 2 3 0");
				out.println("3 3 2 3 0");
				break;
			case 11:
				log.println("99 99 99 99 0");
				out.println("99 99 99 99 0");
				break;
			default:
				int n = 1 + rand.nextInt(100);
				int m = 1 + rand.nextInt(100);
				if (test > 20) {
					n = 100;
					m = 100;
				}
				if (test > 22) {
					n = 99;
					m = 99;
				}
				int x = 1 + rand.nextInt(n);
				int y = 1 + rand.nextInt(m);
				int c = rand.nextInt(2);
				log.println(n + " " + m + " " + x + " " + y + " " + c
						+ " (небольшой случайный тест)");
				out.println(n + " " + m + " " + x + " " + y + " " + c);
				break;
			}
			out.close();
		}
	}

	private static void genGroup2() throws IOException {
		for (int test = 26; test <= 50; test++) {
			log.print("тест " + (test / 10) + "" + (test % 10) + " (вторая группа тестов): ");
			PrintWriter out = new PrintWriter((test / 10) + "" + (test % 10));
			switch (test) {
			case 26:
				log.println("1000000000 1000000000 1000000000 1000000000 1");
				out.println("1000000000 1000000000 1000000000 1000000000 1");
				break;
			case 27:
				log.println("1000000000 1000000000 1000000000 1000000000 0");
				out.println("1000000000 1000000000 1000000000 1000000000 0");
				break;
			case 28:
				log.println("1000000000 1000000000 1 1000000000 0");
				out.println("1000000000 1000000000 1 1000000000 0");
				break;
			case 29:
				log.println("999999999 999999999 999999999 999999999 1");
				out.println("999999999 999999999 999999999 999999999 1");
				break;
			case 30:
				log.println("999999999 999999999 1 378 0");
				out.println("999999999 999999999 1 378 0");
				break;
			default:
				int n = 500000000 + rand.nextInt(1000000001 - 500000000);
				if (n % 2 == 0) {
					n--;
				}
				int m = 1 + rand.nextInt(1000000000);
				while (m % 2 == 0 || n * m % 2 == 1) {
					m = 1 + rand.nextInt(1000000000);
				}
				int x = 1 + rand.nextInt(n);
				int y = 1 + rand.nextInt(m);
				int c = rand.nextInt(2);
				log.println(n + " " + m + " " + x + " " + y + " " + c + " (большой случайный тест)");
				out.println(n + " " + m + " " + x + " " + y + " " + c);
				break;
			}
			out.close();
		}
	}

}
