/**
 * Задача "Построй слово!"
 * Региональная олимпиада 2010 года, день второй.
 * Автор задачи: Владимир Ульянцев, ulyantsev@rain.ifmo.ru
 * Автор решения: Максим Буздалов, buzdalov@rain.ifmo.ru
 *
 * Медленное решение (большой константный множитель при оценке асимптотики).
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
         * Перебираем все подстроки слов из словаря.
         * Для каждой возможной строки храним список мест в словаре, в которых
         * она встречается.
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
                int curv = -1;

                /**
                 * Генерируем эту последовательность.
                 */
                StringBuilder subseq = new StringBuilder();

                for (int t = cls; t < s; t += k) {
                    subseq.append(word.charAt(t));
                }

                String ss = subseq.toString();

                /**
                 * Если подпоследовательность встречается как подстрока,
                 * перебираем все вхождения (из предподсчитанного списка)
                 * и обновляем таблицу.
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
