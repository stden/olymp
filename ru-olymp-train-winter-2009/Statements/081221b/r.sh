#/bin/bash
latex problems
sleep 1000
dvips -t landscape problems.dvi
#dvipdfm -p a4 problems
