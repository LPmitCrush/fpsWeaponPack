//=============================================================================
// SSRMinigunPickup
//=============================================================================
class TeslaPickup extends UTWeaponPickup;

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'XGameShaders.MinigunFlash');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.MinigunPickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'XGameShaders.MinigunFlash');
}

defaultproperties
{
     MaxDesireability=0.730000
     InventoryType=Class'fpsWeaponPack.TeslaGun'
     PickupMessage="You got the Tesla MiniGun."
     PickupSound=Sound'PickupSounds.MinigunPickup'
     PickupForce="MinigunPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.MinigunPickup'
     DrawScale=0.600000
}
