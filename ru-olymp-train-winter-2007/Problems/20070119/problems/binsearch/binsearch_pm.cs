using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;

public class binsearch_pm
{
	public static void Main(string[] args)
	{
		new Thread(delegate()
		           {
		           	new binsearch_pm().run();
		           }, 128000000).Start();
	}

	int n;
	int res;
	int resMove;

	void run()
	{
		readInput();
		solve();
		writeOutput();
	}
	
	struct State
	{
		public int l1;
		public int l2;
		public int r1;
		public int r2;

		public State(int l1, int l2, int r1, int r2)
		{
			this.l1 = l1 - l2;
			this.l2 = 0;
			this.r1 = r1 - l2;
			this.r2 = r2 - l2;
			if (this.l1 > this.r2)
			{
				this.l1 = this.r2 + 1;
			}
			if (this.r1 < this.l2)
			{
				this.r1 = this.l2 - 1;
			}
		}
		
		public void doMove(int by, out State s1, out State s2)
		{
			if (by < r1)
				s1 = new State(l1, l2, by, r1);
			else
				s1 = new State(l1, l2, r1, Math.Min(by, r2));
			if (by + 1 > l1)
				s2 = new State(by + 1, l1, r1, r2);
			else
				s2 = new State(l1, Math.Max(by + 1, l2), r1, r2);
		}
	}
	
	struct StateDescription
	{
		public int numMoves;
		public int firstMove;

		public StateDescription(int numMoves, int firstMove)
		{
			this.numMoves = numMoves;
			this.firstMove = firstMove;
		}
	}
	
	StateDescription[,,] cache;
	bool[, ,] cached;
	
	void solve()
	{
		State start = new State(0, 0, n, n);
		cache = new StateDescription[n + 2, n + 2, n + 2];
		cached = new bool[n + 2, n + 2, n + 2];
		StateDescription desc = get(start);
		res = desc.numMoves;
		resMove = desc.firstMove;
	}

	StateDescription get(State start)
	{
		if (cached[start.l1 + 1, start.r1 + 1, start.r2 + 1])
			return cache[start.l1 + 1, start.r1 + 1, start.r2 + 1];
		
		int bestMoves = int.MaxValue / 2;
		int bestBy = -1;
		cache[start.l1 + 1, start.r1 + 1, start.r2 + 1] = new StateDescription(bestMoves, bestBy);
		cached[start.l1 + 1, start.r1 + 1, start.r2 + 1] = true;

		if (start.l2 >= start.r2 || (start.l1 > start.r2 && start.l2 >= start.r1) || (start.l2 > start.r1 && start.l1 >= start.r2))
		{
			bestMoves = 0;
		}
		else
		{
			for (int i = start.l2; i < start.r2; ++i)
			{
				State s1;
				State s2;
				start.doMove(i, out s1, out s2);
				int curMoves = 1 + Math.Max(get(s1).numMoves, get(s2).numMoves);
				
				if (curMoves < bestMoves)
				{
					bestMoves = curMoves;
					bestBy = i;
				}
			}
		}
		
		StateDescription res = new StateDescription(bestMoves, bestBy);
		cache[start.l1 + 1, start.r1 + 1, start.r2 + 1] = res;
//		Console.WriteLine(start.l2 + " " + start.l1 + " " + start.r1 + " " + start.r2 + " " + res.numMoves);
		return res;
	}

	void writeOutput()
	{
		using (FileStream stream = new FileStream("binsearch.out", FileMode.Create))
		using (StreamWriter writer = new StreamWriter(stream))
		{
			writer.WriteLine(res);
			writer.WriteLine(resMove);
		}
	}

	void readInput()
	{
		using (FileStream stream = new FileStream("binsearch.in", FileMode.Open))
		using (StreamReader reader = new StreamReader(stream))
		{
			n = int.Parse(reader.ReadLine().Trim());
		}
	}
}
