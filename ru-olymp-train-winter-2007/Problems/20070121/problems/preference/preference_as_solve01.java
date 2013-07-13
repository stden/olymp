import java.util.*;
import java.io.*;

public class preference_as_solve01 {
    public void run() throws IOException {
        Scanner in = new Scanner(new File("preference.in"));
        PrintWriter out = new PrintWriter(new File("preference.out"));

        int q = in.nextInt();
        ArrayList<String> a = new ArrayList<String>();
        for (int i = 0; i < 12; i++) {
            a.add(in.next());
        }

        out.println(10);
        out.println(12 * 11);
        for (int i = 0; i < 12; i++) {
            for (int j = i + 1; j < 12; j++) {
                out.println(a.get(i) + " " + a.get(j) + " S");
                out.println(a.get(i) + " " + a.get(j) + " N");
            }
        }

        in.close();
        out.close();
    }

    public static void main(String[] arg) throws IOException {
        new preference_as_solve01().run();
    }
}
