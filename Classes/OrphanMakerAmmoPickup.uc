class OrphanMakerAmmoPickup extends UTAmmoPickup;

defaultproperties
{
     AmmoAmount=10
     MaxDesireability=0.320000
     InventoryType=Class'fpsWeaponPack.OrphanMakerAmmo'
     PickupMessage="You picked up Orphan Maker Ammo, YAY."
     PickupSound=Sound'PickupSounds.FlakAmmoPickup'
     PickupForce="FlakAmmoPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.FlakAmmoPickup'
     DrawScale=0.800000
     PrePivot=(Z=6.500000)
     CollisionHeight=8.250000
}
