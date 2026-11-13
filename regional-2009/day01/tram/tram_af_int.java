//Задача "Трамвай"
//Региональный Этап Всероссийской Олимпиады Школьников по Информатике
//Автор задачи: Маским Носенко, nosenkomax@gamil.com
//Автор решения: Антон Феськов, feskov@rain.ifmo.ru

//Переполнение

import java.io.*;
import java.math.*;
import java.util.*;

public class tram_af_int implements Runnable {
    public static void main(String[] args) {
        new Thread(new tram_af_int()).start();
    }

    BufferedReader br;
    StringTokenizer st;
    PrintWriter out;

    public void run() {
        try {
            br = new BufferedReader(new FileReader("tram.in"));
            out = new PrintWriter("tram.out");
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

    ArrayList<Passenger>[] init(int n) {
        ArrayList<Passenger>[] ans = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            ans[i] = new ArrayList<Passenger>(1);
        }
        return ans;
    }

    void solve() {
        int n = nextInt();
        myAssert(1 <= n && n <= 100000, "n is out of bounds ( " + n + " )");
        int m = nextInt();
        myAssert(1 <= m && m <= 100000, "m is out of bounds ( " + m + " )");
        int p = nextInt();
        myAssert(2 <= p && p <= 100000, "p is out of bounds ( " + p + " )");
        ArrayList<Passenger>[] pIn = init(p);
        ArrayList<Passenger>[] pOut = init(p);

        Passenger[] pas = new Passenger[n];

        for (int i = 0; i < n; i++) {
            int a = nextInt();
            myAssert(-1000000 <= a && a <= 1000000, "a is out of bounds ( " + a + " )");
            int b = nextInt();
            myAssert(-1000000 <= b && b <= 1000000, "b is out of bounds ( " + b + " )");
            
            pas[i] = new Passenger(a, b, i);
            int c = nextInt();
            int d = nextInt();
            myAssert(1 <= c && c <= p, "c is out of bounds ( " + c + " )");
            myAssert(c + 1 <= d && d <= p, "d is out of bounds ( " + d + " )");
            
            pIn[c - 1].add(pas[i]);
            pOut[d - 1].add(pas[i]);
        }

        int ans = 0, tans = 0;
        TreeSet<Passenger> sit = new TreeSet<Passenger>();
        TreeSet<Passenger> stand = new TreeSet<Passenger>();
        for (int i = 0; i < p; i++) {
            ans += tans;
            for (Passenger q : pOut[i]) {
                if (sit.contains(q)) {
                    tans -= q.a;
                    sit.remove(q);
                } else {
                    tans -= q.b;
                    if (stand.contains(q)) {
                        stand.remove(q);
                    }
                }
            }
            while (sit.size() < m && stand.size() > 0) {
                Passenger w = stand.pollFirst();
                sit.add(w);
                tans += w.a - w.b;
            }
            for (Passenger q : pIn[i]) {
                tans += q.b;
                if (q.b > q.a)
                    continue;
                sit.add(q);
                tans += q.a - q.b;
                if (sit.size() > m) {
                    Passenger w = sit.pollLast();
                    stand.add(w);
                    tans -= w.a - w.b;
                }
            }

        }
        out.println(ans);

    }

    class Passenger implements Comparable<Passenger> {
        int a, b, id;

        public Passenger(int a, int b, int id) {
            this.a = a;
            this.b = b;
            this.id = id;
        }

        @Override
        public int compareTo(Passenger o) {
            return a - b > o.a - o.b ? -1 : a - b < o.a - o.b ? 1 : id < o.id ? -1 : id > o.id ? 1 : 0;
        }

        @Override
        public boolean equals(Object o) {
            return (o instanceof Passenger) && this.compareTo((Passenger) o) == 0;
        }
    }
}
