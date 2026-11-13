import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.io.OutputStream;
import java.util.RandomAccess;
import java.io.PrintWriter;
import java.util.AbstractList;
import java.io.Writer;
import java.util.List;
import java.io.IOException;
import java.util.InputMismatchException;
import java.util.ArrayList;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.math.BigInteger;
import java.util.Collections;
import java.io.InputStream;

/**
 * Built using CHelper plug-in
 * Actual solution is at the top
 * @author Egor Kulikov (egor@egork.net)
 */
public class forest_ek {
	public static void main(String[] args) {
		InputStream inputStream;
		try {
			inputStream = new FileInputStream("forest.in");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		OutputStream outputStream;
		try {
			outputStream = new FileOutputStream("forest.out");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		InputReader in = new InputReader(inputStream);
		OutputWriter out = new OutputWriter(outputStream);
		Forest solver = new Forest();
		solver.solve(1, in, out);
		out.close();
	}
}

class Forest {
	public void solve(int testNumber, InputReader in, OutputWriter out) {
		int rowCount = in.readInt();
		int columnCount = in.readInt();
		int[][] current = IOUtils.readIntTable(in, rowCount, columnCount);
		int answer = 0;
		int[] toCheckRow = new int[rowCount * columnCount];
		int[] toCheckColumn = new int[rowCount * columnCount];
		int[] growRow = new int[rowCount * columnCount];
		int[] growColumn = new int[rowCount * columnCount];
		int size = rowCount * columnCount;
		for (int i = 0; i < rowCount; i++) {
			for (int j = 0; j < columnCount; j++) {
				toCheckRow[i * columnCount + j] = i;
				toCheckColumn[i * columnCount + j] = j;
			}
		}
		int[][] checked = new int[rowCount][columnCount];
		while (true) {
			int growSize = 0;
			for (int i = 0; i < size; i++) {
				int row = toCheckRow[i];
				int column = toCheckColumn[i];
				for (int j = 0; j < 4; j++) {
					int nRow = row + MiscUtils.DX4[j];
					int nColumn = column + MiscUtils.DY4[j];
					if (nRow >= 0 && nRow < rowCount && nColumn >= 0 && nColumn < columnCount &&
						current[nRow][nColumn] - current[row][column] == 1)
					{
						growRow[growSize] = row;
						growColumn[growSize++] = column;
						break;
					}
				}
			}
			if (growSize == 0)
				break;
			answer++;
			size = 0;
			for (int i = 0; i < growSize; i++) {
				int row = growRow[i];
				int column = growColumn[i];
				current[row][column]++;
				for (int j = 0; j < 4; j++) {
					int nRow = row + MiscUtils.DX4[j];
					int nColumn = column + MiscUtils.DY4[j];
					if (nRow >= 0 && nRow < rowCount && nColumn >= 0 && nColumn < columnCount && checked[nRow][nColumn] != answer) {
						toCheckRow[size] = nRow;
						toCheckColumn[size++] = nColumn;
						checked[nRow][nColumn] = answer;
					}
				}
				if (checked[row][column] != answer) {
					toCheckRow[size] = row;
					toCheckColumn[size++] = column;
					checked[row][column] = answer;
				}
			}
		}
		out.printLine(answer);
		for (int[] row : current)
			out.printLine(Array.wrap(row).toArray());
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

class IOUtils {

	public static int[] readIntArray(InputReader in, int size) {
		int[] array = new int[size];
		for (int i = 0; i < size; i++)
			array[i] = in.readInt();
		return array;
	}

	public static int[][] readIntTable(InputReader in, int rowCount, int columnCount) {
		int[][] table = new int[rowCount][];
		for (int i = 0; i < rowCount; i++)
			table[i] = readIntArray(in, columnCount);
		return table;
	}

	}

class MiscUtils {
	public static final int[] DX4 = {1, 0, -1, 0};
	public static final int[] DY4 = {0, -1, 0, 1};

	}

abstract class Array<T> extends AbstractList<T> implements RandomAccess {

	public static List<Integer> wrap(int...array) {
		return new IntArray(array);
	}

	protected static class IntArray extends Array<Integer> {
		protected final int[] array;

		protected IntArray(int[] array) {
			this.array = array;
		}

		public int size() {
			return array.length;
		}

		public Integer get(int index) {
			return array[index];
		}

		public Integer set(int index, Integer value) {
			int result = array[index];
			array[index] = value;
			return result;
		}
	}

	}

