#include "gdnbody.h"

#include <Eigen/Core>

using namespace godot;

void gdnbody::_register_methods() 
{
    register_method((char*)"init", &gdnbody::init);
    register_method((char*)"step", &gdnbody::step);
    register_method((char*)"addBody", &gdnbody::addBody);
    register_method((char*)"getNumBody", &gdnbody::getNumBody);
    register_method((char*)"getX", &gdnbody::getX);
    register_method((char*)"getV", &gdnbody::getV);
    register_method((char*)"getM", &gdnbody::getM);
    // register_method((char*)"setX", &gdnbody::setX);
    // register_method((char*)"setV", &gdnbody::setV);
    // register_method((char*)"setM", &gdnbody::setM);
    register_method((char*)"getXs", &gdnbody::getXs);
    register_method((char*)"getVs", &gdnbody::getVs);
    register_method((char*)"getMs", &gdnbody::getMs);
}

gdnbody::gdnbody() : m_time(0.0), m_simulator(nullptr)
{
}

gdnbody::~gdnbody()
{
    if (!m_simulator) {
        delete m_simulator;
    }
}

void gdnbody::init(double G)
{
    m_simulator = new NBodySimulator(G);
    m_time = 0.0;
}

void gdnbody::step(double delta)
{
    m_simulator->do_step(m_time, delta);
    m_time += delta;
}

void gdnbody::addBody(double m, double x, double y, double z,
                      double vx, double vy, double vz)
{
    Eigen::Vector3d q(x, y, z);
    Eigen::Vector3d v(vx, vy, vz);
    m_simulator->addPoint(q, v, m);
}

int gdnbody::getNumBody() const 
{
    return m_simulator->getQs().size();
}

Vector3 gdnbody::getX(int index) const
{
    const Eigen::Vector3d& X = m_simulator->getQs()[index];
    return Vector3(X(0), X(1), X(2));
}

Vector3 gdnbody::getV(int index) const
{
    Eigen::Vector3d V = m_simulator->getV(index);
    return Vector3(V(0), V(1), V(2));
}

double gdnbody::getM(int index) const
{
    return m_simulator->getM(index);
}

// void gdnbody::setX(int index, const Vector3& x)
// {

// }

// void gdnbody::setV(int index, const godot::Vector3& V)
// {

// }

// void gdnbody::setM(int index, double m)
// {

// }

Array gdnbody::getXs() const
{
    Array a;
    for (int i=0; i<getNumBody(); ++i) {
        a.push_back(getX(i));
    }
    return a;
}

Array gdnbody::getVs() const
{
    Array a;
    for (int i=0; i<getNumBody(); ++i) {
        a.push_back(getV(i));
    }
    return a;
}

Array gdnbody::getMs() const
{
    Array a;
    for (int i=0; i<getNumBody(); ++i) {
        a.push_back(getM(i));
    }
    return a;
}