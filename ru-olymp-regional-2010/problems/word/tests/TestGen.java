import java.io.*;
import java.util.*;

public class TestGen {
    static int nTests = 0;
    static final Random random = new Random(324121211212313L);

    static void write(String word, String... dict) {
        String filename = String.format("%02d", nTests + 1);
        PrintWriter out = null;
        try {
            out = new PrintWriter(filename);
        } catch (IOException ex) {
            ex.printStackTrace();
            return;
        }
        out.println(dict.length + " " + dict[0].length());
        for (String s : dict) {
            out.println(s);
        }
        out.println(word);
        out.close();

        if (out.checkError()) {
            System.out.println("Error while writing file " + filename);
            return;
        }
        ++nTests;
    }

    static String pow(String s, int p) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < p; ++i) {
            sb.append(s);
        }
        return sb.toString();
    }

    static String randomString(int length) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; ++i) {
            sb.append((char) (random.nextInt(26) + 'a'));
        }
        return sb.toString();
    }


    static void writeRandomSubstring(int dictSize, int dictLength, int wordLength) {
        String[] dict = new String[dictSize];
        for (int i = 0; i < dictSize; ++i) {
            dict[i] = randomString(dictLength);
        }
        List<String> copy = new ArrayList<String>();
        for (int i = 0; i < dictSize; ++i) {
            for (int j = 0; j < 3; ++j) {
                copy.add(dict[i]);
            }
        }
        Collections.shuffle(copy, random);
        int ans = random.nextInt(copy.size()) + 1;
        StringBuilder concat = new StringBuilder();
        for (int i = 0; i < dictLength; ++i) {
            for (int j = 0; j < ans; ++j) {
                concat.append(copy.get(j).charAt(i));
            }
        }
        int from = random.nextInt(concat.length());
        int to = Math.min(concat.length(), from + wordLength);
        write(concat.toString().substring(from, to), dict);
    }

    static void writeOneWordManyTimes(int dictSize, int dictLength, int wordLength) {
        String[] dict = new String[dictSize];
        for (int i = 0; i < dictSize; ++i) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j < 7; ++j) {
                if ((i & (1 << j)) != 0) {
                    sb.append('r');
                } else {
                    sb.append('q');
                }
            }
            for (int j = 7; j < dictLength; ++j) {
                sb.append('y');
            }
            if (i == 0) {
                sb.setCharAt(random.nextInt(dictLength), 'd');
            }
            dict[i] = sb.toString();
        }
        Collections.shuffle(Arrays.asList(dict), random);
        write(pow("d", wordLength), dict);
    }

    public static void main(String[] args) throws IOException {
        /** 01..05 - mintests **/
        write("a", "a");
        write("a", "b");
        write("a", "aba");
        write("aba", "a");
        write("aaaaa", "a");

        /** 06..15 - two words in dictionary, different cases **/
        write("ab", "ac", "bd");
        write("ba", "ac", "bd");
        write("cd", "ac", "bd");
        write("bc", "ac", "bd");
        write("cb", "ac", "bd");

        write("ad", "ac", "bd");
        write("abd", "ac", "bd");
        write("bad", "ac", "bd");
        write("adc", "ac", "bd");
        write(pow("ab", 2) + "ad" + pow("cd", 2), "ac", "bd");

        /** 16..25 - 3-5 words in dictionary, long words **/
        for (int size = 3; size <= 5; ++size) {
            for (int i = 0; i < 4; ++i) {
                writeRandomSubstring(size, 20 * size, 40 * size);
            }
            writeOneWordManyTimes(size, 20 * size, 40 * size);
        }

        /** 26..50 - increasing number of words in dictionary **/
        for (int size : new int[] {10, 40, 70, 100}) {
            for (int i = 0; i < 4; ++i) {
                writeRandomSubstring(size, 100, 200);
            }
            writeOneWordManyTimes(size, 100, 200);
        }
    }
}
