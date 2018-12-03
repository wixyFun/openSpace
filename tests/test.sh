#!/bin/bash -e

set -o pipefail

INCDIR=
INCDIR+="-I../thirdparty/boost_1_68_0 "
INCDIR+="-I../thirdparty/eigen "
INCDIR+="-I../src/nbody "

echo "=============================="
echo "=============================="

echo "Static Analysis..."
cppcheck --enable=all --suppress=missingIncludeSystem ../src/
echo "Static Analysis passes"

echo "=============================="
echo "=============================="

echo "Smoke Test..."
g++ -std=c++11 -ggdb ${INCDIR} -w smoketest_physics.cpp -o a.out
./a.out > smoketest.log || exit 1
echo "Smoke test passes"

echo "=============================="
echo "=============================="

echo "Simulator test..."
#g++ -std=c++11 -Wa,-mbig-obj -O0 -ggdb ${INCDIR} -w test-nbodySimulator.cpp -o a.out
g++ -std=c++11 -O0 -ggdb ${INCDIR} -g -fprofile-arcs -ftest-coverage -w test-nbodySimulator.cpp -o a.out
./a.out | tee testnbodySimulator.log || exit 1
echo "Simulator test passes"

echo "=============================="
echo "=============================="

echo "Generating coverage report..."
gcov test-nbodySimulator -b -c -m
echo "=============================="
cat NBPhysics.hpp.gcov
echo "Coverage report done"

echo "=============================="
echo "=============================="


#rm -f a.out smoketest.log testinput.log testnbodySimulator.log