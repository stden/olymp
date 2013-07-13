import java.lang.*;
import java.io.*;
import java.util.*;


public class chaotic_pkun_j {


    void solve() throws IOException{
      int n = nextInt();
      int[] a = new int[n];
      ArrayList<Integer> ans = new ArrayList();
      for (int i = 0; i < n; i++){
         a[i] = nextInt();
         if (i >= 2 && a[i-2] < a[i-1] && a[i-1] < a[i]){
            int t = a[i];
            a[i] = a[i-1];
            a[i-1] = t;
            ans.add(i);
         }
         else if (i >= 2 && a[i-2] > a[i-1] && a[i-1] > a[i]){
            int t = a[i];
            a[i] = a[i-1];
            a[i-1] = t;
            ans.add(i);
         }
      }

      out.println(ans.size());
      for (int i:ans)
        out.print(i+" ");
      out.println();
    }

    public static void main(String[] args) throws IOException{
        new chaotic_pkun_j().run();
    }

    BufferedReader in;
    StringTokenizer tokenizer;
    PrintWriter out;

    public void run() throws IOException
    {
        try {
            Locale.setDefault(Locale.US);
            Reader reader = new FileReader("chaotic.in");
            Writer writer = new FileWriter("chaotic.out");
            in = new BufferedReader(reader);
            tokenizer = null;
            out = new PrintWriter(writer);
            solve();
            in.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }       
    }

    int nextInt() throws IOException {
        return Integer.parseInt(nextToken());
    }

    long nextLong() throws IOException {
        return Long.parseLong(nextToken());
    }

    double nextDouble() throws IOException {
        return Double.parseDouble(nextToken());
    }

    String nextToken() throws IOException {
        while (tokenizer == null || !tokenizer.hasMoreTokens()) {
            tokenizer = new StringTokenizer(in.readLine());
        }
        return tokenizer.nextToken();
    }

}