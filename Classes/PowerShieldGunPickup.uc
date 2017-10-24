//=========================================================================
// PowerShieldGunPickup
// ========================================================================
class PowerShieldGunPickup extends UTWeaponPickup;

#exec OBJ LOAD FILE="fpsWepMesh.usx"

defaultproperties
{
     MaxDesireability=0.390000
     InventoryType=Class'fpsWeaponPack.PowerShieldGun'
     PickupMessage="You got the Power Shield Gun."
     PickupSound=Sound'PickupSounds.ShieldGunPickup'
     PickupForce="ShieldGunPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'fpsWepMesh.Shield.PowerShieldGunPickup'
     DrawScale=0.750000
}
