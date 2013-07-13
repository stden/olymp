import java.io.*;
import java.util.*;

public class partitions_as {

    public void run() throws IOException {
        Scanner in = new Scanner(new File("partitions.in"));
        PrintWriter out = new PrintWriter(new File("partitions.out"));

        int sum = 0;
        while (true) {
            int n = in.nextInt();
            sum += n;
            int k = in.nextInt();
            if (n == 0 && k == 0) {
                break;
            }
            in.nextLine();
            ArrayList<Integer>[] set = new ArrayList[k];
            for (int i = 0; i < k; i++) {
                set[i] = new ArrayList<Integer>();
                String t = in.nextLine();
                Scanner sc = new Scanner(t);
                while (sc.hasNextInt()) {
                    int q = 0;
                    set[i].add(q = sc.nextInt() - 1);
                }
            }
            ArrayList<Integer> free = new ArrayList<Integer>();
            int keep = 0;
            for (int i = k - 1; i >= 0; i--) {
                ArrayList<Integer> nxt = next(set[i], free);
                if (nxt != null) {
                    set[i] = nxt;
                    keep = i + 1;
                    break;
                } else {
                    free.addAll(set[i]);
                    Collections.sort(free);
                }
            }
            int newk = keep + free.size();
            out.println(n + " " + newk);
            for (int i = 0; i < keep; i++) {
                for (int j = 0; j < set[i].size(); j++) {
                    if (j > 0) {
                        out.print(" ");
                    }
                    out.print(set[i].get(j) + 1);
                }
                out.println();
            }
            Collections.sort(free);
            for (int i = 0; i < free.size(); i++) {
                out.println(free.get(i) + 1);
            }
            out.println();
        }

        assert sum <= 2000;

        in.close();
        out.close();
    }

    ArrayList<Integer> next(ArrayList<Integer> set, ArrayList<Integer> free) {
        int setMax = set.get(set.size() - 1);
        if (free.size() > 0) {
            // Add to the end
            int freeMax = free.get(free.size() - 1);
            if (freeMax > setMax) {
                int i = free.size() - 1;
                while (i > 0 && free.get(i - 1) > setMax) {
                    i--;
                }
                ArrayList<Integer> r = new ArrayList<Integer>(set);
                r.add(free.get(i));
                free.remove(i);
                return r;
            }
        }

        // Increase the next-to-last one
        if (set.size() > 2) {
            // Replace with the free element
            for (int i = 0; i < free.size(); i++) {
                if (free.get(i) > set.get(set.size() - 2)) {
                    ArrayList<Integer> r = new ArrayList<Integer>();
                    for (int j = 0; j < set.size() - 2; j++) {
                        r.add(set.get(j));
                    }
                    r.add(free.get(i));
                    free.remove(i);
                    free.add(set.get(set.size() - 1));
                    free.add(set.get(set.size() - 2));
                    return r;
                }
            }
            // Remove it and make it free
            ArrayList<Integer> r = new ArrayList<Integer>(set);
            r.remove(r.size() - 2);
            free.add(set.get(set.size() - 2));
            return r;
        }
        return null;
    }

    public static void main(String[] arg) throws IOException {
        new partitions_as().run();
    }
}
