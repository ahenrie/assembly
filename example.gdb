#------------------------------------
# Debugger Input Script
#------------------------------------
echo \n\n
break last
run
set pagination off
set logging file out.txt
set logging overwrite
set logging on
set prompt
echo ------------------------------------ \n
echo display variables \n
echo \n
echo ***** 8 -bit values *****\n
x/3db &bVar1
echo \n
echo ***** 16-bit values *****\n
x/3dh &wVar1
echo \n
echo ***** 32-bit values *****\n
x/3dw &dVar1
echo \n
echo ***** 64-bit values *****\n
x/3dg &qVar1
echo \n \n
set logging off
quit
