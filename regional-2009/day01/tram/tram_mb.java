//Задача "Трамвай"
//Региональный этап Всероссийской олимпиады школьников по информатике
//Автор задачи: Максим Носенко, nosenkomax@gmail.com
//Автор решения: Максим Буздалов, buzdalov@rain.ifmo.ru

//Аккуратная реализация обычной идеи. За счет аккуратности работает в полтора раза быстрее.

import java.io.*;
import java.util.*;

import static java.lang.Integer.parseInt;

public class tram_mb {
    static class Passenger implements Comparable<Passenger> {
        final int a, b, i, f;

        Passenger(int a, int b, int i) {
            this.a = a;
            this.b = b;
            this.i = i;
            this.f = a - b;
        }

        public int compareTo(Passenger p) {
            int d = f - p.f;
            return d == 0 ? i - p.i : d;
        }
    }

    static class Event implements Comparable<Event> {
        final int passenger;
        final int time;
        final boolean arrives;

        Event(int passenger, int time, boolean arrives) {
            this.passenger = passenger;
            this.time = time;
            this.arrives = arrives;
        }

        public int compareTo(Event e) {
            return time - e.time;
        }
    }

    static int nextInt(StringTokenizer st) {
        return parseInt(st.nextToken());
    }

    public static void main(String[] args) throws IOException {
        BufferedReader in = new BufferedReader(new FileReader("tram.in"));
        StringTokenizer fl = new StringTokenizer(in.readLine());
        int n = nextInt(fl);
        int m = nextInt(fl);
        int p = nextInt(fl);
        Passenger[] ps = new Passenger[n];
        Event[] es = new Event[2 * n];
        for (int i = 0; i < n; ++i) {
            StringTokenizer pg = new StringTokenizer(in.readLine());
            int a = nextInt(pg);
            int b = nextInt(pg);
            int c = nextInt(pg);
            int d = nextInt(pg);
            ps[i] = new Passenger(a, b, i);
            es[2 * i] = new Event(i, c, true);
            es[2 * i + 1] = new Event(i, d, false);
        }
        Arrays.sort(es);
        TreeSet<Passenger> sit = new TreeSet<Passenger>();
        TreeSet<Passenger> stand = new TreeSet<Passenger>();

        long ans = 0;
        long dif = 0;

        int prev = 1;
        for (Event ev : es) {
            ans += dif * (ev.time - prev);
            prev = ev.time;
            Passenger pp = ps[ev.passenger];
            if (ev.arrives) {
                if (pp.a <= pp.b) {
                    stand.add(pp);
                    dif += pp.b;
                } else {
                    sit.add(pp);
                    dif += pp.a;
                    if (sit.size() > m) {
                        Passenger qq;
                        stand.add(qq = sit.pollFirst());
                        dif += qq.b - qq.a;
                    }
                }
            } else {
                int os = stand.size();
                stand.remove(pp);
                if (os == stand.size()) {
                    sit.remove(pp);
                    dif -= pp.a;
                    if (os > 0) {
                        Passenger qq = stand.last();
                        if (qq.a > qq.b) {
                            stand.remove(qq);
                            sit.add(qq);
                            dif += qq.a - qq.b;
                        }
                    }
                } else {
                    dif -= pp.b;
                }
            }
        }
        ans += dif * (p - prev);

        PrintWriter out = new PrintWriter("tram.out");
        out.println(ans);
        out.close();
    }
}
