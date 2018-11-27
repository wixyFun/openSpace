#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#include "NBPhysics.hpp"
#include <Eigen/Core>

typedef Eigen::Vector3d V;

TEST_CASE("Numerical test", "[NBPhysics]") {
    NBodySimulator sim(2.95912208286e-4);
    // Sun
    sim.addPoint(Eigen::Vector3d(0.0, 0.0, 0.0),
                 Eigen::Vector3d(0.0, 0.0, 0.0),
                 1.00000597682);
    // Jupiter
    sim.addPoint(Eigen::Vector3d(-3.5023653, -3.8169847, -1.5507963),
                 Eigen::Vector3d(0.00565429 , -0.00412490 , -0.00190589),
                 0.000954786104043);
    // Saturn
    sim.addPoint(Eigen::Vector3d(9.0755314, -3.0458353, -1.6483708),
                 Eigen::Vector3d(0.00168318 , 0.00483525 , 0.00192462),
                 0.000285583733151);
    // Uranus
    sim.addPoint(Eigen::Vector3d(8.3101420, -16.2901086, -7.2521278),
                 Eigen::Vector3d(0.00354178 , 0.00137102 , 0.00055029),
                 0.0000437273164546);
    // Pluto
    sim.addPoint(Eigen::Vector3d(-15.5387357, -25.2225594, -3.1902382),
                 Eigen::Vector3d(0.00276725 , -0.00170702 , -0.00136504),
                 7.692307692307693e-09);

    const double dt = 100.0;
    const VectorXs &qs = sim.getQs();
    VectorXs qref;
    qref.push_back(Eigen::Vector3d(0.0, 0.0, 0.0));
    qref.push_back(Eigen::Vector3d(-3.5023653, -3.8169847, -1.5507963));
    qref.push_back(Eigen::Vector3d(9.0755314, -3.0458353, -1.6483708));
    qref.push_back(Eigen::Vector3d(8.3101420, -16.2901086, -7.2521278));
    qref.push_back(Eigen::Vector3d(-15.5387357, -25.2225594, -3.1902382));
    REQUIRE(qs == qref);
}