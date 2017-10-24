//=============================================================================
// ChaosVortexSphereB
// $Id: VortexSphereB.uc,v 1.2 2004/03/18 23:14:27 Melaneus Exp $
//=============================================================================
class VortexSphereB extends VortexSphere;

#exec AUDIO IMPORT FILE="Snds\vortex_sphereB_Destroyed.wav" NAME="vortex_sphereB_Destroyed" GROUP="Vortex"

// vars need to sync death sounds
var float DeathTime;
var bool bSetDeathTime;

// use this to set up death counter
simulated function PostBeginPlay()
{
  SetTimer(1.0, false);
}


// set up a time to play the death sounds but have it
// start about 3 seconds early to sync with the other effects
simulated function Timer()
{
/*   if (!bSetDeathTime)
   {
      DeathTime=Level.timeseconds + LifeSpan;
      bSetDeathTime=true;
   }
   if (bSetDeathTime  && Level.timeseconds > DeathTime - 3.25)
   {
      settimer(0.0, false);
      PlaySound(Sound'fpsWeaponPack.Vortex.vortex_sphereB_Destroyed', SLOT_None,1.0,,800);
   }
*/
	if ( !bSetDeathTime )
		SetTimer(LifeSpan - GetSoundDuration(Sound'fpsWeaponPack.Vortex.vortex_sphereB_Destroyed'), False);
	else
		PlaySound(Sound'fpsWeaponPack.Vortex.vortex_sphereB_Destroyed', SLOT_None,1.0,,800);
}


// have a nice effect of it collasping in on itself
simulated function Destroyed()
{
    Super.Destroyed();
    Spawn(class'ShockCombo').RemoteRole = ROLE_None;
}

defaultproperties
{
     StartSize=0.700000
     FinalSize=1.000000
     Skins(0)=FinalBlend'fpsWepTex.VortexFX.Lightning1'
}
