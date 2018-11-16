#ifndef __GDNBODY_H__
#define __GDNBODY_H__

#include <Godot.hpp>
#include <Node.hpp>
#include <Vector3.hpp>
#include "NBPhysics.hpp"

namespace godot {
    class gdnbody : public godot::GodotScript<Node> {
        GODOT_CLASS(gdnbody)
    public:
        static void _register_methods();

        gdnbody();
        ~gdnbody();

        void init(double G);

        void step(double delta);
        void addBody(double m, double x, double y, double z,
                     double vx, double vy, double vz);

        int getNumBody() const;

        godot::Vector3 getX(int index) const;
        godot::Vector3 getV(int index) const;
        double getM(int index) const;

        // void setX(int index, const godot::Vector3& X);
        // void setV(int index, const godot::Vector3& V);
        // void setM(int index, double m);

        godot::Array getXs() const;
        godot::Array getVs() const;
        godot::Array getMs() const;

    private:
        NBodySimulator* m_simulator;
        double m_time;
    };
}

#endif