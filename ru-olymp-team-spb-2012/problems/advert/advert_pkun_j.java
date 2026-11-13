import java.io.*;
import java.lang.*;
import java.util.*;

public class advert_pkun_j {


    void solve() throws IOException{
      int n = nextInt();
      int w = nextInt();
      int h = nextInt();

      assert(1 <= n && n <= 100000);
      assert(1 <= w && w <= 1000000000);
      assert(1 <= h && h <= 1000000000);

      int[] a = new int[n];
      int[] b = new int[n];
      
      for (int i = 0; i < n; i++) {
        a[i] = nextInt();
        b[i] = nextInt();
        assert(1 <= a[i] && a[i] <= 1000000000);
        assert(1 <= b[i] && b[i] <= 1000000000);
      }

      double l = 0;
      double r = 1e9+1;
      for (int i = 0; i < n; i++)
        r = Math.min(r,(double)w/a[i]);

      for (int i = 0; i < 200; i++){
        double mid = (l+r)/2;
        double curh = 0;
        double curw = 0;

        for (int j = 0; j < n; j++){
            if (j == 0 || b[j] != b[j-1] || curw + a[j] * mid > w){
               curw = 0;
               curh += b[j] * mid;
            }
            curw += a[j] * mid;                                             
        }

        if (curh > h)
            r = mid;
        else
            l = mid;
      }

      out.printf("%.15f\n",(l+r)/2);
    }

    public static void main(String[] args) throws IOException{
        new advert_pkun_j().run();
    }

    BufferedReader in;
    StringTokenizer tokenizer;
    PrintWriter out;

    public void run() throws IOException
    {
        try {
            Locale.setDefault(Locale.US);
            Reader reader = new FileReader("advert.in");
            Writer writer = new FileWriter("advert.out");
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
