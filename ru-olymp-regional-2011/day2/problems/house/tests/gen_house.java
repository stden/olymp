import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

public class gen_house {
	static PrintWriter log;

	public static void main(String[] args) throws IOException {
		log = new PrintWriter("tests.desc");
		genGroup1();
		genGroup2();
		genGroup3();
		genGroup4();
		log.close();
	}

	static final int MEGA = 10000;

	private static void genGroup1() throws IOException {
		for (int test = 1; test <= 10; test++) {
			PrintWriter out = new PrintWriter((test / 10) + "" + (test % 10));
			log.print("тест " + (test / 10) + "" + (test % 10)
					+ " (первая группа тестов): ");
			if (test == 10) {
				int x = -1000 + rand.nextInt(2001);
				int y = -1000 + rand.nextInt(2001);
				log.println("сетка 50 на 50 вокруг (" + x + "; " + y + ")");
				out.println("102");
				for (int i = -25; i <= 25; i++) {
					out.println((x + i) + " " + y + " " + (i + x) + " "
							+ (y + 1));
				}
				for (int i = -25; i <= 25; i++) {
					out.println(x + " " + (i + y) + " " + (x + 1) + " "
							+ (y + i));
				}
				out.close();
				continue;
			}
			if (test == 9) {
				out.println("100");
				int x = rand.nextInt(10000);
				log.println("99 вертикальных прямых x = " + x
						+ " и прямая y = " + x);
				for (int i = 0; i < 99; i++) {
					int y1 = -10000 + rand.nextInt(20001);
					int y2 = -10000 + rand.nextInt(20000);
					if (y2 >= y1) {
						y2++;
					}
					out.println(x + " " + y1 + " " + x + " " + y2);
				}
				out.println(x + " " + x + " " + (x + 1) + " " + x);
				out.close();
				continue;
			}
			if (test == 8) {
				out.println("100");
				int x = -10000 + rand.nextInt(20001);
				int y = -10000 + rand.nextInt(20001);
				log.println("100 прямых. половина x = " + x + ", половина y = "
						+ y);
				for (int i = 0; i < 100; i++) {
					int y1 = -10000 + rand.nextInt(20001);
					int y2 = -10000 + rand.nextInt(20000);
					if (y2 >= y1) {
						y2++;
					}
					if (rand.nextBoolean()) {
						out.println(x + " " + y1 + " " + x + " " + y2);
					} else {
						out.println(y1 + " " + y + " " + y2 + " " + y);
					}
				}
				out.close();
				continue;
			}
			int n = 5 + rand.nextInt(6);
			if (test > 7) {
				n = 100;
			}
			log.println("случайный тест." + n + " прямых.");
			out.println(n);
			for (int i = 0; i < n; i++) {
				int x = -10000 + rand.nextInt(20001);
				int y1 = -10000 + rand.nextInt(20001);
				int y2 = -10000 + rand.nextInt(20000);
				if (y2 >= y1) {
					y2++;
				}
				if (rand.nextBoolean()) {
					out.println(x + " " + y1 + " " + x + " " + y2);
				} else {
					out.println(y1 + " " + x + " " + y2 + " " + x);
				}
			}
			out.close();
		}
	}

	private static void genGroup2() throws IOException {
		for (int test = 11; test <= 20; test++) {
			log.print("тест " + (test / 10) + "" + (test % 10)
					+ " (вторая группа тестов): ");
			PrintWriter out = new PrintWriter((test / 10) + "" + (test % 10));
			if (test == 11) {
				log.println("100 прямых x = y");
				out.println("100");
				for (int i = 0; i < 100; i++) {
					out.println("-10000 -10000 10000 10000");
				}
				out.close();
				continue;
			}
			if (test == 12) {
				log.println("две прямые на максимальном расстоянии");
				out.println("2");
				out.println("-10000 -9999 -9999 -10000");
				out.println("10000 9999 9999 10000");
				out.close();
				continue;
			}
			if (test == 13) {
				log.println("одна прямая");
				out.println("1");
				out.println("255 566 21 13");
				out.close();
				continue;
			}
			int n = 50 + rand.nextInt(51);
			if (test > 15) {
				n = 100;
			}
			log.println("случайный тест. " + n + " прямых.");
			out.println(n);
			int dx = 1 + rand.nextInt(10000);
			int dy = 1 + rand.nextInt(10000);
			for (int i = 0; i < n; i++) {
				int x = -10000 + rand.nextInt(20001 - dx);
				int y = -10000 + rand.nextInt(20001 - dy);
				int k = Math.min((10000 - x) / dx, (10000 - y) / dy);
				k = 1 + rand.nextInt(k);
				int x2 = x + dx * k;
				int y2 = y + dy * k;
				if (rand.nextBoolean()) {
					out.println(x + " " + y + " " + x2 + " " + y2);
				} else {
					out.println(x2 + " " + y2 + " " + x + " " + y);
				}
			}
			out.close();
		}
	}

	private static int gcd(int a, int b) {
		a = Math.abs(a);
		b = Math.abs(b);
		while (b != 0) {
			int tmp = a % b;
			a = b;
			b = tmp;
		}
		return a;
	}

	private static void genGroup3() throws IOException {
		for (int test = 21; test <= 35; test++) {
			log.print("тест " + (test / 10) + "" + (test % 10)
					+ " (третья группа тестов): ");
			PrintWriter out = new PrintWriter((test / 10) + "" + (test % 10));
			if (test == 21) {
				int x = -1000 + rand.nextInt(2001);
				int y = -1000 + rand.nextInt(2001);
				log.println("100 прямых, пересекающихся в (" + x + "; " + y
						+ ")");
				out.println("100");
				for (int i = 0; i < 100; i++) {
					int dx = -1000 + rand.nextInt(2001);
					int dy = -1000 + rand.nextInt(2001);
					while (dx == 0 && dy == 0) {
						dx = -1000 + rand.nextInt(2001);
						dy = -1000 + rand.nextInt(2001);
					}
					int g = gcd(dx, dy);
					dx /= g;
					dy /= g;
					int k1 = -9 + rand.nextInt(19);
					int k2 = -9 + rand.nextInt(19);
					while (k1 == k2) {
						k2 = -9 + rand.nextInt(19);
					}
					out.println((x + k1 * dx) + " " + (y + k1 * dy) + " "
							+ (x + k2 * dx) + " " + (y + k2 * dy));
				}
				out.close();
				continue;
			}
			int MAX = 1000;
			if (test <= 23) {
				int x = -MAX + rand.nextInt(2 * MAX + 1);
				int y = -MAX + rand.nextInt(2 * MAX + 1);
				log.println("50 пар параллельных прямых, равноудаленных от точки ("
						+ x + ", " + y + ")");
				out.println("100");
				for (int i = 0; i < 50; i++) {
					int dx = -MAX + rand.nextInt(2 * MAX + 1);
					int dy = -MAX + rand.nextInt(2 * MAX + 1);
					while (dx == 0 && dy == 0) {
						dx = -MAX + rand.nextInt(2 * MAX + 1);
						dy = -MAX + rand.nextInt(2 * MAX + 1);
					}
					int x2 = x + dx;
					int y2 = y + dy;
					int x3 = x - dx;
					int y3 = y - dy;
					dx = 0;
					dy = 0;
					while (dx == 0 && dy == 0) {
						dx = -MAX + rand.nextInt(2 * MAX + 1);
						dy = -MAX + rand.nextInt(2 * MAX + 1);
					}
					out.println(x2 + " " + y2 + " " + (x2 + dx) + " "
							+ (y2 + dy));
					out.println(x3 + " " + y3 + " " + (x3 + dx) + " "
							+ (y3 + dy));
				}
				out.close();
				continue;
			}
			// if (test == 24) {
			// out.println("2");
			// out.println("-2752 5430 -6016 -7784");
			// out.println("4775 -3832 7791 8378");
			// out.close();
			// continue;
			// }
			if (test == 25) {
				log.println("2; " + "-10000 10000 10000 10000; "
						+ "-10000 -10000 10000 -9999");
				out.println("2");
				out.println("-10000 10000 10000 10000");
				out.println("-10000 -10000 10000 -9999");
				out.close();
				continue;
			}
			if (test == 26) {
				log.println("четыре прямые на максимальном расстоянии");
				out.println("4");
				out.println("-10000 -9999 -9999 -10000");
				out.println("10000 9999 9999 10000");
				out.println("-10000 9999 -9999 10000");
				out.println("10000 -9999 9999 -10000");
				out.close();
				continue;
			}
			int n = 2 + rand.nextInt(99);
			if (test > 30) {
				n = 100;
			}
			log.println("случайный тест. " + n + " прямых.");
			out.println(n);
			for (int i = 0; i < n; i++) {
				int x1 = -10000 + rand.nextInt(20001);
				int y1 = -10000 + rand.nextInt(20001);
				int x2 = -10000 + rand.nextInt(20001);
				int y2 = -10000 + rand.nextInt(20001);
				while (x1 == x2 && y1 == y2) {
					x2 = -10000 + rand.nextInt(20001);
					y2 = -10000 + rand.nextInt(20001);
				}
				out.println(x1 + " " + y1 + " " + x2 + " " + y2);
			}
			out.close();
		}
	}

	private static void genGroup4() throws IOException {
		for (int test = 36; test <= 50; test++) {
			log.print("тест " + (test / 10) + "" + (test % 10)
					+ " (четвертая группа тестов): ");
			PrintWriter out = new PrintWriter((test / 10) + "" + (test % 10));
			if (test == 36) {
				int n = MEGA;
				int x = -1000 + rand.nextInt(2001);
				int y = -1000 + rand.nextInt(2001);
				log.println(MEGA + " прямых, пересекающихся в (" + x + "; " + y
						+ ")");
				out.println(n);
				for (int i = 0; i < n; i++) {
					int dx = -1000 + rand.nextInt(2001);
					int dy = -1000 + rand.nextInt(2001);
					while (dx == 0 && dy == 0) {
						dx = -1000 + rand.nextInt(2001);
						dy = -1000 + rand.nextInt(2001);
					}
					int g = gcd(dx, dy);
					dx /= g;
					dy /= g;
					int k1 = -9 + rand.nextInt(19);
					int k2 = -9 + rand.nextInt(19);
					while (k1 == k2) {
						k2 = -9 + rand.nextInt(19);
					}
					out.println((x + k1 * dx) + " " + (y + k1 * dy) + " "
							+ (x + k2 * dx) + " " + (y + k2 * dy));
				}
				out.close();
				continue;
			}
			if (test == 37) {
				int n = MEGA;
				int x = -10 + rand.nextInt(21);
				int y = -10 + rand.nextInt(21);
				int r = 5000;
				out.println(n);
				double da = Math.PI * 2 / n;
				log.println(MEGA + " прямых, нарасстоянии близком к " + r
						+ " от точки (" + x + "; " + y + ")");
				for (int i = 0; i < n; i++) {
					int dx = (int) Math.round(Math.cos(da * i) * r)
							+ rand.nextInt(5);
					int dy = (int) Math.round(Math.sin(da * i) * r)
							+ rand.nextInt(5);
					out.println((x + dx - dy) + " " + (y + dy + dx) + " "
							+ (x + dx + dy) + " " + (y + dy - dx));
				}
				out.close();
				continue;
			}
			int n = 5000 + rand.nextInt(MEGA + 1 - 5000);
			if (test > 45) {
				n = MEGA;
			}
			log.println("случайный тест. " + n + " прямых.");
			out.println(n);
			for (int i = 0; i < n; i++) {
				int x1 = -10000 + rand.nextInt(20001);
				int y1 = -10000 + rand.nextInt(20001);
				int x2 = -10000 + rand.nextInt(20001);
				int y2 = -10000 + rand.nextInt(20001);
				while (x1 == x2 && y1 == y2) {
					x2 = -10000 + rand.nextInt(20001);
					y2 = -10000 + rand.nextInt(20001);
				}
				out.println(x1 + " " + y1 + " " + x2 + " " + y2);
			}
			out.close();
		}
	}

	static Random rand = new Random(32465271235134216L);
}
