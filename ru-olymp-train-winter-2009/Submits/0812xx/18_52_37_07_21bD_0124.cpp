#include <fstream>
#include <iostream>


const int koldays[12]={31,28,31,30,31,30,31,31,30,31,30,31};

using namespace std;


long long min(long long a, long long b)
{
  return a<b? a: b;
}

int main()
{
  ifstream fin("calls.in");
  ofstream fout("calls.out");
  
  long long tr=0, tw=0, tp=0, tsek=0;
  
  
while (fin)  
{
  long long sminu=0, sh=0, sday=0, syear=0, smonth=0, ssek=0;
  long long stime=0;
  
  char s[300];
  int l=0;
  bool f=false;
  while (fin && !f)
  {
    while (s[l-1]!='\n' && fin)
      fin.get(s[l++]);
    
    if (s[25]=='C' && s[33]=='o' && s[50]==' ' && s[32]=='i' && s[45]=='e' && s[49]=='t' && s[30] == 'c')
    {
      sday=(int(s[3])-int('0'))*10+int(s[4])-int('0');
    syear=(((((int(s[6])-int('0'))*10+int(s[7])-int('0'))*10) + int(s[8])-int('0'))*10 + int(s[9]) - int('0'));
     sh=(int(s[11])-int('0'))*10 + int(s[12])-int('0');
     sminu=(int(s[14])-int('0'))*10 + int(s[15])-int('0');
     ssek=(int(s[17])-int('0'))*10 + int(s[18])-int('0');
     smonth=(int(s[0])-int('0'))*10 + int(s[1])-int('0');
     s[25]='q'; s[33]='w'; s[50]='t';
     f=true;
     l--;
    }
    else l=0, fin.get(s[l++]);;
  }
  
  if (f==false) break;
  
    int eminu=0, eh=0, eday=0, eyear=0, emonth=0, esek=0;
  long long etime=0;
  
  char s2[300];
  int l2=0;
  bool f2=false;
  while (fin && !f2)
  {
    while (s2[l2-1]!='\n' && fin)
      fin.get(s2[l2++]);
    if (s2[25]=='H' && s2[33]=='u' && s2[42]=='d' && s2[30]=='n' && s2[34]=='p' && s[35]==' ')
    {
      eday=(int(s2[3])-int('0'))*10+int(s2[4])-int('0');
    eyear=(((((int(s2[6])-int('0'))*10+int(s2[7])-int('0'))*10) + int(s2[8])-int('0'))*10 + int(s2[9]) - int('0'));
     eh=(int(s2[11])-int('0'))*10 + int(s2[12])-int('0');
     eminu=(int(s2[14])-int('0'))*10 + int(s2[15])-int('0');
     esek=(int(s2[17])-int('0'))*10 + int(s2[18])-int('0');
     emonth=(int(s[0])-int('0'))*10 + int(s[1])-int('0');
     s2[25]='w'; s2[33]='q'; s2[42]='r';
     f2=true;
     l2--;
    }
    else l2=0;
  }
  
  string str="";
  int rk=0, wk=0, kl=0;
  char q;
  
  while (kl<2)
  {
        fin >> str;
    if (str=="Reads")
    {
      fin.get(q); fin.get(q);
      fin >> rk;
      kl++;
    }
    if (str=="Writes:")
    {
      fin >> wk;
      kl++;
    }
  }
  stime += (syear-min(syear,eyear))*365*24*60*60;
  if (syear%4==0)
    stime+=24*60*60;
  stime += koldays[smonth-1]*24*60*60;
  stime += sday*24*60*60;
  stime += sh*60*60;
  stime += sminu*60;
  stime += ssek;
  
    etime += (eyear-min(syear,eyear))*365*24*60*60;
  if (eyear%4==0)
    etime+=24*60*60;
  etime += koldays[emonth-1]*24*60*60;
  etime += eday*24*60*60;
  etime += eh*60*60;
  etime += eminu*60;
  etime += esek;
  
  for (int i=0; i<=18; i++)
    fout << s[i];
  fout << "   " << etime-stime << ' ';
  for (int i=51; i<l && ((int(s[i]) - int ('0')) <=9 && (int(s[i]) - int ('0')) >=0); i++)
    fout << s[i];
  fout << ' ' << rk << '/' << wk << '\n';
  
  if ((etime-stime) >=60) 
    tp+=etime-stime;
  tr +=rk; tw+=wk; tsek+= etime-stime; 
  
}
  
  fout  << "Total seconds to pay = " << tp << ", total seconds = " << tsek << "; total bytes " << tr << '/' << tw;
  fin.close();
  fout.close();
}