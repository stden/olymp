/**
 * Задача "Построй слово!"
 * Региональная олимпиада 2010 года, день второй.
 * Автор задачи: Владимир Ульянцев, ulyantsev@rain.ifmo.ru
 * Автор решения: Максим Буздалов, buzdalov@rain.ifmo.ru
 *
 * Медленное решение. Перебирает все
 * возможные раскладки и проверяет их на то, подходят ли они.
 */

import java.io.*;
import java.util.*;

public class word_mb_slow3 {
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


        char[] kmps = new char[100000];
        int[] kmpv = new int[100000];

        int[] pos = new int[s + 1];

//        if (n > 5 || l > 10 || s > 10) {
//            throw new AssertionError();
//        }

        /**
         * Перебираем все возможные "ответы" (число слов)
         */
        for (int k = 1; k <= s; ++k) {
            Arrays.fill(pos, 0);
            do {
                int idx = 0;
                int curv = 0;
                for (int i = 0; i < s; ++i) {
                    char tt = kmps[idx] = word[i];
                    while (curv > 0 && kmps[curv] != tt) {
                        curv = kmpv[curv - 1];
                    }
                    if (i != 0 && kmps[curv] == tt) {
                        ++curv;
                    }
                    kmpv[idx++] = curv;
                }
                kmps[idx] = '$';
                kmpv[idx++] = 0;
                curv = 0;
                for (int i = 0; i < l; ++i) {
                    for (int j = 0; j < k; ++j) {
                        char tt = kmps[idx] = dict[pos[j]][i];
                        while (curv > 0 && kmps[curv] != tt) {
                            curv = kmpv[curv - 1];
                        }
                        if (kmps[curv] == tt) {
                            ++curv;
                        }
                        kmpv[idx++] = curv;
                        if (curv == s) {
                            PrintWriter out = new PrintWriter("word.out");
                            out.println(k);
                            for (int q = 0; q < k; ++q) {
                                out.print(pos[q] + 1 + " ");
                            }
                            out.close();
                            return;
                        }
                    }
                }

                boolean hasNext = false;
                for (int i = 0; i < k; ++i) {
                    ++pos[i];
                    if (pos[i] < n) {
                        hasNext = true;
                        break;
                    } else {
                        pos[i] = 0;
                    }
                }
                if (!hasNext) {
                    break;
                }
            } while (true);
        }
        PrintWriter out = new PrintWriter("word.out");
        out.println(-1);
        out.close();
    }
}
