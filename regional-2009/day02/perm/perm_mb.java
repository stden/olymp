//Задача "Перестановки"
//Региональный этап Всероссийской олимпиады школьников по информатике
//Автор задачи: Сергей Мельников, melnikov@rain.ifmo.ru
//Автор решения: Максим Буздалов, buzdalov@rain.ifmo.ru

// O(n^2 * 2^n) with very little constant

import java.io.*;
import java.util.*;
import static java.lang.Integer.parseInt;

public class perm_mb {
    static int gcd(int a, int b) {
        while (a != 0) {
            int t = b % a;
            b = a;
            a = t;
        }
        return b;
    }

    public static void main(String[] args) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader("perm.in"));
        StringTokenizer fl = new StringTokenizer(in.readLine());
        StringTokenizer sl = new StringTokenizer(in.readLine());
        in.close();

        int n = parseInt(fl.nextToken());
        int m = parseInt(fl.nextToken()) - 1;
        int k = parseInt(fl.nextToken());

        int[] x = new int[n];
        for (int i = 0; i < n; ++i) {
            x[i] = parseInt(sl.nextToken());
        }
        Arrays.sort(x);

        int[][] gcd = new int[n][n];
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                gcd[i][j] = gcd(x[i], x[j]);
            }
        }

        int[][] subcount = new int[n][1 << n];
        int[] index = new int[1 << n];

        for (int i = 0; i < n; ++i) {
            index[1 << i] = i;
            subcount[i][1 << i] = 1;
        }

        int[] next = new int[n];
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (j != i && gcd[i][j] >= k) {
                    next[i] |= 1 << j;
                }
            }
        }

        final int mask = (1 << n) - 1;
        final int MAX = 1000000001;

        for (int i = 1; i < 1 << n; ++i) {
            for (int j = i; j > 0; ) {
                int u = j & (j - 1);
                int last = index[j ^ u];
                int scl = subcount[last][i];
//                System.out.println("subcount[" + last + "][" + Integer.toBinaryString(i) + "] = " + scl);
                for (int l = mask & ~i & next[last]; l > 0; ) {
                    int q = l & (l - 1);
                    int li = l ^ q;
                    int last2 = index[li];
                    int w = subcount[last2][i | li] + scl;
                    if (w > MAX) {
                        w = MAX;
                    }
                    subcount[last2][i | li] = w;
                    l = q;
                }
                j = u;
            }
        }

        PrintWriter out = new PrintWriter("perm.out");

        int[] ans = new int[n];
        int used = 0;

        loop:
        for (int i = 0; i < n; ++i) {
//            System.out.println("Place " + i);
            for (int cand = 0; cand < n; ++cand) {
                int cm = 1 << cand;
                if ((used & cm) == 0 && (i == 0 || (next[ans[i - 1]] & cm) != 0)) {
//                    System.out.println("Testing " + cand);
                    if (subcount[cand][mask & ~used] > m) {
//                        System.out.println("Selecting " + cand);
                        ans[i] = cand;
                        used |= cm;
                        if (i + 1 == n) {
                            for (int j = 0; j < n; ++j) {
                                out.print(x[ans[j]] + " ");
                            }
                        }
                        continue loop;
                    } else {
//                        System.out.println("subsum = " + subcount[cand][mask & ~used] + ", m = " + m);
                        m -= subcount[cand][mask & ~used];
                    }
                }
            }
            out.println(-1);
            break loop;
        }
        out.close();
    }
}
