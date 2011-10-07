/**
* Camera class
* 
* Author: Serkan, Kenny, Niels
* 
**/

class TDCamera extends Camera;

var int TargetFreeCamDistance;
var int zoomPerSecond;
var int zoomAmmout;
var int maxZoom;
var int minZoom;


var int xScrollLocation;
var int yScrollLocation;
var bool bSideScrolling;

var bool bRightScrolling;
var bool bLeftScrolling;
var bool bTopScrolling;
var bool bBotScrolling;

var int ScrollPerSecond;

/**
 * Adjust the *desired* camera distance
**/
function zoomIn() 
{
	TargetFreeCamDistance = FMax(TargetFreeCamDistance - zoomAmmout, minZoom);
}
function zoomOut() 
{
	TargetFreeCamDistance = FMin(TargetFreeCamDistance + zoomAmmout, maxZoom);
}
/**
 * Geliedelijk aan Zooming Functie 
 */
function ZoomCalc(float dt)
{
	if (TargetFreeCamDistance < FreeCamDistance) {
		FreeCamDistance = FMax(FreeCamDistance - dt * zoomPerSecond, TargetFreeCamDistance);
	} else {
		FreeCamDistance = FMin(FreeCamDistance + dt * zoomPerSecond, TargetFreeCamDistance);
	}
}

/**
 * Smoot Side Scrolling , 4 moves Top, Bot, Left, Right
 */
function ScrollCalc(float dt,out vector Loc)
{
	if(bRightScrolling)
		xScrollLocation -= dt * zoomPerSecond;
	else if(bLeftScrolling)
		xScrollLocation += dt * zoomPerSecond;
	else if(bTopScrolling)
		yScrollLocation += dt * zoomPerSecond;
	else if(bBotScrolling)
		yScrollLocation -= dt * zoomPerSecond;

	Loc.X = xScrollLocation;
	Loc.Y = yScrollLocation;
}

/**
 * Update the camera every frame
*/
function UpdateViewTarget(out TViewTarget OutVT, float DeltaTime)
{
	ZoomCalc(DeltaTime);
	OutVT.POV.FOV = DefaultFOV;

	OutVT.POV.Location = PCOwner.Location;

	ScrollCalc(DeltaTime,OutVT.POV.Location);

	OutVT.POV.Location -= Vector(PCOwner.Rotation) * FreeCamDistance;
	OutVT.POV.Rotation = PCOwner.Rotation;
	
	ApplyCameraModifiers(DeltaTime, OutVT.POV);
}

defaultproperties
{
	DefaultFOV=90.f
	TargetFreeCamDistance=256
	zoomPerSecond=2048
	zoomAmmout=32
	maxZoom=1088
	minZoom=400

	xScrollLocation=0
	yScrollLocation=0
	bSideScrolling=false

	bRightScrolling=false
	bLeftScrolling=False
	bTopScrolling=False
	bBotScrolling=false

	ScrollPerSecond=1024
}
