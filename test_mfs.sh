for i in {1..100}
do
./mfs_testgen >/tmp/tc.txt
./maxflow </tmp/tc.txt >/tmp/a.txt
./maxflow3 </tmp/tc.txt >/tmp/b.txt
diff /tmp/a.txt /tmp/b.txt
echo -n .
done
echo
