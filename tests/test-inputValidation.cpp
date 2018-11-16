#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#include "NBPhysics.hpp"
#include <Eigen/Core>

typedef Eigen::Vector3d V;

TEST_CASE("Mass validation test", "[massIsValid]") {
    REQUIRE(massIsValid(0.0) == false);
    REQUIRE(massIsValid(1.0) == true);
    REQUIRE(massIsValid(-1.0) == false);
    REQUIRE(massIsValid(NAN) == false);
    REQUIRE(massIsValid(INFINITY) == false);
    REQUIRE(massIsValid(-INFINITY) == false);
    REQUIRE(massIsValid(DBL_EPSILON) == true);
    REQUIRE(massIsValid(-DBL_EPSILON) == false);
    REQUIRE(massIsValid(DBL_MAX) == true);
    REQUIRE(massIsValid(-DBL_MAX) == false);
}

TEST_CASE("Velocity validation test", "[velocityIsValid]") {
    REQUIRE(velocityIsValid(V(1.0, 1.0, 1.0)) == true);
    REQUIRE(velocityIsValid(V::Zero()) == true);
    REQUIRE(velocityIsValid(V(NAN, 0, 0)) == false);
    REQUIRE(velocityIsValid(V(0, NAN, 0)) == false);
    REQUIRE(velocityIsValid(V(0, 0, NAN)) == false);
    REQUIRE(velocityIsValid(V(INFINITY, 0, 0)) == false);
    REQUIRE(velocityIsValid(V(0, INFINITY, 0)) == false);
    REQUIRE(velocityIsValid(V(0, 0, INFINITY)) == false);
    REQUIRE(velocityIsValid(V(-INFINITY, 0, 0)) == false);
    REQUIRE(velocityIsValid(V(0, -INFINITY, 0)) == false);
    REQUIRE(velocityIsValid(V(0, 0, -INFINITY)) == false);
}

TEST_CASE("Coordinate validation test", "[coordinateIsValid]") {
    REQUIRE(coordinateIsValid(V(1.0, 1.0, 1.0)) == true);
    REQUIRE(coordinateIsValid(V::Zero()) == true);
    REQUIRE(coordinateIsValid(V(NAN, 0, 0)) == false);
    REQUIRE(coordinateIsValid(V(0, NAN, 0)) == false);
    REQUIRE(coordinateIsValid(V(0, 0, NAN)) == false);
    REQUIRE(coordinateIsValid(V(INFINITY, 0, 0)) == false);
    REQUIRE(coordinateIsValid(V(0, INFINITY, 0)) == false);
    REQUIRE(coordinateIsValid(V(0, 0, INFINITY)) == false);
    REQUIRE(coordinateIsValid(V(-INFINITY, 0, 0)) == false);
    REQUIRE(coordinateIsValid(V(0, -INFINITY, 0)) == false);
    REQUIRE(coordinateIsValid(V(0, 0, -INFINITY)) == false);
}