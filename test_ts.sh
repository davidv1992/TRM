for i in {1..100}
do
./ts_testgen >/tmp/tc.txt
./2sat </tmp/tc.txt >/tmp/a.txt
echo -n .
done
echo
