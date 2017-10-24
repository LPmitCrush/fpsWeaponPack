//=============================================================================
// FlakCannonPickup.
//=============================================================================
class DeathCannonPickup extends UTWeaponPickup;

#exec OBJ LOAD FILE=WeaponStaticMesh.usx
#exec OBJ LOAD FILE="fpsWepTex.utx"
#exec OBJ LOAD FILE="fpsWepMesh.usx"

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'fpsWepTex.Effects.ftplz2');
    L.AddPrecacheMaterial(FinalBlend'fpsWepTex.Effects.ftblend2');
    L.AddPrecacheMaterial(Texture'XEffects.ExplosionFlashTex');
    L.AddPrecacheMaterial(FinalBlend'PickupSkins.Shaders.FinalHealthGlass');
    L.AddPrecacheMaterial(Texture'WeaponSkins.FlakTex0');
    L.AddPrecacheMaterial(Texture'WeaponSkins.FlakTex1');
    L.AddPrecacheMaterial(Texture'XWeapons.NewFlakSkin');
    L.AddPrecacheMaterial(Texture'XGameShaders.flak_flash');
	L.AddPrecacheStaticMesh(StaticMesh'fpsWepMesh.Effects.FlakChunk');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.FlakCannonPickup');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'fpsWepTex.Effects.ftplz2');
    Level.AddPrecacheMaterial(FinalBlend'fpsWepTex.Effects.ftblend2');
    Level.AddPrecacheMaterial(Texture'XEffects.ExplosionFlashTex');
    Level.AddPrecacheMaterial(FinalBlend'PickupSkins.Shaders.FinalHealthGlass');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.FlakTex0');
    Level.AddPrecacheMaterial(Texture'WeaponSkins.FlakTex1');
    Level.AddPrecacheMaterial(Texture'XWeapons.NewFlakSkin');
    Level.AddPrecacheMaterial(Texture'XGameShaders.flak_flash');

	super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'fpsWepMesh.Effects.FlakChunk');
	Super.UpdatePrecacheStaticMeshes();
}
	

defaultproperties
{
     StandUp=(Z=0.250000)
     MaxDesireability=0.750000
     InventoryType=Class'fpsWeaponPack.DeathCannon'
     PickupMessage="Death Cannon."
     PickupSound=Sound'PickupSounds.FlakCannonPickup'
     PickupForce="FlakCannonPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.FlakCannonPickup'
     DrawScale=0.550000
}
