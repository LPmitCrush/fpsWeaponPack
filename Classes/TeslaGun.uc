//=============================================================================
// tesla gun
//=============================================================================
class Teslagun extends Minigun;

simulated function SuperMaxOutAmmo()
{}

defaultproperties
{
     FireModeClass(0)=Class'fpsWeaponPack.TeslaFire'
     FireModeClass(1)=Class'fpsWeaponPack.TeslaAltFire'
     AIRating=1.000000
     bCanThrow=False
     PickupClass=Class'fpsWeaponPack.Teslapickup'
     AttachmentClass=Class'fpsWeaponPack.TeslagunAttachment'
     ItemName="Tesla Minigun"
}
