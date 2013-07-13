// Задача "Клавиатура"
// Автор решения: Сергей Мельников, melnikov@rain.ifmo.ru

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

public class keyboard_sm extends Thread {

	void solve() throws NumberFormatException, IOException {
		int n = Integer.parseInt(in.readLine());
		myAssert(1 <= n && n <= 100);
		StringTokenizer st = new StringTokenizer(in.readLine());
		int c[] = new int[n];
		for (int i = 0; i < c.length; i++) {
			c[i] = Integer.parseInt(st.nextToken());
			myAssert(1 <= c[i] && c[i] <= 100000);
		}
		myAssert(!st.hasMoreTokens());
		int k = Integer.parseInt(in.readLine());
		st = new StringTokenizer(in.readLine());
		int p[] = new int[k];
		for (int i = 0; i < p.length; i++) {
			p[i] = Integer.parseInt(st.nextToken());
			myAssert(1 <= p[i] && p[i] <= n);
		}
		myAssert(!st.hasMoreTokens());
		for (int i = 0; i < p.length; i++) {
			c[p[i] - 1]--;
		}
		for (int i = 0; i < c.length; i++) {
			if (c[i] >= 0) {
				out.println("no");
			} else {
				out.println("yes");
			}
		}
	}

	void myAssert(boolean b) {
		if (!b)
			throw new AssertionError();
	}

	BufferedReader in;
	PrintWriter out;

	public void run() {
		try {
			in = new BufferedReader(new FileReader("keyboard.in"));
			out = new PrintWriter(new File("keyboard.out"));
			solve();
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public static void main(String[] args) {
		new keyboard_sm().start();
	}

}
