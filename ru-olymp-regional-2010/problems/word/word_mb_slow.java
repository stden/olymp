/**
 * ������ "������� �����!"
 * ������������ ��������� 2010 ����, ���� ������.
 * ����� ������: �������� ��������, ulyantsev@rain.ifmo.ru
 * ����� �������: ������ ��������, buzdalov@rain.ifmo.ru
 *
 * ��������� ������� (������� ����������� ��������� ��� ������ �����������).
 */

import java.io.*;
import java.util.*;

public class word_mb_slow {
    private static void myAssert(String msg, boolean exp) {
        if (!exp) {
            throw new AssertionError(msg);
        }
    }

    static class LookupEntry {
        final int wordIndex;
        final int charIndex;

        public LookupEntry(int wordIndex, int charIndex) {
            this.wordIndex = wordIndex;
            this.charIndex = charIndex;
        }
    }

    public static void main(String[] args) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader("word.in"));
        int n, l;
        {
            String limits = in.readLine();
            int firstWS = limits.indexOf(' ');
            int lastWS = limits.indexOf(' ');
            myAssert("Wrong format of the first line", firstWS == lastWS && firstWS != -1);
            n = Integer.parseInt(limits.substring(0, firstWS));
            l = Integer.parseInt(limits.substring(lastWS + 1));
        }
        myAssert("n is out of bounds", 1 <= n && n <= 100);
        myAssert("l is out of bounds", 1 <= l && l <= 100);

        String[] dict = new String[n];
        for (int i = 0; i < n; ++i) {
            String line = in.readLine();
            myAssert("text on a block has wrong length", line.length() == l);
            dict[i] = line;
        }

        /**
         * ���������� ��� ��������� ���� �� �������.
         * ��� ������ ��������� ������ ������ ������ ���� � �������, � �������
         * ��� �����������.
         */
        Map<String, List<LookupEntry>> substrings = new HashMap<String, List<LookupEntry>>();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < l; ++j) {
                for (int k = j + 1; k <= l; ++k) {
                    String substr = dict[i].substring(j, k);
                    List<LookupEntry> le = substrings.get(substr);
                    if (le == null) {
                        le = new ArrayList<LookupEntry>(1);
                        substrings.put(substr, le);
                    }
                    le.add(new LookupEntry(i, j));
                }
            }
        }

        String word = in.readLine();
        int s = word.length();
        myAssert("new text length is out of bounds", 1 <= s && s <= 200);
        in.close();


        int[][] lookupTable = new int[l][s];

        /**
         * ���������� ��� ��������� "������" (����� ����)
         */
        for (int k = 1; k <= s; ++k) {
            /**
             * ���������� ������� ��������������
             */
            for (int[] lt : lookupTable) {
                Arrays.fill(lt, -1);
            }

            /**
             * ��� ������ ��������������������� ����� � �������� k...
             */
            for (int cls = 0; cls < k; ++cls) {
                int idx = 0;
                int curv = -1;

                /**
                 * ���������� ��� ������������������.
                 */
                StringBuilder subseq = new StringBuilder();

                for (int t = cls; t < s; t += k) {
                    subseq.append(word.charAt(t));
                }

                String ss = subseq.toString();

                /**
                 * ���� ��������������������� ����������� ��� ���������,
                 * ���������� ��� ��������� (�� ����������������� ������)
                 * � ��������� �������.
                 */
                List<LookupEntry> entries = substrings.get(ss);
                if (entries != null) {
                    for (int i = 0; i < entries.size(); ++i) {
                        LookupEntry ee = entries.get(i);
                        lookupTable[ee.charIndex][cls] = ee.wordIndex;
                    }
                }
            }

            /**
             * ������ �������, ���� �� �� ������ ����� �����.
             */

            /**
             * ��������� ������������� "����"
             */
            int countFirstMatches = 0;
            int countSecondMatches = 0;
            for (int i = 0; i < k; ++i) {
                countFirstMatches += lookupTable[0][i] == -1 ? 0 : 1;
            }

            /**
             * ���������� �������, � ������� "����" ����������...
             */
            for (int col = 0; col < l; ++col) {
                /**
                 * � ����� ����� ��������� ������ ��� �� ��������� � ��������� �������...
                 */
                for (int off = k - 1; off >= 0; --off) {
                    if (countFirstMatches + countSecondMatches == k) {
                        /**
                         * ��� � �����! ��������������� ��� � ������� ������� ��������������.
                         */
                        PrintWriter out = new PrintWriter("word.out");
                        out.println(k);
                        /**
                         * ����� ��������� ��������� ��� ����, ����� ������� ������� ������ �������,
                         * � ����� ������.
                         */
                        for (int i = off + 1; i < k; ++i) {
                            out.print(lookupTable[col + 1][i] + 1 + " ");
                        }
                        for (int i = 0; i <= off; ++i) {
                            out.print(lookupTable[col][i] + 1 + " ");
                        }
                        out.println();
                        out.close();
                        /**
                         * �������� ���� �������� ���.
                         */
                        return;
                    }
                    /**
                     * ������� �����������, ���������� "����" ������.
                     */
                    if (col + 1 == l) {
                        break;
                    }
                    /**
                     * ����������� "����".
                     */
                    countFirstMatches -= lookupTable[col][off] == -1 ? 0 : 1;
                    countSecondMatches += lookupTable[col + 1][off] == -1 ? 0 : 1;
                }
                /**
                 * "����" ��������� ���������.
                 */
                countFirstMatches = countSecondMatches;
                countSecondMatches = 0;
            }
        }
        /**
         * ������������ �������� ������ ����� |word| = s. ���� ������ �� �����,
         * ��������� ����.
         */
        PrintWriter out = new PrintWriter("word.out");
        out.println(-1);
        out.close();
    }
}
