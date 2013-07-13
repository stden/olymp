import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.io.OutputStream;
import java.util.RandomAccess;
import java.io.PrintWriter;
import java.util.AbstractList;
import java.io.Writer;
import java.util.List;
import java.io.IOException;
import java.util.Arrays;
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
public class odd_ek {
	public static void main(String[] args) {
		InputStream inputStream;
		try {
			inputStream = new FileInputStream("odd.in");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		OutputStream outputStream;
		try {
			outputStream = new FileOutputStream("odd.out");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		InputReader in = new InputReader(inputStream);
		OutputWriter out = new OutputWriter(outputStream);
		Odd solver = new Odd();
		solver.solve(1, in, out);
		out.close();
	}
}

class Odd {
	private boolean[] visited;
	private int[] degree;
	private int[][] graph;
	private int[] from, to;
	private int[] answer;
	private int size;

	public void solve(int testNumber, InputReader in, OutputWriter out) {
		int count = in.readInt();
		int edgeCount = in.readInt();
		from = new int[edgeCount];
		to = new int[edgeCount];
		IOUtils.readIntArrays(in, from, to);
		MiscUtils.decreaseByOne(from, to);
		graph = GraphUtils.buildGraph(count, from, to);
		degree = new int[count];
		for (int i : from)
			degree[i]++;
		for (int i : to)
			degree[i]++;
		visited = new boolean[count];
		answer = new int[count];
		int[] vertex = new int[count];
		int[] edge = new int[count];
		boolean[] value = new boolean[count];
		int[] index = new int[count];
		for (int i = 0; i < count; i++) {
			if (!visited[i]) {
				int size = 1;
				vertex[0] = i;
				edge[0] = -1;
				index[0] = 0;
				value[0] = (degree[i] & 1) == 0;
				while (size != 0) {
					visited[vertex[size - 1]] = true;
					if (index[size - 1] == degree[vertex[size - 1]]) {
						if (value[size - 1]) {
							answer[this.size++] = edge[size - 1];
							if (size != 1)
								value[size - 2] = !value[size - 2];
						}
						size--;
					} else {
						int newEdge = graph[vertex[size - 1]][index[size - 1]++];
						int newVertex = GraphUtils.otherVertex(vertex[size - 1], from[newEdge], to[newEdge]);
						if (visited[newVertex])
							continue;
						vertex[size] = newVertex;
						edge[size] = newEdge;
						index[size] = 0;
						value[size] = (degree[newVertex] & 1) == 0;
						size++;
					}
				}
				if (value[0]) {
					out.printLine(-1);
					return;
				}
			}
		}
		out.printLine(edgeCount - size);
		answer = Arrays.copyOf(answer, size);
		Arrays.sort(answer);
		int j = 0;
		int k = 0;
		int[] result = new int[edgeCount - size];
		for (int i = 0; i < edgeCount; i++) {
			if (j == size || answer[j] != i)
				result[k++] = i + 1;
			else
				j++;
		}
		out.printLine(Array.wrap(result).toArray());
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

	public static void readIntArrays(InputReader in, int[]... arrays) {
		for (int i = 0; i < arrays[0].length; i++) {
			for (int j = 0; j < arrays.length; j++)
				arrays[j][i] = in.readInt();
		}
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
	public static int[][] buildGraph(int vertexCount, int[] from, int[] to) {
		int edgeCount = from.length;
		int[] degree = new int[vertexCount];
		for (int i = 0; i < edgeCount; i++) {
			degree[from[i]]++;
			degree[to[i]]++;
		}
		int[][] graph = new int[vertexCount][];
		for (int i = 0; i < vertexCount; i++)
			graph[i] = new int[degree[i]];
		for (int i = 0; i < edgeCount; i++) {
			graph[from[i]][--degree[from[i]]] = i;
			graph[to[i]][--degree[to[i]]] = i;
		}
		return graph;
	}

	public static int otherVertex(int vertex, int from, int to) {
		return from + to - vertex;
	}

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

