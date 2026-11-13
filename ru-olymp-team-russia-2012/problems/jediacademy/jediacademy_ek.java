import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.io.OutputStream;
import java.io.PrintWriter;
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
public class jediacademy_ek {
	public static void main(String[] args) {
		InputStream inputStream;
		try {
			inputStream = new FileInputStream("jediacademy.in");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		OutputStream outputStream;
		try {
			outputStream = new FileOutputStream("jediacademy.out");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		InputReader in = new InputReader(inputStream);
		OutputWriter out = new OutputWriter(outputStream);
		JediAcademy solver = new JediAcademy();
		solver.solve(1, in, out);
		out.close();
	}
}

class JediAcademy {
	public void solve(int testNumber, InputReader in, OutputWriter out) {
		int count = in.readInt();
		int[] type = new int[count];
		int[][] requirements = new int[count][];
		int totalRequirements = 0;
		for (int i = 0; i < count; i++) {
			type[i] = in.readInt() - 1;
			int requirementCount = in.readInt();
			totalRequirements += requirementCount;
			requirements[i] = IOUtils.readIntArray(in, requirementCount);
		}
		MiscUtils.decreaseByOne(requirements);
		int moveTime = in.readInt();
		int learnTime = in.readInt();
		int[] from = new int[totalRequirements];
		int[] to = new int[totalRequirements];
		int k = 0;
		for (int i = 0; i < count; i++) {
			for (int j : requirements[i]) {
				from[k] = j;
				to[k++] = i;
			}
		}
		int[][] requiredTo = GraphUtils.buildSimpleOrientedGraph(count, from, to);
		int answer = Integer.MAX_VALUE;
		for (int i = 0; i < 2; i++) {
			int learnRemaining = count;
			int[][] queue = new int[2][count];
			int[] start = new int[2];
			int[] end = new int[2];
			int[] remaining = new int[count];
			for (int j = 0; j < count; j++)
				remaining[j] = requirements[j].length;
			for (int j = 0; j < count; j++) {
				if (remaining[j] == 0)
					queue[type[j]][end[type[j]]++] = j;
			}
			int current = 0;
			int curType = i;
			while (learnRemaining != 0) {
				current += moveTime;
				for (; start[curType] < end[curType]; start[curType]++) {
					current += learnTime;
					learnRemaining--;
					for (int j : requiredTo[queue[curType][start[curType]]]) {
						remaining[j]--;
						if (remaining[j] == 0)
							queue[type[j]][end[type[j]]++] = j;
					}
				}
				curType = 1 - curType;
			}
			answer = Math.min(answer, current);
		}
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

class IOUtils {

	public static int[] readIntArray(InputReader in, int size) {
		int[] array = new int[size];
		for (int i = 0; i < size; i++)
			array[i] = in.readInt();
		return array;
	}

	}

class MiscUtils {

	public static void decreaseByOne(int[]...arrays) {
		for (int[] array : arrays) {
			for (int i = 0; i < array.length; i++)
				array[i]--;
		}
	}

	}

class GraphUtils {

	public static int[][] buildOrientedGraph(int vertexCount, int[] from, int[] to) {
		int edgeCount = from.length;
		int[] degree = new int[vertexCount];
		for (int i = 0; i < edgeCount; i++)
			degree[from[i]]++;
		int[][] graph = new int[vertexCount][];
		for (int i = 0; i < vertexCount; i++)
			graph[i] = new int[degree[i]];
		for (int i = 0; i < edgeCount; i++)
			graph[from[i]][--degree[from[i]]] = i;
		return graph;
	}

	public static int otherVertex(int vertex, int from, int to) {
		return from + to - vertex;
	}

	public static int[][] buildSimpleOrientedGraph(int vertexCount, int[] from, int[] to) {
		int[][] graph = buildOrientedGraph(vertexCount, from, to);
		simplifyGraph(from, to, graph);
		return graph;
	}

	private static void simplifyGraph(int[] from, int[] to, int[][] graph) {
		for (int i = 0; i < graph.length; i++) {
			for (int j = 0; j < graph[i].length; j++) {
				graph[i][j] = otherVertex(i, from[graph[i][j]], to[graph[i][j]]);
			}
		}
	}
}

