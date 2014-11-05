for i in {1..100}
do
./sp_testgen >/tmp/tc.txt
./dijkstras </tmp/tc.txt >/tmp/a.txt
./bellmanford </tmp/tc.txt >/tmp/b.txt
./floydwarshall </tmp/tc.txt >/tmp/c.txt
diff /tmp/a.txt /tmp/b.txt
diff /tmp/a.txt /tmp/c.txt
echo -n .
done
echo
