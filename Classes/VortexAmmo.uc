//=============================================================================
// VortexAmmo
// $Id: VortexAmmo.uc,v 1.3 2004/05/03 00:21:34 shuri Exp $
//=============================================================================
class VortexAmmo extends Ammunition;

// Mutant Game Time Fix
// This is a quick check to limit the maximum ammo amount in the Mutant Game type
// as the default would have been 999. Eeeekkkkk!
function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (Level.Game.IsA('xMutantGame')) // if this is a mutant game set the timer
		SetTimer(1.0, true);
}

function Timer()
{
	Super.Timer();
	If (MaxAmmo > Default.MaxAmmo)  // if you have more than the max defualt, reset the max to the default a
	{
		MaxAmmo = Default.MaxAmmo;
		AmmoAmount = Min(AmmoAmount, MaxAmmo);  // then set the ammo ammount to the defaul max value.
	}
}
// End Mutant Game Type fix

defaultproperties
{
     MaxAmmo=1
     InitialAmount=1
     PickupClass=Class'fpsWeaponPack.VortexAmmoPickup'
     ItemName="Gravity Vortex Ammo"
}
