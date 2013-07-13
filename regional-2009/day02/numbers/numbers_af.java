//Задача "Числа"
//Региональный Этап Всероссийской Олимпиады Школьников по Информатике
//Автор задачи: Владимир Ульянцев, ulyancev@rain.ifmo.ru
//Автор решения: Антон Феськов, feskov@rain.ifmo.ru

import java.io.*;
import java.math.*;
import java.util.*;

public class numbers_af implements Runnable {
    public static void main(String[] args) {
        new Thread(new numbers_af()).start();
    }

    BufferedReader br;
    StringTokenizer st;
    PrintWriter out;

    public void run() {
        try {
            br = new BufferedReader(new FileReader("numbers.in"));
            out = new PrintWriter("numbers.out");
            solve();
            out.close();
        } catch (Throwable e) {
            e.printStackTrace();
            System.exit(-1);
        }
    }

    String nextToken() {
        while (st == null || !st.hasMoreElements()) {
            try {
                st = new StringTokenizer(br.readLine());
            } catch (Exception e) {
                throw new Error("Enexpected end of file");
            }
        }
        return st.nextToken();
    }

    void myAssert(boolean e, String msg) {
        if (!e) {
            throw new Error(msg);
        }
    }

    int nextInt() {
        return Integer.parseInt(nextToken());
    }
    
    long nextLong() {
        return Long.parseLong(nextToken());
    }
    
    
    double nextDouble() {
        return Double.parseDouble(nextToken());
    }

    void solve() {
        int n = nextInt();
        long c = nextLong();
        int k = nextInt();
        myAssert(1 <= n && n <= 50000, "n is out of bounds ( " + n + " )");
        myAssert(1 <= c && c <= 100000000, "c is out of bounds ( " + c + " )");
        myAssert(1 <= k && k <= 18, "k is out of bounds ( " + k + " )");
        long P = BigInteger.TEN.pow(k).longValue();
        long[] D = new long[n + 1];
        String s = nextToken();
        int[] v = new int[n];
        for (int i =0; i < n; i++) {
            v[i] = s.charAt(i) - '0';
        }
        
        D[0] = 1;
        for (int i = 0; i < n; i++) {
            long t = v[i];
            int j = i;
            while (t <= c) {
                D[j + 1] = (D[j + 1] + D[i]) % P;
                if (v[i] == 0 || j == n - 1) break;
                t = 10 * t + v[++j];
            }
        }
        
        //out.println(("000000000000000000000000000000000000").substring(0, k - (D[n] + "").length()) + D[n]);
        out.println(D[n]);
        
    }
}
