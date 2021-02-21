#!/bin/bash
# Arkadiusz Sowa
# 300506
# TEST
echo "TEST"
echo ""
./4.sh 1 + 2 + 3
echo ""
./4.sh 1 + 2 / 3
echo ""
./4.sh 1 + 2 / 3 - 4
echo ""
./4.sh 1 + \( 5 - 3 \)
echo ""
echo ""
echo "Błędne równania"
echo ""

echo "1.1 + 1"
./4.sh 1.1 + 1
echo ""
echo "1 + 1.1"
./4.sh 1 + 1.1
echo ""
echo "1 + \) + 1"
./4.sh 1 + \) + 1
echo ""
echo "1 + \( 2 + 3 - 4 \) 1"
./4.sh 1 + \( 2 + 3 - 4 \) 1
echo ""
echo "1 + \( 2 + \( + 1 - 4 + 5 \)"
./4.sh 1 + \( 2 + \( + 1 - 4 + 5 \)
echo ""
echo "1 2 \( 2"
./4.sh 1 2 \( 2
echo ""
echo "1 + 1 + +"
./4.sh 1 + 1 + +
echo ""
echo "1 2 3"
./4.sh 1 2 3
echo ""
echo "1 + 2 + 1.3"
./4.sh 1 + 2 + 1.3
echo ""
echo "1 + a"
./4.sh 1 + a
