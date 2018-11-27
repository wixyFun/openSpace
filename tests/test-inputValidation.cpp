#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"

#include "NBPhysics.hpp"
#include <Eigen/Core>

typedef Eigen::Vector3d V;

TEST_CASE("Mass validation test [massIsValid]") {
    CHECK(massIsValid(0.0) == false);
    CHECK(massIsValid(1.0) == true);
    CHECK(massIsValid(-1.0) == false);
    CHECK(massIsValid(NAN) == false);
    CHECK(massIsValid(INFINITY) == false);
    CHECK(massIsValid(-INFINITY) == false);
    CHECK(massIsValid(DBL_EPSILON) == true);
    CHECK(massIsValid(-DBL_EPSILON) == false);
    CHECK(massIsValid(DBL_MAX) == true);
    CHECK(massIsValid(-DBL_MAX) == false);
}

TEST_CASE("Velocity validation test [velocityIsValid]") {
    CHECK(velocityIsValid(V(1.0, 1.0, 1.0)) == true);
    CHECK(velocityIsValid(V::Zero()) == true);
    CHECK(velocityIsValid(V(NAN, 0, 0)) == false);
    CHECK(velocityIsValid(V(0, NAN, 0)) == false);
    CHECK(velocityIsValid(V(0, 0, NAN)) == false);
    CHECK(velocityIsValid(V(INFINITY, 0, 0)) == false);
    CHECK(velocityIsValid(V(0, INFINITY, 0)) == false);
    CHECK(velocityIsValid(V(0, 0, INFINITY)) == false);
    CHECK(velocityIsValid(V(-INFINITY, 0, 0)) == false);
    CHECK(velocityIsValid(V(0, -INFINITY, 0)) == false);
    CHECK(velocityIsValid(V(0, 0, -INFINITY)) == false);
}

TEST_CASE("Coordinate validation test [coordinateIsValid]") {
    CHECK(coordinateIsValid(V(1.0, 1.0, 1.0)) == true);
    CHECK(coordinateIsValid(V::Zero()) == true);
    CHECK(coordinateIsValid(V(NAN, 0, 0)) == false);
    CHECK(coordinateIsValid(V(0, NAN, 0)) == false);
    CHECK(coordinateIsValid(V(0, 0, NAN)) == false);
    CHECK(coordinateIsValid(V(INFINITY, 0, 0)) == false);
    CHECK(coordinateIsValid(V(0, INFINITY, 0)) == false);
    CHECK(coordinateIsValid(V(0, 0, INFINITY)) == false);
    CHECK(coordinateIsValid(V(-INFINITY, 0, 0)) == false);
    CHECK(coordinateIsValid(V(0, -INFINITY, 0)) == false);
    CHECK(coordinateIsValid(V(0, 0, -INFINITY)) == false);
}