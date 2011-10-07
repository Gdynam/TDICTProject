/**
 * Copyright 1998-2011 Epic Games, Inc. All Rights Reserved.
 */

//class TDMain extends FrameworkGame;

class TDMain extends GameInfo;


defaultproperties
{
	PlayerControllerClass=class'MyMod.TDPlayerController'

	HUDType=class'MyMod.TDHud'

	//DefaultPawnClass=class'MyMod.TDPawn'

	//PlayerControllerClass=class'UTPlayerController'
	//DefaultPawnClass=class'UTPawn'
	//HUDType=class'UDKBase.UDKHUD'
	//bWaitingToStartMatch=true

	//PopulationManagerClass=class'GameFramework.GameCrowdPopulationManager'
	bRestartLevel=false
	bDelayedStart=false
}



