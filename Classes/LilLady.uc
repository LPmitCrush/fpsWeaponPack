class LilLady extends ShockRifle;

#exec TEXTURE IMPORT FILE="Tex\LilLady.dds" NAME="GunTex" GROUP="Skins"

simulated function SuperMaxOutAmmo()
{}

function byte BestMode()
{
	return byte(Rand(2));
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
}

defaultproperties
{
     FireModeClass(0)=Class'fpsWeaponPack.LilLadyProjFire'
     FireModeClass(1)=Class'fpsWeaponPack.LilLadyAltFire'
     SelectSound=Sound'PickupSounds.AssaultRiflePickup'
     PickupClass=fpsWeaponPack.LilLadyPickup
     AttachmentClass=Class'fpsWeaponPack.LilLadyAttachment'
     ItemName="LilLady"
     Skins(0)=Texture'fpsWeaponPack.Skins.GunTex'
     Skins(1)=FinalBlend'UT2004Weapons.Shaders.RedShockFinal'
}
