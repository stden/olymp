import java.io.*;
import java.util.*;

public class TestsGen {
	static int testcount = 0;

	static Random random = new Random(3667332);
	static int maxlen = 100 * 1000;
	static int maxlinelen = 250;

	static void write() throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);

		out.close();
	}
	
	static char randLetter() {
		int n = random.nextInt(2 * 26 + 10);
		if (n < 26) {
			return (char) ('a' + n);
		} else if (n < 2 * 26) {
			return (char) ('A' + n - 26);
		} else {
			return (char) ('0' + n - 2 * 26);
		}
	}
	
	static String symbs = ",.?!-:'"; 
	
	static char randSymb() {
		int n = random.nextInt(symbs.length());
		return symbs.charAt(n);
	}
	
	static String randWord(int len) {
		String ret = "";
		while (len --> 0) {
			ret += randLetter();
		}
		return ret;
	}
	
	static void gen1(int w, int b, double spaceeps, boolean badstart) throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);
		ArrayList<String> text = new ArrayList<String>();
		int len = 0;
		boolean first = true;
		int lastlen = 0;
		int c = w;
		while (len < maxlen) {
			String line = "";
			int linelen = 0;
			if (!first && badstart) {
				int nc = c - lastlen;
				if (nc != 0) {
					nc = random.nextInt(nc + 1);
					while (len < maxlen && linelen < maxlinelen && nc > 0) {
						if (random.nextDouble() < spaceeps) {
							line += " ";
						} else {
							line += randSymb();
							nc--;
						}
						len++;
						linelen++;
					}
				}
			}
			while (len < maxlen && linelen < maxlinelen) {
				c = w;
				if (first) {
					c -= b;
				}
				c = Math.min(c, maxlen - len);
				c = Math.min(c, maxlinelen - linelen);
				int sl = random.nextInt(c) + 1;
				int l1 = random.nextInt(sl) + 1;
				int l2 = sl - l1;
				lastlen = sl;
				String word = randWord(l1);
				if (word.length() > 0) {
					first = false;
				} else {
					continue;
				}
				line += word;
				linelen += word.length();
				len += word.length();
				boolean divided = false;
				while (len < maxlen && linelen < maxlinelen && random.nextDouble() < spaceeps) {
					line += " ";
					linelen++;
					len++;
					divided = true;
				}
				while (len < maxlen && linelen < maxlinelen && l2 --> 0) {
					line += randSymb();
					linelen++;
					len++;
					divided = true;
					while (len < maxlen && linelen < maxlinelen && random.nextDouble() < spaceeps) {
						line += " ";
						linelen++;
						len++;
					}
				}
				while (len < maxlen && linelen < maxlinelen && random.nextDouble() < spaceeps) {
					line += " ";
					linelen++;
					len++;
					divided = true;
				}
				if (!divided && linelen < maxlinelen) {
					line += " ";
					linelen++;
					len++;
				}
			}
			text.add(line);
			len += 2;
		}
		out.println(w + " " + b);
		for (String s : text) {
			out.println(s);
		}
		out.close();
	}
	
	static void gen2(int w, int b, double pareps) throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);
		ArrayList<String> text = new ArrayList<String>();
		int len = 0;
		boolean first = true;
		while (len < maxlen) {
			String line = "";
			int linelen = 0;
			if (len < maxlen - 1 && random.nextDouble() < pareps) {
				text.add("");
				len += 2;
				first = true;
				continue;
			}
			boolean firstline = true;
			while (len < maxlen && linelen < maxlinelen) {
				if (!firstline) {
					line += " ";
					len++;
					linelen++;
				}
				int c = w;
				if (first) {
					c -= b;
				}
				c = Math.min(c, maxlen - len);
				c = Math.min(c, maxlinelen - linelen);
				if (c == 0) {
					break;
				}
				int sl = random.nextInt(c) + 1;
				int l1 = random.nextInt(sl) + 1;
				int l2 = sl - l1;
				String word = randWord(l1);
				if (word.length() > 0) {
					first = false;
					firstline = false;
				} else {
					continue;
				}
				line += word;
				linelen += word.length();
				len += word.length();
				while (len < maxlen && linelen < maxlinelen && l2 --> 0) {
					line += randSymb();
					linelen++;
					len++;
				}
			}
			text.add(line);
			len += 2;
		}
		out.println(w + " " + b);
		for (String s : text) {
			out.println(s);
		}
		out.close();
	}

	static void gen3(int w, int b, double pareps, double spaceeps, boolean badstart) throws IOException {
		PrintWriter out = new PrintWriter(String.format("%02d", ++testcount));
		System.out.println("Generating test #" + testcount);
		ArrayList<String> text = new ArrayList<String>();
		int len = 0;
		boolean first = true;
		int c = w;
		int lastlen = 0;
		while (len < maxlen) {
			String line = "";
			int linelen = 0;
			if (len < maxlen - 1 && random.nextDouble() < pareps) {
				text.add("");
				len += 2;
				first = true;
				continue;
			}
			if (!first && badstart) {
				int nc = c - lastlen;
				if (nc != 0) {
					nc = random.nextInt(nc + 1);
					while (len < maxlen && linelen < maxlinelen && nc > 0) {
						if (random.nextDouble() < spaceeps) {
							line += " ";
						} else {
							line += randSymb();
							nc--;
						}
						len++;
						linelen++;
					}
				}
			}
			while (len < maxlen && linelen < maxlinelen) {
				c = w;
				if (first) {
					c -= b;
				}
				c = Math.min(c, maxlen - len);
				c = Math.min(c, maxlinelen - linelen);
				if (c == 0) {
					break;
				}
				int sl = random.nextInt(c) + 1;
				int l1 = random.nextInt(sl) + 1;
				int l2 = sl - l1;
				lastlen = sl;
				String word = randWord(l1);
				if (word.length() > 0) {
					first = false;
				} else {
					continue;
				}
				line += word;
				linelen += word.length();
				len += word.length();
				boolean divided = false;
				while (len < maxlen && linelen < maxlinelen && random.nextDouble() < spaceeps) {
					line += " ";
					linelen++;
					len++;
					divided = true;
				}
				while (len < maxlen && linelen < maxlinelen && l2 --> 0) {
					line += randSymb();
					linelen++;
					len++;
					divided = true;
					while (len < maxlen && linelen < maxlinelen && random.nextDouble() < spaceeps) {
						line += " ";
						linelen++;
						len++;
					}
				}
				while (len < maxlen && linelen < maxlinelen && random.nextDouble() < spaceeps) {
					line += " ";
					linelen++;
					len++;
					divided = true;
				}
				if (!divided && linelen < maxlinelen) {
					line += " ";
					linelen++;
					len++;
				}
			}
			text.add(line);
			if (line.length() > maxlinelen) {
				maxlinelen += 0;
			}
			len += 2;
		}
		out.println(w + " " + b);
		for (String s : text) {
			out.println(s);
		}
		out.close();
	}

	public static void main(String[] args) throws IOException {
		while (new File(String.format("%02d.t", testcount + 1)).exists()) {
			testcount++;
		}
		//3
		gen1(100, 8, 0.3, true);
		gen1(100, 1, 0, false);
		gen1(5, 1, 0.5, true);
		gen1(5, 4, 0.7, true);
		gen1(30, 7, 0.2, false);
		//8
		gen2(100, 8, 0.4);
		gen2(100, 1, 0.6);
		gen2(5, 4, 0.05);
		gen2(5, 2, 0.3);
		gen2(30, 6, 0.9);
		//13
		gen3(100, 8, 0.3, 0.5, true);
		gen3(100, 1, 0.05, 0, false);
		gen3(5, 2, 0.5, 0, false);
		gen3(5, 3, 0.05, 0.7, true);
		gen3(30, 5, 0.3, 0.3, true);
		gen3(50, 4, 0.5, 0.5, false);
		gen3(10, 1, 0.9, 0.9, true);
	}

}
