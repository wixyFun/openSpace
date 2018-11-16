#!/bin/bash -e

INCDIR=
INCDIR+="-I../../../ThirdParty/boost_1_68_0 "
INCDIR+="-I../../../ThirdParty/eigen "
INCDIR+="-I.. "

echo "Input validation test..."
g++ -std=c++11 -ggdb ${INCDIR} -w test-inputValidation.cpp -o a.out
./a.out | tee testinput.log
echo "Input validation test passes"

echo "Smoke Test..."
g++ -std=c++11 -ggdb ${INCDIR} -w smoketest_physics.cpp -o a.out
./a.out > smoketest.log
echo "Smoke test passes"

rm -f a.out smoketest.log testinput.log