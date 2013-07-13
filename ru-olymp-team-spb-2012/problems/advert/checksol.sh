if ! [ -d tests ] ; then
   echo "Gen tests first!"
   exit 1
fi

if ! [ -e Check.jar ] ; then
   echo "Gen tests first!"
   exit 1
fi


exec='echo no executable!'

if [ -e $1.cpp ] ; then
g++ -O2 -o $1 $1.cpp ||exit
exec=./$1
elif [ -e $1.dpr ] ; then
fpc -O2 $1.dpr ||exit
exec=./$1
elif [ -e $1.pas ] ; then
fpc -O2 $1.pas ||exit
exec=./$1
elif [ -e $1.py ] ; then
exec="python $1"
elif [ -e $1.java ] ; then
javac $1.java  ||exit
exec="java -ea $1"
else
echo "Can't find source"
exit 1
fi              


for i in tests/?? ; do
  cp $i advert.in
  $exec
  java -jar Check.jar $i advert.out $i.a
done
