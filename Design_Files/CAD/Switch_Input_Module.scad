// Switch Input Module for LipSync
// Makers Making Change
// V1.0
pinSpacing=2.54; //.100" spacing
boardWidth=21;
boardDepth=27.0;
boardHeight=3;//1.59;
headerDepth=2.54+.2;
headerHeight=8.46;
headerWidth=10.7+.4;
//headerPinWidth=.65+.2;//square side
headerPinWidth=.88+.6;//diameter increased twice was.4
headerPinPlugHeight=6;
headerPinTotalHeight=11.2;
ballDia=3; //for ballVia 


//pseudo header
difference(){
translate ([0,pinSpacing*4.5,headerHeight/2+boardHeight-.5])cube([headerWidth,headerDepth,headerHeight+1],center=true) ;
translate ([0,pinSpacing*4.5,headerPinTotalHeight/2-(boardHeight/2)])ArrayCentItems(4,1,pinSpacing,pinSpacing)cylinder (d=headerPinWidth,h=headerPinTotalHeight+5,center=true,$fn=12) ;
translate ([0,pinSpacing*4.5,11.5])ArrayCentItems(4,1,pinSpacing,pinSpacing)rotate([180,0, 45])cylinder (h=1.6,r1=1.6,r2=0,$fn=4);//(makes pyramid)
}//diff

translate ([0,9,7/2+boardHeight-.5])cube([6,2,7],center=true) ;  //brace
translate ([-6.2,-15,0])cube([11.4,2,.6],center=false) ;  //support material
//translate ([0,pinSpacing*4.5,headerPinTotalHeight/2-(boardHeight/2)])ArrayCentItems(4,1,pinSpacing,pinSpacing)cube([headerPinWidth,headerPinWidth,headerPinTotalHeight],center=true) ;
difference(){
union(){
translate ([0,pinSpacing*-4.5,headerHeight/2+boardHeight])cube([headerWidth+3,headerDepth+3,headerHeight],center=true) ;
translate ([-3+5,-1,boardHeight/2])roundedCube (boardWidth-10,boardDepth,boardHeight,1);//pseudo PCB board
translate ([-5,-1,boardHeight/2])minkowski(){//rounded body
scale([.75,1,1])cylinder(h = boardHeight-2, d = boardDepth-2, center = true,$fn=24);
sphere(r=1,center=true,$fn=30);
}  //end mink
translate ([-10,-1,boardHeight/2])minkowski(){//"tail"
cylinder(h = boardHeight-2, d = 12, center = true,$fn=24);
sphere(r=1,center=true,$fn=30);
}  //end mink
}//end union	
//cube([boardWidth,boardDepth,boardHeight],center=true) ;//pseudo PCB board
//roundedCube (boardWidth,boardDepth,boardHeight,1)


translate ([0,pinSpacing*-4.5,headerHeight/2+boardHeight])cube([headerWidth,headerDepth,headerHeight+10],center=true) ;
translate ([-.5, 5-3, 1])rotate([0,180, 0])resistorSlot (8,2.6,1.2,30);//5v 100k resistor slot
translate ([pinSpacing*1-.5, 5-3, 1])rotate([0,180, 0])resistorSlot (8,2.6,1,30);//0v 100k resistor slot




translate ([pinSpacing*-1-.5, 5-3, 1])rotate([0,180, 0])resistorSlot (0,3,1.2,30);// resistor wire
translate ([.3, -1-3, boardHeight/2])ballVia (boardHeight,1.2,ballDia);//5v 100K/10k resistor hole
translate ([pinSpacing*1+.3, -4-3, boardHeight/2])ballVia (boardHeight,1.2,ballDia);//0v 100k/10k resistor hole
translate ([-6, -1-3, 3])rotate([0,0, 90])resistorSlot (8,2.6,1.2,8+4);//0v 10k resistor slot (underside)
translate ([-3, -4-3, 3])rotate([0,0, 90])resistorSlot (8,2.6,1.2,8+4);//0v 10k resistor slot (underside)

translate ([.3-12, -1-3, boardHeight/2])ballVia (boardHeight,1.2,ballDia);//5v 10k resistor hole
translate ([pinSpacing*1+.3-12, -4-3, boardHeight/2])ballVia (boardHeight,1.2,ballDia);//0v 10k resistor hole


translate ([-.5,8,0])cube([5.5,3,3.3], center = true); //resistor solder clearance


translate ([-10,0,2.5])minkowski(){
cube([3,3,6], center = true); //cable thru hole
sphere(r=1,center=true,$fn=30);
}  //end mink

translate ([-5,2.5,2.5])cube([2.5,1.5,5], center = true); //cable tie  hole
translate ([-5,9.5,2.5])cube([2.5,1.5,5], center = true); //cable tie  hole
translate ([5,2.5,2.5])cube([2.5,1.5,5], center = true); //2nd cable tie  hole
translate ([5,9.5,2.5])cube([2.5,1.5,5], center = true); //2nd cable tie  hole

translate ([-4.5,-1,2.5])cylinder(d=3,h=15.1,center=true,$fn=16);//braid soldering hole
//translate ([0,-10,0])rotate([-30,0, 0])cube([11,5,3], center = true);//old header solder joint clearance

translate ([-3,-11,-1])hull() {
    translate([5,0,0]) rotate([0,0, 45])cylinder (h=5,r1=7,r2=0,$fn=4);//(makes pyramid)
    rotate([0,0, 45])cylinder (h=5,r1=7,r2=0,$fn=4);//(makes pyramid)
}//hull

}//end diff



//translate ([0,pinSpacing*-4.5,headerPinTotalHeight/2-(boardHeight/2)])ArrayCentItems(4,1,pinSpacing,pinSpacing)cube([headerPinWidth,headerPinWidth,headerPinTotalHeight],center=true) ;//***temporary
translate ([-5,6,4])rotate([0,0, 90])cableGrip (); // *** turned off 
//! ! ! ! !  ! ! !!!!!!!!!!!!!!  testing !!!!!!!!!!!!!!!!!!!!!!!!!

module cableGrip ()
difference(){
translate ([0, -2.5,0])cube([6,20,3], center = true);
translate ([0, -2.5,1])rotate([90,0, 0])cylinder(d=3,h=20.1,center=true,$fn=16); //cable slot
translate ([0, 0,1])rotate([90,0, 0])cylinder(d=4,h=4,center=true,$fn=16);// cable snagger
translate ([0, 0,2])rotate([90,0, 0])cube([6,5,3], center = true);//cinching slot in cable snagger
translate ([0, -10,1])rotate([90,0, 0])cylinder(d=4,h=4,center=true,$fn=16);// 2nd cable snagger
translate ([0, -10,2])rotate([90,0, 0])cube([6,5,3], center = true);//2nd cinching slot in cable snagger	
}//end module cable grip




module resistorSlot (compLeng,compDiam,wireDiam,wireLeng)
//example use:   resistorSlot (8,2.6,1,25);  //creates standard 1/4 watt resistor slot
{
	translate ([0, 0,compDiam/4])cube([compDiam,compLeng,compDiam/2], center = true);//component channel
rotate([90,0, 0]) cylinder(d=compDiam,h=compLeng,center=true,$fn=100);//component bed
translate ([0, 0,compDiam/4])cube([wireDiam,wireLeng,compDiam/2], center = true);//wire channel
rotate([90,0, 0]) cylinder(d=wireDiam,h=wireLeng,center=true,$fn=100);	//rounded wire bed
} //end resistor slot



module ballVia (pcbThick,boreDiam,sphereDiam)
//make sure sphereDiam is always less than board thickness!!!
{
//sphere(d = boreDiam,$fn=24);
//cylinder(D=boreDiam,h=pcbThick-sphereDiam,$fn=100);
	cylinder(h = pcbThick, d = boreDiam, center = true,$fn=24);
	translate ([0,0,pcbThick/2])sphere(d = sphereDiam,$fn=24);
	translate ([0,0,pcbThick/-2])sphere(d = sphereDiam,$fn=24);
	}//end module ballVia
	
	

module ArrayCentItems(xCount,yCount,itemGapX,itemGapY)
{
for (x = [1:xCount]){
for (y = [1:yCount]){
translate([x*itemGapX-(xCount+1)*itemGapX/2,y*itemGapY-(yCount+1)*itemGapY/2,0])
children();
}//for y
}//for x
}//end module

module CircleItems(n,r,myRot)
{
segment=360 / n;
for (i=[1:n])
{
rotate([0, 0, segment*i+myRot])
translate ([r,0,0])
children();
}//for
}//module


module roundedCube (myBoxWidth,myBoxDepth,myBoxHeight,minkRadius)
//** Same as regular cube, but with rounded sides and bottom
//** maintains proper 'cube' dimensions due to compensation for object expansion 
//** that normally occurs while using Minkowski operations in OpenSCAD)
{
union()
{

minkowski(){
cube([myBoxWidth-minkRadius*2,myBoxDepth-minkRadius*2,myBoxHeight-minkRadius*2], center = true);//Main plate   original cube([90,testSize8,8.5]
sphere(r=minkRadius,center=true,$fn=30);
}  //end mink


}//end union
}//end module roundedCube