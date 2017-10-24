class NuclearShockRifleAmmoPickup extends ShockAmmoPickup;
	
defaultproperties
{
    AmmoAmount=10
    InventoryType=Class'fpsWeaponPack.NuclearShockRifleAmmo'
    PickupMessage="You picked up a Nuclear Shock Core."
    PickupSound=Sound'PickupSounds.ShockAmmoPickup'
    PickupForce="ShockAmmoPickup"
    DrawType=DT_StaticMesh
    StaticMesh=StaticMesh'WeaponStaticMesh.ShockAmmoPickup'
    DrawScale3D=(X=0.80,Y=1.00,Z=0.50),
    PrePivot=(X=0.00,Y=0.00,Z=32.00),
    CollisionHeight=32.00
}
