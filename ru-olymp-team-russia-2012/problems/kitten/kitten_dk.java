import java.util.*;
import java.io.*;

public class kitten_dk {
	BufferedReader br;
	PrintWriter out;
	StringTokenizer stok;

	String nextToken() throws IOException {
		while (stok == null || !stok.hasMoreTokens()) {
			String s = br.readLine();
			if (s == null) {
				return null;
			}
			stok = new StringTokenizer(s);
		}
		return stok.nextToken();
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

	char nextChar() throws IOException {
		return (char) (br.read());
	}

	String nextLine() throws IOException {
		return br.readLine();
	}

	int n, m, ai, aj, bi, bj, ci, cj;
	long[][] c;
	long[][][] a;
	final int mod = 1000 * 1000 * 1000 + 7;
	void init() {
		c = new long[2001][2001];
		for (int i = 0; i < 2001; i++) {
			c[i][0] = 1;
		} 
		for (int i = 1; i < 2001; i++) {
			for (int j = 1; j < 2001; j++) {
				c[i][j] = (c[i-1][j] + c[i-1][j-1]) % mod;
			}
		}
	}
	/*
	public int hardcase() {
		a[bi][bj] = c[(bi - ai) + (bj - aj)][(bi - ai)];
		for (int i = bi; i >= Math.max(ai, ci); i--) {
			for (int j = bj; j >= Math.max(aj, cj); j--) {
				if (i == bi && j == bj) {
					out.print(a[i][j] + " ");
					continue;
				}
				if (i == bi || j == bj) {
					a[i][j] = a[bi][bj] / 2;
					out.print(a[i][j] + " ");
					continue;
				}
				a[i][j] = (a[i + 1][j] + a[i][j + 1]) % mod;
				//long x = (a[bi][bj] - ((long) c[(i - ai) + (j - aj)][(i - ai)] * c[(bi - i) + (bj - j)][(bi - i)]) + mod) % mod;
				long x = (long) (c[(i - ai) + (j - aj)][i - ai]) * (c[(bi - i - 1) + (bj - j)][(bj - j)]) % mod;
				x = (x + ((long) (c[(i - ai) + (j - aj)][i - ai]) * (c[(bi - i) + (bj - j - 1)][(bj - j - 1)]) % mod)) % mod;
				a[i][j] = (a[i][j] - (int) x + mod) % mod;
				out.print(a[i][j] + " ");
			}
			out.println();
		}

		return(a[ci][cj]);
	}*/
	public void hardcase(int n, int m) {
		for (int k = 1 + 1; k <= m; k++) {
			a[1][1][k] = 1;
		}
		long[][] partsum = new long[m+2][m+2];
		for (int i = 2; i <= n; i++) {
			for (int i1 = 0; i1 <= m; i1++) {
				for (int j1 = 0; j1 <= m; j1++) {
					partsum[i1][j1] = 0;
				}
			}
			
			for (int k1 = m; k1 >= 1; k1--) {
				for (int j1 = 1; j1 <= m; j1++) {
					partsum[j1][k1] = (partsum[j1][k1 + 1] + a[i-1][j1][k1]) % mod;
				}
			}
			
			for (int j = 1; j <= m; j++) {
				for (int k = j + 1; k <= m; k++) {
					for (int j1 = 1; j1 <= j; j1++) {/*
						for (int k1 = j + 1; k1 <= k; k1++) {
							a[i][j][k] += a[i - 1][j1][k1];
						}*/
						a[i][j][k] = (a[i][j][k] + (partsum[j1][j+1] - partsum[j1][k+1] + mod) % mod) % mod;
					}
				}	
			}
		}
		
		
		
	}

	public long get(int ai, int aj, int ci, int cj) {
		int i, j, i1, j1;
		if (ci > ai) {
			i = ai;
			j = aj;
			i1 = ci;
			j1 = cj;
		} else {
			i = ci;
			j = cj;
			i1 = ai;
			j1 = aj;
		}
		long ans = 0;
		//if (j + 1 <= j1) {
		if (i == i1) {
			return a[i][Math.min(j, j1)][Math.max(j, j1)];
		}
		for (int k = j + 1; k <= j1; k++) {
			ans = (ans + ( (a[i][j][k]) * c[(i1 - i - 1) + (j1 - k)][(i1 - i - 1)]) % mod) % mod;
		}
		for (int k = 1; k < j && k <= j1; k++) {
			ans = (ans + ( (a[i][k][j]) * c[(i1 - i - 1) + j1 - k][(i1 - i - 1)]) % mod) % mod;
		}
		return ans;
	}

	boolean between(int c, int a, int b) {
	 	return (c > a && c < b) || (c > b && c < a); 
	}

	void solve() throws IOException {
		init();
		n = nextInt();
		m = nextInt();
		a = new long[n + 2][m + 2][m + 2];
		ai = nextInt();
		aj = nextInt();
		bi = nextInt();
		bj = nextInt();
		ci = nextInt();
		cj = nextInt();
		
		int mini = Math.min(Math.min(ai, bi), ci);
		int minj = Math.min(Math.min(aj, bj), cj);
		int maxi = Math.max(Math.max(ai, bi), ci);
		int maxj = Math.max(Math.max(aj, bj), cj);

		if (ai == bi && bi == ci) {
			 if (between(cj, aj, bj) || between(aj, bj, cj)) {
				if (ai == 1 || ai == n) {
					out.println(Math.abs(cj - aj));	
				} else {
                	        	out.println(2 * Math.abs(cj - aj));	
				}
			} else if (between(bj, aj, cj)) {
					out.println(1);
			}        
			return;
		}

		if (aj == bj && bj == cj) { 
			if (between(ci, ai, bi) || between(ai, bi, ci)) {
				System.err.println(aj + " " + Math.abs(ci - ai));
				if (aj == 1 || aj == m) {
					out.println(Math.abs(ci - ai));	
				} else {
                	        	out.println(2 * Math.abs(ci - ai));	
				}
			} else if (between(bi, ai, ci)) {
					out.println(1);
			}       
			return;
		}
		
		
		ai = ai - mini + 1;
		bi = bi - mini + 1;
		ci = ci - mini + 1;
		
		aj = aj - minj + 1;
		bj = bj - minj + 1;
		cj = cj - minj + 1;


		int di = bi - ci;
		int dj = bj - cj;
		int ei = bi - ai;
		int ej = bj - aj;
		if (dj * ej < 0 && di * ei < 0) {
			di = Math.abs(di);
			dj = Math.abs(dj);
			ei = Math.abs(ei);
			ej = Math.abs(ej);
                        out.println((c[di + dj][dj] * c[ei + ej][ei]) % mod);
			return;
		}	
		
		//System.err.println(di + " " + ei);
		if (di * ei < 0) {
			di = Math.abs(di);
			dj = Math.abs(dj);
			ei = Math.abs(ei);
			ej = Math.abs(ej);
			long x = (c[di + dj - 1][di - 1] * c[ei + ej][ei]) % mod;
			x += (c[di + dj - 1][di] * c[ei + ej - 1][ei - 1]) % mod;
			x = x % mod;
			out.println(x); 
			return;
		}
		if (dj * ej < 0) {
			di = Math.abs(di);
			dj = Math.abs(dj);
			ei = Math.abs(ei);
			ej = Math.abs(ej);
			long x = (c[di + dj - 1][dj - 1] * c[ei + ej][ej]) % mod;
			x += (c[di + dj - 1][dj] * c[ei + ej - 1][ej - 1]) % mod;
			x = x % mod;
			out.println(x); 
			return;
		}

		if (di * ei >= 0 && dj * ej >= 0) {
			//out.println(hardcase());
			di = bi - 1;
			dj = bj - 1;
			bi -= di;
			bj -= dj;
			ai -= di;
			aj -= dj;
			ci -= di;
			cj -= dj;
			if (ai < 1) {
				if (ci > 1) {
					System.err.println("Panic");
					return;
				}
				ai = 2 - ai;
				ci = 2 - ci;
			}
			if (aj < 1) {
				if (cj > 1)  {
					System.err.println("Panoc");
					return;
				}
				aj = 2 - aj;
				cj = 2 - cj;
			}
			if (ci < 1) {
				if (ai > 1) {
					System.err.println("Panic");
					return;
				}
				ai = 2 - ai;
				ci = 2 - ci;
			}
			if (cj < 1) {
				if (aj > 1)  {
					System.err.println("Panoc");
					return;
				}
				aj = 2 - aj;
				cj = 2 - cj;
			}
			hardcase(maxi - mini + 1, maxj - minj + 1);
			out.println(get(ai, aj, ci, cj));
		}	
	}

	void run() throws IOException {
		br = new BufferedReader(new FileReader("kitten.in"));
		out = new PrintWriter("kitten.out");
		// br = new BufferedReader(new InputStreamReader(System.in));
		// out = new PrintWriter(System.out);
		solve();
		br.close();
		out.close();
	}

	public static void main(String[] args) throws IOException {
		// Localea.setDefault(Locale.US);
		new kitten_dk().run();
	}
}