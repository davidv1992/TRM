./mf_testgen >/tmp/tc.txt
./maxflow </tmp/tc.txt >/tmp/a.txt
./maxflow2 </tmp/tc.txt >/tmp/b.txt
diff /tmp/a.txt /tmp/b.txt
echo -n .
