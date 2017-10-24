//=============================================================================
// ShockRiflePickup
//=============================================================================
class NuclearShockRiflePickup extends ShockRiflePickup;

defaultproperties
{
    InventoryType=Class'fpsWeaponPack.NuclearShockRifle'
    PickupMessage="You got the Nuclear ShockRifle."
    PickupSound=Sound'PickupSounds.ShockRiflePickup'
    PickupForce="ShockRiflePickup"
    DrawType=DT_StaticMesh
    StaticMesh=StaticMesh'NewWeaponPickups.ShockPickupSM'
    DrawScale=0.55
    Skins(0)=Texture'UT2004Weapons.NewWeaps.ShockRifleTex0'
    Skins(1)=TexOscillator'UT2004Weapons.Shaders.TexOscillator1'
}
