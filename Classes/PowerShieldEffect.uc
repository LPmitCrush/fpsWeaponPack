//=========================================================================
// PowerShieldEffect
// ========================================================================
class PowerShieldEffect extends ShieldEffect;

function PostNetBeginPlay()
{
    Super.PostNetBeginPlay();	
}

function Flash(int Drain)
{
    Brightness = FMin(Brightness + Drain / 2, 250.0);
   // SetTimer(0.2, false);
}

function Timer()
{

}

function SetBrightness(int b)
{
    DesiredBrightness = FMin(50+b*2, 250.0);
}

defaultproperties
{
     StaticMesh=StaticMesh'AWStellarMeshes.Skies.Skyball'
     DrawScale=0.600000
     DrawScale3D=(X=0.600000,Y=0.600000,Z=0.950000)
     Skins(0)=FinalBlend'XEffectMat.Shield.RedShell'
     Skins(1)=FinalBlend'XEffectMat.Shield.RedShell'
}
