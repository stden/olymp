import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.util.Comparator;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Collection;
import java.util.List;
import java.io.IOException;
import java.util.Arrays;
import java.util.InputMismatchException;
import java.util.ArrayList;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.math.BigInteger;
import java.io.InputStream;

/**
 * Built using CHelper plug-in
 * Actual solution is at the top
 * @author Egor Kulikov (egor@egork.net)
 */
public class kitten_ek {
	public static void main(String[] args) {
		InputStream inputStream;
		try {
			inputStream = new FileInputStream("kitten.in");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		OutputStream outputStream;
		try {
			outputStream = new FileOutputStream("kitten.out");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		InputReader in = new InputReader(inputStream);
		OutputWriter out = new OutputWriter(outputStream);
		Kitten solver = new Kitten();
		solver.solve(1, in, out);
		out.close();
	}
}

class Kitten {
	private static final long MOD = (long) (1e9 + 7);

	public void solve(int testNumber, InputReader in, OutputWriter out) {
		int rowCount = in.readInt();
		int columnCount = in.readInt();
		int startRow = in.readInt() - 1;
		int startColumn = in.readInt() - 1;
		int kittenRow = in.readInt() - 1;
		int kittenColumn = in.readInt() - 1;
		int liftRow = in.readInt() - 1;
		int liftColumn = in.readInt() - 1;
		if (startRow > kittenRow || startRow == kittenRow && kittenRow > liftRow) {
			startRow = rowCount - 1 - startRow;
			kittenRow = rowCount - 1 - kittenRow;
			liftRow = rowCount - 1 - liftRow;
		}
		if (startColumn > kittenColumn || startColumn == kittenColumn && kittenColumn > liftColumn) {
			startColumn = columnCount - 1 - startColumn;
			kittenColumn = columnCount - 1 - kittenColumn;
			liftColumn = columnCount - 1 - liftColumn;
		}
		long[][] c = IntegerUtils.generateBinomialCoefficients(rowCount + columnCount, MOD);
		if (kittenRow <= liftRow && kittenColumn <= liftColumn) {
			out.printLine(c[kittenRow - startRow + kittenColumn - startColumn][kittenRow - startRow] *
				c[liftRow - kittenRow + liftColumn - kittenColumn][liftRow - kittenRow] % MOD);
			return;
		}
		if (kittenRow == startRow && kittenRow == liftRow) {
			int answer = Math.abs(startColumn - liftColumn);
			if (kittenRow != 0 && kittenRow != rowCount - 1)
				answer *= 2;
			out.printLine(answer);
			return;
		}
		if (kittenColumn == startColumn && kittenColumn == liftColumn) {
			int answer = Math.abs(startRow - liftRow);
			if (kittenColumn != 0 && liftColumn != columnCount - 1)
				answer *= 2;
			out.printLine(answer);
			return;
		}
		if (liftColumn >= kittenColumn) {
			int temp = liftColumn;
			liftColumn = liftRow;
			liftRow = temp;
			temp = kittenColumn;
			kittenColumn = kittenRow;
			kittenRow = temp;
			temp = startColumn;
			startColumn = startRow;
			startRow = temp;
			temp = columnCount;
			columnCount = rowCount;
			rowCount = temp;
		}
		if (liftRow >= kittenRow) {
			long answer = 0;
			if (startRow != kittenRow) {
				answer += c[kittenRow - startRow - 1 + kittenColumn - startColumn][kittenColumn - startColumn] *
					c[liftRow - kittenRow + kittenColumn - liftColumn][liftRow - kittenRow] % MOD;
			}
			if (liftRow != kittenRow) {
				answer += c[kittenRow - startRow + kittenColumn - startColumn][kittenColumn - startColumn] *
					c[liftRow - kittenRow + kittenColumn - liftColumn - 1][liftRow - kittenRow - 1] % MOD;
			}
			if (startRow != kittenRow && liftRow != kittenRow)
				answer -= c[liftRow - kittenRow + kittenColumn - liftColumn - 1][liftRow - kittenRow - 1] *
					c[kittenRow - startRow - 1 + kittenColumn - startColumn][kittenColumn - startColumn] % MOD;
			answer %= MOD;
			answer += MOD;
			answer %= MOD;
			out.printLine(answer);
			return;
		}
		if (startRow > liftRow || startRow == liftRow && startColumn < liftColumn) {
			int temp = startRow;
			startRow = liftRow;
			liftRow = temp;
			temp = startColumn;
			startColumn = liftColumn;
			liftColumn = temp;
		}
		if (startColumn >= liftColumn) {
			long[][] current = new long[kittenColumn + 1][kittenColumn + 1];
			if (startRow == liftRow)
				current[liftColumn][startColumn] = 1;
			else {
				for (int i = startColumn; i <= kittenColumn; i++)
					current[liftColumn][i] = c[i - startColumn + liftRow - startRow - 1][i - startColumn];
			}
			for (int i = liftRow; i < kittenRow; i++) {
				for (int j = startColumn; j <= kittenColumn; j++) {
					for (int k = liftColumn + 1; k < j; k++) {
						current[k][j] += current[k - 1][j];
						if (current[k][j] >= MOD)
							current[k][j] -= MOD;
					}
				}
				for (int j = liftColumn; j < kittenColumn; j++) {
					for (int k = j + 2; k <= kittenColumn; k++) {
						current[j][k] += current[j][k - 1];
						if (current[j][k] >= MOD)
							current[j][k] -= MOD;
					}
				}
			}
			long answer = 0;
			for (int i = liftColumn; i < kittenColumn; i++)
				answer += current[i][kittenColumn];
			answer %= MOD;
			out.printLine(answer);
			return;
		}
		long[][] current = new long[kittenColumn + 1][kittenColumn + 1];
		for (int i = startColumn; i < liftColumn; i++)
			current[i][liftColumn] = c[i - startColumn + liftRow - startRow - 1][i - startColumn];
		for (int i = liftRow; i < kittenRow; i++) {
			for (int j = liftColumn; j <= kittenColumn; j++) {
				for (int k = startColumn + 1; k < j; k++) {
					current[k][j] += current[k - 1][j];
					if (current[k][j] >= MOD)
						current[k][j] -= MOD;
				}
			}
			for (int j = startColumn; j < kittenColumn; j++) {
				for (int k = j + 2; k <= kittenColumn; k++) {
					current[j][k] += current[j][k - 1];
					if (current[j][k] >= MOD)
						current[j][k] -= MOD;
				}
			}
		}
		long answer = 0;
		for (int i = startColumn; i < kittenColumn; i++)
			answer += current[i][kittenColumn];
		current = new long[kittenColumn + 1][kittenColumn + 1];
		for (int i = liftColumn + 1; i <= kittenColumn; i++)
			current[liftColumn][i] = c[i - startColumn + liftRow - startRow - 1][i - startColumn];
		for (int i = liftRow; i < kittenRow; i++) {
			for (int j = liftColumn + 1; j <= kittenColumn; j++) {
				for (int k = liftColumn + 1; k < j; k++) {
					current[k][j] += current[k - 1][j];
					if (current[k][j] >= MOD)
						current[k][j] -= MOD;
				}
			}
			for (int j = liftColumn; j < kittenColumn; j++) {
				for (int k = j + 2; k <= kittenColumn; k++) {
					current[j][k] += current[j][k - 1];
					if (current[j][k] >= MOD)
						current[j][k] -= MOD;
				}
			}
		}
		for (int i = liftColumn; i < kittenColumn; i++)
			answer += current[i][kittenColumn];
		answer %= MOD;
		out.printLine(answer);
	}
}

class InputReader {

	private InputStream stream;
	private byte[] buf = new byte[1024];
	private int curChar;
	private int numChars;
	private SpaceCharFilter filter;

	public InputReader(InputStream stream) {
		this.stream = stream;
	}

	public int read() {
		if (numChars == -1)
			throw new InputMismatchException();
		if (curChar >= numChars) {
			curChar = 0;
			try {
				numChars = stream.read(buf);
			} catch (IOException e) {
				throw new InputMismatchException();
			}
			if (numChars <= 0)
				return -1;
		}
		return buf[curChar++];
	}

	public int readInt() {
		int c = read();
		while (isSpaceChar(c))
			c = read();
		int sgn = 1;
		if (c == '-') {
			sgn = -1;
			c = read();
		}
		int res = 0;
		do {
			if (c < '0' || c > '9')
				throw new InputMismatchException();
			res *= 10;
			res += c - '0';
			c = read();
		} while (!isSpaceChar(c));
		return res * sgn;
	}

	public boolean isSpaceChar(int c) {
		if (filter != null)
			return filter.isSpaceChar(c);
		return c == ' ' || c == '\n' || c == '\r' || c == '\t' || c == -1;
	}

	public interface SpaceCharFilter {
		public boolean isSpaceChar(int ch);
	}
}

class OutputWriter {
	private final PrintWriter writer;

	public OutputWriter(OutputStream outputStream) {
		writer = new PrintWriter(new BufferedWriter(new OutputStreamWriter(outputStream)));
	}

	public OutputWriter(Writer writer) {
		this.writer = new PrintWriter(writer);
	}

	public void print(Object...objects) {
		for (int i = 0; i < objects.length; i++) {
			if (i != 0)
				writer.print(' ');
			writer.print(objects[i]);
		}
	}

	public void printLine(Object...objects) {
		print(objects);
		writer.println();
	}

	public void close() {
		writer.close();
	}

	}

class IntegerUtils {

    public static long[][] generateBinomialCoefficients(int n, long module) {
		long[][] result = new long[n + 1][n + 1];
		if (module == 1)
			return result;
		for (int i = 0; i <= n; i++) {
			result[i][0] = 1;
			for (int j = 1; j <= i; j++) {
				result[i][j] = result[i - 1][j - 1] + result[i - 1][j];
				if (result[i][j] >= module)
					result[i][j] -= module;
			}
		}
		return result;
	}

	}

