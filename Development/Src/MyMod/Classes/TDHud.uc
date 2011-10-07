class TDHud extends UDKHUD;

//Gfx player,   flash-ingame hud
var TDGfxMoviePlayer           HudMovie;

//Mouse position in game
var vector      MouseWorldLocatie;
var Vector      HitnormalMouse3D;
var TDDecals    MouseIndicator;
var MaterialInstanceConstant MouseIndicatorMaterial;
var bool        bSpawnIndicater;
var bool        bIsSpawnable;
var bool        bNeedsLogging;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();


	HudMovie = new () class'TDGfxMoviePlayer';

	HudMovie.SetTimingMode( TM_Game);
	HudMovie.SetViewScaleMode( SM_NoScale );
	HudMovie.Init(class'Engine'.static.GetEngine().GamePlayers[HudMovie.LocalPlayerOwnerIndex]);
}

simulated event Destroyed()
{
  Super.Destroyed();
  
  // If the ScaleForm movie exists, then destroy it
  if (HudMovie != None)
  {
    HudMovie.Close(true);
    HudMovie = None;
  }
}

function PreCalcValues()
{
  Super.PreCalcValues();

  // If the ScaleForm movie exists, then reset it's viewport, scale mode and alignment to match the
  // screen resolution

    HudMovie.SetViewport(0, 0, SizeX, SizeY);
    HudMovie.SetViewScaleMode(SM_NoScale);
    HudMovie.SetAlignment(Align_TopLeft);  
  
}

function Vector2d GetMouseCoords()
{
	local Vector2d mousePos;

	mousePos.X = HudMovie.MouseX;
	mousePos.Y = HudMovie.MouseY;

	return mousePos;
}

function Vector GetMouseWorldLocation()
{
  local Vector2D MousePosition;
  local Vector MouseWorldOrigin, MouseWorldDirection, HitLocation, HitNormal;
  local TraceHitInfo HitInfo;
  local Actor geraakt;
  local StaticMeshActor smGeraakt;

  MousePosition = GetMouseCoords();

  // Deproject the mouse position and store it in the cached vectors
  Canvas.DeProject(MousePosition, MouseWorldOrigin, MouseWorldDirection);

   geraakt = Trace(HitLocation, HitNormal, MouseWorldOrigin + MouseWorldDirection * 65536.f, MouseWorldOrigin , true,,HitInfo, TRACEFLAG_Bullet);
	  if(geraakt.Tag == 'Vloer' ){
		bIsSpawnable = true;
	  }else{
		bIsSpawnable = false;
	  }
  if(bNeedsLogging){

	bNeedsLogging = false;
  }
  HitnormalMouse3D=HitNormal;

  return HitLocation;
}

event PostRender()
{
	Super.PostRender();
}

// circle indication where we can spawn a object
function RenderMouseIndication()
{
    if(MouseIndicator == none)
	{
			MouseIndicator = Spawn(class'TDDecals', , ,MouseWorldLocatie, Rotator(vect(0,0,0)*-1), , true);

			if(MouseIndicator != none)
			{

				MouseIndicator.Decal.SetDecalMaterial(MouseIndicatorMaterial);
				MouseIndicator.Decal.Width = 500;
				MouseIndicator.Decal.Height = 500;
			}
	}

	if(MouseIndicator != none)
	{
			MouseIndicator.SetLocation(MouseWorldLocatie +(HitnormalMouse3D*48));
			MouseIndicator.SetRotation(Rotator(HitnormalMouse3D * -1));
	}

}

function DrawHUD()
{
	
	MouseWorldLocatie = GetMouseWorldLocation();

	if(bSpawnIndicater)
		RenderMouseIndication();

	Canvas.SetDrawColor( 255, 255, 200, 255 );
	Canvas.SetPos( 10.0, 10.0 );
	Canvas.DrawText( "WorldMouse: X:" $ MouseWorldLocatie.X $ ", Y:" $ MouseWorldLocatie.Y $ ", Z:" $ MouseWorldLocatie.Z );

}

DefaultProperties
{
	MouseIndicatorMaterial=MaterialInstanceConstant'TD_Assets.Effects.MI_RingIndicator'

	bSpawnIndicater=false
}