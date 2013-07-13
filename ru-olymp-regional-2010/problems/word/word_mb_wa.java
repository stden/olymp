/**
 * ������ "������� �����!"
 * ������������ ��������� 2010 ����, ���� ������.
 * ����� ������: �������� ��������, ulyantsev@rain.ifmo.ru
 * ����� �������: ������ ��������, buzdalov@rain.ifmo.ru
 *
 * ������������ ������� - ������������, ��� ����� ������ ����� ����������� ���,
 * ����� ������ ������ ����� ���������� �� ������ ����.
 */

import java.io.*;
import java.util.*;

public class word_mb_wa {
    private static void myAssert(String msg, boolean exp) {
        if (!exp) {
            throw new AssertionError(msg);
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

        char[] word = in.readLine().toCharArray();
        int s = word.length;
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
                 * ���������� ������ ���������������������.
                 */
                StringBuilder subseq = new StringBuilder();

                for (int t = cls; t < s; t += k) {
                    subseq.append(word[t]);
                }

                String ss = subseq.toString();

                /**
                 * ����� ��� ������� ����� � �������� ���� ��������� ���� ��������������������� � �����.
                 */
                for (int dv = 0; dv < n; ++dv) {
                    String cwd = dict[dv];
                    for (int entity = cwd.indexOf(ss); entity != -1; entity = cwd.indexOf(ss, entity + 1)) {
                        lookupTable[entity][cls] = dv;
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
                    if (
                            off == k - 1 && /** �������� ������������� ����������� �������,
                                                �� ��� �������� � ��������� ������� **/
                            countFirstMatches + countSecondMatches == k
                    ) {
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
