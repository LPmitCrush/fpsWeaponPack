//=============================================================================
// ChaosVortexSphere
// $Id: VortexSphere.uc,v 1.2 2004/03/18 23:14:27 Melaneus Exp $
//=============================================================================
class VortexSphere extends Actor;

var float StartLifespan;
var() float StartSize, FinalSize, CollapseTime;

var bool bStartedCollapsing;

event Tick(float deltatime)
{
	local float timescaler;

	if ( StartLifespan == 0 )
		StartLifespan = Lifespan;

    if ( lifespan > CollapseTime )
		timescaler = Lerp((LifeSpan - CollapseTime) / (StartLifespan - CollapseTime), FinalSize, StartSize);
	else
		timescaler = Lerp(LifeSpan / CollapseTime, 0.1, FinalSize);

	SetDrawScale(timescaler);
	ScaleGlow = (timescaler);
}

defaultproperties
{
     StartSize=2.700000
     FinalSize=3.500000
     CollapseTime=0.500000
     LightEffect=LE_FastWave
     LightHue=170
     LightSaturation=76
     LightBrightness=102.000000
     LightRadius=255.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'fpsWepMesh.Vortex.ChaosSphere1'
     bLightChanged=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_None
     Skins(0)=FinalBlend'XEffectMat.Shock.ShockDarkFB'
     bUnlit=True
}
