import java.io.*;

public class Validate {

	static final double max = 1000, min = 1;

	String validRebus(String s) {
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c != ' ' && c != '\'')
				if (c < 'a' || c > 'z')
					return "There is symbol, which is not quote, space or character in ['a'..'z']";
		}
		for (int i = 0; i < s.length() - 1; i++)
			if (s.charAt(i) == ' ' && s.charAt(i + 1) == ' ')
				return "There are more than one spece symbol between words";
		boolean wasWord = false;
		int charactersBefore = 0;
		int needDelete = 0;
		for (int i = 0; i < s.length(); i++) {
			if (s.charAt(i) != ' ') {
				if (s.charAt(i) == '\'')
					if (wasWord) {
						charactersBefore--;
						if (charactersBefore < 0)
							return "Need to delete more charecters than word length";
					} else {
						needDelete++;
					}
				else {
					wasWord = true;
					if (needDelete > 0) {
						needDelete--;
					} else {
						charactersBefore++;
					}
				}
			} else {
				wasWord = false;
				if (needDelete > 0)
					return "Need to delete more charecters than word length";
				charactersBefore = 0;
			}
		}
		return null;
	}

	public void run() {
		StrictScanner in = new StrictScanner(System.in);
		String s = in.readLine();
		String check = validRebus(s);
		ensure(check == null, check);
		in.nextLine();
		in.close();
	}

	public static void main(String[] args) {
		new Validate().run();
	}

	public class StrictScanner {
		private BufferedReader in;
		private String line = "";
		private int pos;
		private int lineNo;

		public StrictScanner(InputStream source) {
			in = new BufferedReader(new InputStreamReader(source));
			nextLine();
		}

		public void close() {
			ensure(line == null, "Extra data at the end of file");
			try {
				in.close();
			} catch (IOException e) {
				throw new AssertionError("Failed to close with " + e);
			}
		}

		public void nextLine() {
			ensure(line != null, "EOF");
			ensure(pos == line.length(), "Extra characters on line " + lineNo);
			try {
				line = in.readLine();
			} catch (IOException e) {
				throw new AssertionError("Failed to read line with " + e);
			}
			pos = 0;
			lineNo++;
		}

		public String readLine() {
			ensure(line != null, "EOF");
			ensure(line.length() > 0, "Empty line " + lineNo);
			if (pos == 0)
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " starts with whitespace");
			else {
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(pos) == ' ', "Wrong whitespace on line "
						+ lineNo);
				pos++;
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " has double whitespace");
			}
			pos = line.length();
			ensure(line.charAt(line.length() - 1) != ' ', "Line " + lineNo
					+ " ends with whitespace");
			return line;
		}

		public String next() {
			ensure(line != null, "EOF");
			ensure(line.length() > 0, "Empty line " + lineNo);
			if (pos == 0)
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " starts with whitespace");
			else {
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(pos) == ' ', "Wrong whitespace on line "
						+ lineNo);
				pos++;
				ensure(pos < line.length(), "Line " + lineNo + " is over");
				ensure(line.charAt(0) > ' ', "Line " + lineNo
						+ " has double whitespace");
			}
			StringBuilder sb = new StringBuilder();
			while (pos < line.length() && line.charAt(pos) > ' ')
				sb.append(line.charAt(pos++));
			return sb.toString();
		}

		public int nextInt() {
			String s = next();
			ensure(s.length() == 1 || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Integer.parseInt(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}

		public long nextLong() {
			String s = next();
			ensure(s.length() == 1 || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			try {
				return Long.parseLong(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}

		public double nextDouble() {
			String s = next();
			ensure(s.length() == 1 || s.startsWith("0.") || s.charAt(0) != '0',
					"Extra leading zero in number " + s + " on line " + lineNo);
			ensure(s.charAt(0) != '+', "Extra leading '+' in number " + s
					+ " on line " + lineNo);
			// check on three digit
			String[] ss = s.split(".");
			if (ss.length == 2) {
				ensure(ss[1].length() <= 3,
						"There is more than three digit after point");
			}
			// --------------------
			try {
				return Double.parseDouble(s);
			} catch (NumberFormatException e) {
				throw new AssertionError("Malformed number " + s + " on line "
						+ lineNo);
			}
		}
	}

	void ensure(boolean b, String message) {
		if (!b) {
			throw new AssertionError(message);
		}
	}

	void ensureLimits(long n, long from, long to, String name) {
		ensure(from <= n && n <= to, name + " must be from " + from + " to "
				+ to);
	}

}