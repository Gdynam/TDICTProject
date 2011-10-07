/**
 * TDPlayerController
 *
 * Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
 * 
 * PlayerControllers are used by human players to control pawns.
 * 
 * Author:  Serkan, Niels, Kenny
 * 
 */

class TDPlayerController extends GamePlayerController;

simulated event PostBeginPlay() {
	local Rotator Rot;

	super.PostBeginPlay();
	
	Rot.Pitch = (-55.f      *DegToRad) * RadToUnrRot;    //-55 deg
	Rot.Roll =  0;							            //0 deg
	Rot.Yaw =   (90.f      *DegToRad) * RadToUnrRot;    //90 def
	
	SetRotation(Rot);

	SetLocation(Location + vect(0,0,1200));	//put the player "in the air".
}

simulated event PlayerTick(float DeltaTime) {
	//`log("Rotation " @ Rotation );
}

/**
 * Uitvoer/executie functies die opgeroepen worden door de Speler
 */
exec function ZoomIn()
{
	TDCamera(PlayerCamera).zoomIn();
}
exec function ZoomOut()
{
	TDCamera(PlayerCamera).zoomOut();
}


exec function LeftMouse()
{
	local TDHud THUD;
	local Vector SpawnLocation;
	
	THUD = TDHud(myHUD);
	THUD.bNeedsLogging = true;
	if(THUD.bIsSpawnable){
		SpawnLocation = THUD.MouseWorldLocatie;
		Spawn(class'TDSpawnTower',,,SpawnLocation,Rotator(vect(0,0,0)),,);
	}
	THUD.bSpawnIndicater=False;

}

exec function RightMouse()
{
	local TDHud THUD;
	THUD = TDHud(myHUD);
	
	THUD.bSpawnIndicater=true;
}


/**
 * Event Handlers for Sidescrolling
 * OnPress
 * OnRelease
 */
exec function onPressBot()
{
	TDCamera(PlayerCamera).bBotScrolling=True;
}
exec function ReleaseBot()
{
	TDCamera(PlayerCamera).bBotScrolling=false;
}
exec function onPressTop()
{
	TDCamera(PlayerCamera).bTopScrolling=True;
}
exec function ReleaseTop()
{
	TDCamera(PlayerCamera).bTopScrolling=false;
}
exec function onPressLeft()
{
	TDCamera(PlayerCamera).bLeftScrolling=True;
}
exec function ReleaseLeft()
{
	TDCamera(PlayerCamera).bLeftScrolling=false;
}
exec function onPressRight()
{
	TDCamera(PlayerCamera).bRightScrolling=True;
}
exec function ReleaseRight()
{
	TDCamera(PlayerCamera).bRightScrolling=false;
}


defaultproperties
{
  CameraClass=class'MyMod.TDCamera'
}