for i in {1..100}
do
./mt_testgen >/tmp/tc.txt
./minspan </tmp/tc.txt >/tmp/a.txt
./minspan2 </tmp/tc.txt >/tmp/b.txt
diff /tmp/a.txt /tmp/b.txt
echo -n .
done
echo
