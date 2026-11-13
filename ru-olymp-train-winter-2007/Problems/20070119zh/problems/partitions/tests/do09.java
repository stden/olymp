import java.io.*;
import java.util.*;

public class do09 {

    public void run() throws IOException {
        int n = 8;
        int k = n;
        ArrayList<Integer>[] set = new ArrayList[k];
        for (int i = 0; i < k; i++) {
            set[i] = new ArrayList<Integer>();
            set[i].add(i);
        }
        int count = 0;
        Random r = new Random(12348765);
        while (true) {
            count++;
            if (r.nextInt(100) < 5) {
                System.out.println(n + " " + k);
                for (int i = 0; i < k; i++) {
                    for (int j = 0; j < set[i].size(); j++) {
                        if (j > 0) {
                            System.out.print(" ");
                        }
                        System.out.print(set[i].get(j) + 1);
                    }
                    System.out.println();
                }
                System.out.println();
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
            ArrayList<Integer>[] newSet = new ArrayList[newk];

            for (int i = 0; i < keep; i++) {
                newSet[i] = new ArrayList<Integer>(set[i]);
            }
            Collections.sort(free);
            for (int i = 0; i < free.size(); i++) {
                newSet[keep + i] = new ArrayList<Integer>();
                newSet[keep + i].add(free.get(i));
            }
            if (keep == 0) {
                break;
            }

            set = newSet;
            k = newk;
        }

        System.out.println("0 0");
        System.err.println(count);
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
        new do09().run();
    }
}
