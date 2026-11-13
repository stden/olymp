/**
 * Задача "Построй слово!"
 * Региональная олимпиада 2010 года, день второй.
 * Автор задачи: Владимир Ульянцев, ulyantsev@rain.ifmo.ru
 * Автор решения: Максим Буздалов, buzdalov@rain.ifmo.ru
 *
 * Медленное решение. Хотя оно построено в точности по такой же схеме, как и "основное" решение word_mb.java,
 * а в качестве поиска вхождения слова как подстроки в тексте использует асимптотически более быстрый алгоритм (КМП),
 * это не дает улучшения асимптотики, а лишь приводит к усложнению реализации и ухудшению производительности.
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
         * Перебираем все возможные "ответы" (число слов)
         */
        for (int k = 1; k <= s; ++k) {
            /**
             * Сбрасываем таблицу представителей
             */
            for (int[] lt : lookupTable) {
                Arrays.fill(lt, -1);
            }

            /**
             * Для каждой подпоследовательности слова с периодом k...
             */
            for (int cls = 0; cls < k; ++cls) {
                int idx = 0;
                int curv = 0;

                /**
                 * Сначала посчитаем префикс-функцию для подпоследовательности.
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
                 * Затем для каждого слова в алфавите...
                 */
                for (int dv = 0; dv < n; ++dv) {
                    int i2 = idx;
                    int c2 = 0;
                    char[] curdv = dict[dv];

                    /**
                     * Посчитаем префикс-функцию, приписав это слово к подпоследовательности (через $)
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
                             * Если поймали подстроку, регистрируем представителя.
                             * То есть, если подпоследовательность cls встречается
                             * в слове dv как подстрока с позиции i, то скажем, что
                             * в позиции i подпоследовательность cls представляет слово dv.
                             */
                            lookupTable[i - (idx - 1) + 1][cls] = dv;
                        }
                    }
                }
            }

            /**
             * Теперь смотрим, если ли на данном этапе ответ.
             */

            /**
             * Начальная инициализация "окна"
             */
            int countFirstMatches = 0;
            int countSecondMatches = 0;
            for (int i = 0; i < k; ++i) {
                countFirstMatches += lookupTable[0][i] == -1 ? 0 : 1;
            }

            /**
             * Перебираем столбец, в котором "окно" начинается...
             */
            for (int col = 0; col < l; ++col) {
                /**
                 * А также какой последний индекс еще не перенесен в следующий столбец...
                 */
                for (int off = k - 1; off >= 0; --off) {
                    if (countFirstMatches + countSecondMatches == k) {
                        /**
                         * Вот и ответ! Восстанавливаем его с помощью таблицы представителей.
                         */
                        PrintWriter out = new PrintWriter("word.out");
                        out.println(k);
                        /**
                         * Чтобы подстрока склеилась как надо, нужно сначала вывести второй столбец,
                         * а затем первый.
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
                         * Покидаем этот скорбный код.
                         */
                        return;
                    }
                    /**
                     * Столбцы закончились, переносить "окно" некуда.
                     */
                    if (col + 1 == l) {
                        break;
                    }
                    /**
                     * Передвигаем "окно".
                     */
                    countFirstMatches -= lookupTable[col][off] == -1 ? 0 : 1;
                    countSecondMatches += lookupTable[col + 1][off] == -1 ? 0 : 1;
                }
                /**
                 * "Окно" полностью переехало.
                 */
                countFirstMatches = countSecondMatches;
                countSecondMatches = 0;
            }
        }
        /**
         * Максимальное значение ответа равно |word| = s. Если ничего не нашли,
         * спокойной ночи.
         */
        PrintWriter out = new PrintWriter("word.out");
        out.println(-1);
        out.close();
    }
}
