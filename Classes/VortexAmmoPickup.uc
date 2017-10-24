//=============================================================================
// VortexAmmoPickup
// $Id: VortexAmmoPickup.uc,v 1.2 2004/03/18 23:14:27 Melaneus Exp $
//=============================================================================
class VortexAmmoPickup extends UTAmmoPickup;

#exec OBJ LOAD FILE=PickupSounds.uax

defaultproperties
{
     AmmoAmount=1
     MaxDesireability=0.320000
     InventoryType=Class'fpsWeaponPack.VortexAmmo'
     PickupMessage="You picked up another Gravity Vortex."
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="FlakAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.BioAmmoPickup'
     CollisionHeight=8.250000
}
