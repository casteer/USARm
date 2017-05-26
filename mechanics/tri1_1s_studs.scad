// Idea for a continuum robot inspired by the paper by Peng Qi et al, A Novel  ContinuumStyle  Robot  with  Multilayer  Compliant  Modules
// The idea needs many modules which are attached to a rope/string tendon which causes the bending motion. 
// Each module must push back to no deflection state when no force is applied to the tendon
//See also 2001-11-01, Ortho-Planar Linear-Motion Springs, by John J. Parise, Larry L. Howell,Spencer P. Magleby

// The parameters of the springs - adjust for better printing  
a=1.0;// Controls the short legs of the spring's zig-zag lines and the overall height of the spring
b=8;// Controls the line width of the springs
c=1;// Line thickness of the spring's zig-zag line 
t=3;// The overall thickness of the whole item 
n=2.5;// Number of repeating units of zig-zags 


// - Use these to centre the spring zig zag legs and connect them to the frame 
s=6;// Distance the zig-zag legs are apart
wa=4;
wb=4;

// This module produces three bisprings with the hexagonal symmetry (120 degrees rotated apart)
module trispring(){

// Loop over the bisprings and rotate each one by 120 degrees
for(r=[0:2]){
rotate([0,0,120*r])
translate([wa+1,s+0.5*b+0.5*wb+1,0])
bispring();
}

// The central disk with M4 hole in it
difference(){
	cylinder(r=sqrt(wa*wa+wb*wb),h=t,center=true);
	cylinder(d=4.0,h=2*t,center=true,$fn=60);
}

}



// The tri1_1s unit itself 
module tri1_1s(){

intersection(){

//For screw holes around the edge
difference (){

	union(){
        // The three bisprings 
		trispring();
        
        // The hexagonal outer edge of the object
		difference (){
			cylinder(d=100,h=t,center=true,$fn=6);
			cylinder(d=95,h=1.2*t,center=true,$fn=6);
		}

		// Fill-in areas next to the bi-springs
		for(r=[0:2]){
			intersection(){
				rotate([0,0,120*r])
				translate([0,36,0])
				rotate([90,0,0])
				cube([90,t,12],center=true);
				cylinder(d=100,h=t,center=true,$fn=6);
				}
			}		
		}
}

		cylinder(d=100,h=t*5,center=true,$fn=6);

}

	
}

// Two zig-zag structures together 
module bispring(){

//translate([0,2*s+b+1.5*a-5,0])
union(){
translate([0,s,0])
spring();
translate([ 8*a*n+4*a ,-s,0])
rotate([0,0,180])
spring();

translate([8*a*n+4*a+a ,0,0])
cube([wa-1,wb+2*b+c,t],center=true);

translate([-wa*0.5+1.5,2+s+0.5*b,0])
cube([wa,15+wb,t],center=true);

translate([-wa*0.5+1.5,-s-0.5*b,0])
cube([wa,wb,t],center=true);

// Area next to the bispring

for(i=[-4:7]){
translate([-wa*0.5+i*wa+1.5,s+0.5*b+wb+1,0])
cube([wa,wb,t],center=true);
}

}

}

// The zig zag wiggle structure (two of these make a bispring)
module spring(){

translate([4*a*n+2*a,-b*0.5,0])
union(){

for(i=[-n:n]){

translate ([4*a*i,0,0])
union(){
translate([-a,0.5*b,0])
cube([c,b,t],center=true);

translate([1.5*a,b,0])
cube([a,c,t],center=true);

translate([-1.5*a,b,0])
cube([a,c,t],center=true);

cube([2*a,c,t],center=true);

translate([a,0.5*b,0])
cube([c,b,t],center=true);

translate([a,0,0])
cylinder(d=c,h=t,center=true,$fn=60);

translate([a,b,0])
cylinder(d=c,h=t,center=true,$fn=60);

translate([-a,b,0])
cylinder(d=c,h=t,center=true,$fn=60);


translate([-a,0,0])
cylinder(d=c,h=t,center=true,$fn=60);
};
}
}

}

// This is the tri1_1s just with some M4 holes in the outside
module tri_ver2 (){

difference(){
	tri1_1s();

	union(){
		for(r=[0:2]){
			rotate([0,0,120*r])
			translate([0,37.5,0])
			cylinder(d=4.0-0.4,h=2*t,center=true,$fn=60);

			rotate([0,0,120*r])
			translate([-20,37.5,0])
			cylinder(d=4.0-0.4,h=2*t,center=true,$fn=60);

			rotate([0,0,120*r])
			translate([20,37.5,0])
			cylinder(d=4.0-0.4,h=2*t,center=true,$fn=60);

			}
	}
}
}


module tri_ver2_with_studs(){
    
union(){
tri1_1s();

stand_height = 38/1.6;
translate([0,0,0.5*stand_height])
union(){
    		for(r=[0:2]){
			intersection(){
				rotate([0,0,120*r])
				translate([0,38,0])
				rotate([90,0,0])
				cube([100,stand_height ,12],center=true);
				cylinder(d=100,h=stand_height ,center=true,$fn=6);
				}
			}		
		}
    }    
// tri_ver2();

translate([0,0,1+38/1.6])
	union(){
		for(r=[0:2]){
//			rotate([0,0,120*r])
//			translate([0,37.5,0])
//			cylinder(d=4.0,h=2*t,center=true,$fn=60);

			rotate([0,0,120*r])
			translate([-20,37.5,0])
			cylinder(d=4.0,h=2*t,center=true,$fn=60);

			rotate([0,0,120*r])
			translate([20,37.5,0])
			cylinder(d=4.0,h=2*t,center=true,$fn=60);

			}
	}
}


module lower_part_tri_ver3(){
    
difference(){

        tri_ver2_with_studs();
    
        translate([0,0,25])
		for(r=[0:2]){
			rotate([0,0,120*r])
			translate([0,37.5,0])
			cylinder(d=4.0,h=200,center=true,$fn=60);

			rotate([0,0,120*r])
			translate([0,45,0])
			cylinder(d=25.0,h=5,center=true,$fn=60);
        }
}

}

module upper_part_tri_ver3(){
    translate([0,0,50])
    union(){
        tri_ver2();
		cylinder(d=11.0,h=50,$fn=60);
        
        translate([0,0,50])
		cylinder(d=3.8,h=5,$fn=60);

//        translate([0,0,50])
//		cylinder(r1=0.5*11,r2=0.5*3.8,h=2,$fn=60);
    }
    
}

translate([0,0,50])
upper_part_tri_ver3();

lower_part_tri_ver3();
