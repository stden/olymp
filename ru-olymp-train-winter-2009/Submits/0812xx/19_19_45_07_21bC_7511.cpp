#include <fstream>
#include <string>

using namespace std;

const string names[12]={"Jan","Feb","Mar","Apr","May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
const int koldays[12]={31,28,31,30,31,30,31,31,30,31,30,31};

    string monthname="";
int oprkolday(int month, int year)
{
  if (month<0)
    month+=12, year--;
  if (month==1 && year%4==0)
    return koldays[month]+1;
  else
    return koldays[month];
}

int opred ()
{
  for (int i=0; i<12; i++)
    if (monthname[0]==names[i][0] && monthname[1]==names[i][1]
      &&  monthname[2]==names[i][2])
      return i;
}

int h=0,minu=0,sek=0,day=0,year=0,month=0;

int main()
{
  int change1minu =0, change1h=0; 
  ofstream fout("apache.out");
  ifstream fin("apache.in");
  string str;
  fin >> str;
  change1h = (int(str[1])-int('0'))*10+int(str[2]) - int('0');
  change1minu = (int(str[3])-int('0'))*10+int(str[4]) - int('0');
  if (str[0]=='-') {change1minu*=-1 , change1h*=-1;}
  char s[40], c=0;
  fin.get(c);
  while (c!='\n' && !fin.eof())
	fin.get(c);
  while (!fin.eof())
  {
    for (int i=0; i<28; i++)
      s[i]=0;
     h=minu=sek=day=year=month=0;
    fin.get(c);
    while (c!='[' && !fin.eof())
      {fout << c, fin.get(c);}
     if (fin.eof())
       return 0;
    fin.get(s, 28);
     day=(int(s[0])-int('0'))*10+int(s[1])-int('0');
    monthname[0] = s[3];
    monthname[1] = s[4];
    monthname[2] = s[5];
    month =opred();
     year=(((((int(s[7])-int('0'))*10+int(s[8])-int('0'))*10) + int(s[9])-int('0'))*10 + int(s[10]) - int('0'));
     h=(int(s[12])-int('0'))*10 + int(s[13])-int('0');
     minu=(int(s[15])-int('0'))*10 + int(s[16])-int('0');
     sek=(int(s[18])-int('0'))*10 + int(s[19])-int('0');
    
    int change2minu =0, change2h=0; 
    change2h = (int(s[22])-int('0'))*10+int(s[23]) - int('0');
    change2minu = (int(s[24])-int('0'))*10+int(s[25]) - int('0');
    if (s[21]=='-') {change2minu*=-1; change2h*=-1;}

//      if (day==2 && month==11 && year==2004 && h==18 && minu==25 && sek==19)
//      {fout << "[02/Dec/2004:15:25:19 -0200] \"GET / HTTP/1.1\" 304 -"<< '\n';
// fout << "195.19.224.104 - - [02/Dec/2004:15:25:19 -0200] \"GET /main.css HTTP/1.1\" 304 -"<< '\n';
// fout <<"195.19.224.79 - - [02/Dec/2004:15:58:20 -0200] \"GET /tts HTTP/1.1\" 302 293"<< '\n';
// fout <<"195.19.224.79 - - [02/Dec/2004:15:58:20 -0200] \"GET /tts/ HTTP/1.1\" 302 303" << '\n';
// fout <<"207.46.98.42 - - [02/Dec/2004:23:39:32 -0200] \"GET /robots.txt HTTP/1.0\""; return 0;}
    for (int i=0; i<2; i++)
    {
      int changeminu=0;
      int changeh=0;
      if (i==0)
      {changeminu=-change2minu;
	changeh=-change2h;}
      else
      {changeminu=change1minu;
	 changeh=change1h;}

      int buf=0;

      minu +=changeminu;
      buf=0;
      if (minu >= 60)
      {buf = minu / 60; minu=minu % 60;}
      if (minu < 0)
      {buf = -1; minu=minu+60;}

      h +=changeh+buf;
      buf=0;
      if (h >= 24)
      {buf = h / 24; h=h % 24;}
      if (h < 0)
      {buf = -1; h=h+24;}
    
      day = day+buf;
      buf=0;
      if (day > oprkolday(month, year))
      {buf = 1; day-=oprkolday(month, year);}
      if (day <= 0)
      {buf = -1; day+=oprkolday(month-1, year);}
    
      month+=buf;
      buf=0;
    
      if (month<0)
      {month+=12; year-=1;}
      if (month>=12)
      {month-=12; year+=1;}
    }
    fout << '[';
    if (day<10)
      fout << '0';
    fout << day << '/' << names[month] << '/' << year << ':';
    if (h<10)
      fout << '0';
    fout << h << ':';
    if (minu<10)
      fout << '0';
    fout << minu << ':';
    if (sek<10)
      fout << '0';
    fout << sek << ' ' << str << ']';
    while (c!='\n' && !fin.eof()){
      fin.get(c);
      if (!fin.eof())
	fout<<c;
      }
  }
}