//=============================================================================
// SuperShockRiflePickup
//=============================================================================
class MagicWandPickup extends UTWeaponPickup;

defaultproperties
{
     MaxDesireability=0.650000
     InventoryType=Class'fpsWeaponPack.MagicWandWeapon'
     PickupMessage="You got the Magic Wand."
     PickupSound=Sound'PickupSounds.ShockRiflePickup'
     PickupForce="ShockRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.ShockRiflePickup'
     DrawScale=0.500000
}
