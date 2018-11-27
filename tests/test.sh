#!/bin/bash -e

set -o pipefail

INCDIR=
INCDIR+="-I../thirdparty/boost_1_68_0 "
INCDIR+="-I../thirdparty/eigen "
INCDIR+="-I../src/nbody "

echo "Input validation test..."
g++ -std=c++11 -ggdb ${INCDIR} -w test-inputValidation.cpp -o a.out
./a.out | tee testinput.log || exit 1
echo "Input validation test passes"

echo "Smoke Test..."
g++ -std=c++11 -ggdb ${INCDIR} -w smoketest_physics.cpp -o a.out
./a.out > smoketest.log || exit 1
echo "Smoke test passes"

echo "Simulator test..."
g++ -std=c++11 -Wa,-mbig-obj -O0 -ggdb ${INCDIR} -w test-nbodySimulator.cpp -o a.out
./a.out | tee testnbodySimulator.log || exit 1
echo "Simulator test passes"

#rm -f a.out smoketest.log testinput.log testnbodySimulator.log