/**
 * ������ "������� �����!"
 * ������������ ��������� 2010 ����, ���� ������.
 * ����� ������: �������� ��������, ulyantsev@rain.ifmo.ru
 * ����� �������: ������ ��������, buzdalov@rain.ifmo.ru
 *
 * ��������� �������. ���� ��� ��������� � �������� �� ����� �� �����, ��� � "��������" ������� word_mb.java,
 * � � �������� ������ ��������� ����� ��� ��������� � ������ ���������� �������������� ����� ������� �������� (���),
 * ��� �� ���� ��������� �����������, � ���� �������� � ���������� ���������� � ��������� ������������������.
 */

import java.io.*;
import java.util.*;

public class word_mb_slow2 {
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

        char[][] dict = new char[n][l];
        for (int i = 0; i < n; ++i) {
            String line = in.readLine();
            myAssert("text on a block has wrong length", line.length() == l);
            for (int j = 0; j < l; ++j) {
                dict[i][j] = line.charAt(j);
            }
        }

        char[] word = in.readLine().toCharArray();
        int s = word.length;
        myAssert("new text length is out of bounds", 1 <= s && s <= 200);
        in.close();


        int[][] lookupTable = new int[l][s];

        char[] kmps = new char[l + s + 1];
        int[] kmpv = new int[l + s + 1];

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
                int curv = 0;

                /**
                 * ������� ��������� �������-������� ��� ���������������������.
                 */
                for (int t = cls; t < s; t += k) {
                    char tt = kmps[idx] = word[t];
                    while (curv > 0 && kmps[curv] != tt) {
                        curv = kmpv[curv - 1];
                    }
                    if (t != cls && kmps[curv] == tt) {
                        ++curv;
                    }
                    kmpv[idx++] = curv;
                }
                kmps[idx] = '$';
                kmpv[idx++] = 0;

                if (idx - 1 > l) {
                    continue;
                }

                /**
                 * ����� ��� ������� ����� � ��������...
                 */
                for (int dv = 0; dv < n; ++dv) {
                    int i2 = idx;
                    int c2 = 0;
                    char[] curdv = dict[dv];

                    /**
                     * ��������� �������-�������, �������� ��� ����� � ��������������������� (����� $)
                     */
                    for (int i = 0; i < l; ++i, ++i2) {
                        char tt = kmps[i2] = curdv[i];
                        while (c2 > 0 && kmps[c2] != tt) {
                            c2 = kmpv[c2 - 1];
                        }
                        if (kmps[c2] == tt) {
                            ++c2;
                        }
                        kmpv[i2] = c2;
                        if (c2 == idx - 1) {
                            /**
                             * ���� ������� ���������, ������������ �������������.
                             * �� ����, ���� ��������������������� cls �����������
                             * � ����� dv ��� ��������� � ������� i, �� ������, ���
                             * � ������� i ��������������������� cls ������������ ����� dv.
                             */
                            lookupTable[i - (idx - 1) + 1][cls] = dv;
                        }
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
