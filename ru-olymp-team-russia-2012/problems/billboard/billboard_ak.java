import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Scanner;

public class billboard_ak {

    void solve() throws IOException {
        Scanner in = new Scanner(br.readLine());
        int k = in.nextInt();
        int n = in.nextInt();
        int m = in.nextInt();
        ArrayList<Integer>[][] lights = new ArrayList[n][m];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                lights[i][j] = new ArrayList<Integer>();
            }
        }
        for (int pictureNum = 0; pictureNum < k; pictureNum++) {
            for (int i = 0; i < n; i++) {
                char[] s = br.readLine().toCharArray();
                for (int j = 0; j < m; j++) {
                    if (s[j] == '*') {
                        lights[i][j].add(pictureNum);
                    }
                }
            }
        }
        HashSet<ArrayList<Integer>> groups = new HashSet<ArrayList<Integer>>();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                groups.add(lights[i][j]);
            }
        }
        out.println(groups.size());
    }

    static BufferedReader br;
    static PrintWriter out;

    public static void main(String[] args) throws IOException {
        br = new BufferedReader(new FileReader("billboard.in"));
        out = new PrintWriter("billboard.out");
        new billboard_ak().solve();
        out.close();;
    }
}
