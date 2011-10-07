class TDGfxMoviePlayer extends GFxMoviePlayer;

var int MouseX;
var int MouseY;

function Init(optional LocalPlayer LocalPlayer)
{
  // Initialize the ScaleForm movie
  Super.Init(LocalPlayer);

  Start();
  Advance(0);

}

// from Flash.
function ReceiveMouseCoords( float x, float y )
{
	MouseX = x;
	MouseY = y;
}

DefaultProperties
{
	bDisplayWithHudOff = false
	//bGammaCorrection = false
	
	MovieInfo = SwfMovie'TDMouseCursor.MouseCursor'
}