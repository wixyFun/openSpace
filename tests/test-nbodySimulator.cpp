#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#include "NBPhysics.hpp"
#include <Eigen/Core>

typedef Eigen::Vector3d V;

bool almost_equal(const Eigen::Vector3d& v1, const Eigen::Vector3d& v2,
    double eps = 1e-10) {
        auto dv = v1 - v2;
        return dv(0) < eps && dv(1) < eps && dv(2) < eps;
    }

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
    const VectorXs &ps = sim.getPs();
    VectorXs qref, pref;
    qref.push_back(Eigen::Vector3d(0.0, 0.0, 0.0));
    qref.push_back(Eigen::Vector3d(-3.5023653, -3.8169847, -1.5507963));
    qref.push_back(Eigen::Vector3d(9.0755314, -3.0458353, -1.6483708));
    qref.push_back(Eigen::Vector3d(8.3101420, -16.2901086, -7.2521278));
    qref.push_back(Eigen::Vector3d(-15.5387357, -25.2225594, -3.1902382));
    REQUIRE(qs == qref);

    qref.push_back(Eigen::Vector3d(-2.5381705249737434e-005,-3.6888595453054651e-005,-1.5252117911871189e-005));
    qref.push_back(Eigen::Vector3d(-2.9058545717814241,-4.1923795641490118,-1.726241987842063));
    qref.push_back(Eigen::Vector3d(9.2290625935508892,-2.5576435413849277,-1.4533453789682504));
    qref.push_back(Eigen::Vector3d(8.6626807384609492,-16.149847603128382,-7.1956920749159661));   
    qref.push_back(Eigen::Vector3d(-15.261145670710635,-25.391845888777812,-3.3265611552430148));
    sim.do_step(0, dt);
    REQUIRE(almost_equal(qref[0], qs[0]));
    REQUIRE(almost_equal(qref[1], qs[1]));
    REQUIRE(almost_equal(qref[2], qs[2]));
    REQUIRE(almost_equal(qref[3], qs[3]));
    REQUIRE(almost_equal(qref[4], qs[4]));
}