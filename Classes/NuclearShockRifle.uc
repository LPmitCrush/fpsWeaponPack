//=============================================================================
// Nuclear Shock Rifle
//=============================================================================
class NuclearShockRifle extends ShockRifle
    config(fpsWeaponPack);

defaultproperties
{
    FireModeClass(0)=Class'XWeapons.ShockBeamFire'
    FireModeClass(1)=Class'fpsWeaponPack.NuclearShockRifleProjFire'
    SelectAnim=Pickup
    PutDownAnim=PutDown
    SelectSound=Sound'WeaponSounds.ShockRifle.SwitchToShockRifle'
    SelectForce="SwitchToShockRifle"
    Description="The Nuclear Shock Rifle.|Made by aeon"
    Priority=6
    CustomCrosshair=1
    CustomCrossHairColor=(R=255,G=0,B=255,A=255),
    CustomCrossHairScale=1.33
    CustomCrossHairTextureName="Crosshairs.Hud.Crosshair_Cross2"
    InventoryGroup=4
    PickupClass=Class'fpsWeaponPack.NuclearShockRiflePickup'
    AttachmentClass=Class'fpsWeaponPack.NuclearShockRifleAttachment'
    IconMaterial=Texture'HUDContent.Generic.HUD'
    IconCoords=(X1=250,Y1=110,X2=330,Y2=145)
    ItemName="Nuclear ShockRifle"
    LightType=LT_Steady
    LightEffect=LE_NonIncidence
    LightHue=200
    LightSaturation=70
    LightBrightness=255.00
    LightRadius=4.00
    LightPeriod=3
    Mesh=SkeletalMesh'fpsWepAnim.NukeRifle'
    DrawScale=0.70
    HighDetailOverlay=Combiner'UT2004Weapons.WeaponSpecMap2'
}
