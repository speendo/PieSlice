// PieTest

/**
* @author: Marcel Jira

 * This module generates a pie slice in OpenSCAD. It is inspired by the
 * [dotscad](https://github.com/dotscad/dotscad)
 * project but uses a different approach.
 * I cannot say if this approach is worse or better.

 * @param float radius Radius of the pie
 * @param float angle  Angle (size) of the pie to slice
 * @param float height Height (thickness) of the pie
 * @param float spin   Angle to spin the slice on the Z axis
 */
module pie(radius, angle, height, spin=0) {
	// submodules
	module pieCube() {
		translate([-radius - 1, 0, -1]) {
			cube([2*(radius + 1), radius, height + 2]);
		}
	}

	ang = abs(angle % 360);
	
	negAng = angle < 0 ? angle : 0;
	
	rotate([0,0,negAng + spin]) {
		if (angle == 0) {
			cylinder(r=radius, h=height);
		} else if (abs(angle) > 0 && ang <= 180) {
			difference() {
				intersection() {
					cylinder(r=radius, h=height);
					translate([0,0,0]) {
						pieCube();
					}
				}
				rotate([0, 0, ang]) {
					pieCube();
				}
			}
		} else if (ang > 180) {
			intersection() {
				cylinder(r=radius, h=height);
				union() {
					translate([0, 0, 0]) {
						pieCube();
					}
					rotate([0, 0, ang - 180]) {
						pieCube();
					}
				}
			}
		}
	}
}

pie(radius=10, angle=-1000, height=20, spin = 0);
