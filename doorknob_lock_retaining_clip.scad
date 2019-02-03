// Doorknob Lock Retaining Clip
// =============================
// This clip was designed to fit over a standard 50mm diameter doorknob
// and retain the centre locking button in the pressed/locked position.

$fn           = 120.0; // make smaller for faster rendering
HANDLE_RADIUS =  25.5; // Standard 50mm dooknob
HANDLE_DEPTH  =  38.0; // Depends on the design of the doorknob 
THICKNESS     =   2.0; // 2mm seems about right for most materials

difference()
{
  clasp();
  handle();
  bore();
  gaps();
  grasp_champher();
  //cross_section();  // used during design to inspect internal cross-section 
}  

module grasp_champher()
{
  translate([0,0,HANDLE_RADIUS*.87]) cylinder(HANDLE_RADIUS/4,HANDLE_RADIUS/1.50,0,true);
}  
module gaps()
{
    for (i = [0:120:240])
    {    
      rotate(a = i) rotate_extrude(angle=90,convexity=10)
      translate([HANDLE_RADIUS/2,-(HANDLE_RADIUS),0]) square([HANDLE_RADIUS+THICKNESS,2*(HANDLE_RADIUS+THICKNESS)],false);
    }
}  

module bore()
{
  translate([0,0,HANDLE_RADIUS/2]) cylinder(HANDLE_RADIUS,HANDLE_RADIUS*.55,HANDLE_RADIUS*.55,true);
}

module handle()
{
  difference()
  {
    intersection()
    {
      sphere(HANDLE_RADIUS);
      cube([2*HANDLE_RADIUS,2*HANDLE_RADIUS,HANDLE_DEPTH],true);
    }  
    translate([0,0,-HANDLE_DEPTH-1.42]) sphere(HANDLE_RADIUS);
  }
}  

module clasp()
{
  difference()
  {
    intersection()
    {
      sphere(HANDLE_RADIUS+THICKNESS);
      cube([2*(HANDLE_RADIUS+THICKNESS),2*(HANDLE_RADIUS+THICKNESS),HANDLE_DEPTH+2*THICKNESS],true);
    }  
  }
}  

// The cross_section() module is simply a large cube offset with one
// face through the origin and used as a working sectioning tool
module cross_section()
{
  translate([0,-50,0]) cube([100,100,100],true);
}  