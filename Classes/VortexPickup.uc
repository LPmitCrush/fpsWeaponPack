Class VortexPickup extends UTWeaponPickup;

#exec AUDIO IMPORT FILE="Snds\vortex_pickup.wav" NAME="vortex_pickup" GROUP="Vortex"

// Vortex shouldn't stay.
function SetWeaponStay()
{
	bWeaponStay = false;
}

static function StaticPrecache(LevelInfo L)
{
    L.AddPrecacheMaterial(Texture'fpsWepTex.vortex_launcher.vortex_launcher');
    L.AddPrecacheMaterial(Combiner'fpsWepTex.vortex_launcher.screens_combined');
    L.AddPrecacheMaterial(FinalBlend'fpsWepTex.vortex_launcher.blue_flames_final');
    L.AddPrecacheMaterial(Shader'fpsWepTex.vortex_launcher.Vortexshell_half');
    L.AddPrecacheMaterial(Shader'fpsWepTex.vortex_launcher.Vortexshell_shaderfinal');
    L.AddPrecacheMaterial(Texture'XEffects.Skins.LightningBoltT');
    L.AddPrecacheMaterial(FinalBlend'fpsWepTex.VortexFX.Lightning1');
    L.AddPrecacheMaterial(Shader'XGameShaders.Trans.TransRing');
    L.AddPrecacheMaterial(FinalBlend'XEffectMat.Shock.ShockDarkFB');
    L.AddPrecacheStaticMesh(StaticMesh'fpsWepMesh.Vortex.CE_Vortexlauncher');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'fpsWepTex.vortex_launcher.vortex_launcher');
    Level.AddPrecacheMaterial(Combiner'fpsWepTex.vortex_launcher.screens_combined');
    Level.AddPrecacheMaterial(FinalBlend'fpsWepTex.vortex_launcher.blue_flames_final');
    Level.AddPrecacheMaterial(Shader'fpsWepTex.vortex_launcher.Vortexshell_half');
    Level.AddPrecacheMaterial(Shader'fpsWepTex.vortex_launcher.Vortexshell_shaderfinal');
    Level.AddPrecacheMaterial(Texture'XEffects.Skins.LightningBoltT');
    Level.AddPrecacheMaterial(FinalBlend'fpsWepTex.VortexFX.Lightning1');
    Level.AddPrecacheMaterial(Shader'XGameShaders.Trans.TransRing');
    Level.AddPrecacheMaterial(FinalBlend'XEffectMat.Shock.ShockDarkFB');

}

defaultproperties
{
     StandUp=(X=0.250000,Y=0.250000,Z=0.000000)
     bWeaponStay=False
     MaxDesireability=0.750000
     InventoryType=Class'fpsWeaponPack.Vortex'
     RespawnTime=120.000000
     PickupMessage="You got the Gravity Vortex."
     PickupSound=Sound'fpsWeaponPack.Vortex.vortex_pickup'
     PickupForce="FlakCannonPickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'fpsWepMesh.Vortex.CE_Vortexlauncher'
     DrawScale=0.150000
}
