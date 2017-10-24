class NuclearShockRifleAttachment extends xWeaponAttachment;

var class<xEmitter>     MuzFlashClass;
var xEmitter            MuzFlash;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	if ( (Instigator != None) && (Instigator.PlayerReplicationInfo != None)&& (Instigator.PlayerReplicationInfo.Team != None) )
	{
		if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
			Skins[1] = Material'UT2004Weapons.RedShockFinal';
		else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 1 )
			Skins[1] = Material'UT2004Weapons.BlueShockFinal';
	}
}
simulated function Destroyed()
{
    if (MuzFlash != None)
        MuzFlash.Destroy();

    Super.Destroyed();
}

simulated event ThirdPersonEffects()
{
    local rotator r;

    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
	{
		if ( FiringMode == 0 )
			WeaponLight();
        else
        {
            if (MuzFlash == None)
            {
                MuzFlash = Spawn(MuzFlashClass);
                AttachToBone(MuzFlash, 'tip');
            }
            if (MuzFlash != None)
            {
                MuzFlash.mStartParticles++;
                r.Roll = Rand(65536);
                SetBoneRotation('Bone_Flash', r, 0, 1.f);
            }
        }
    }

    Super.ThirdPersonEffects();
}

defaultproperties
{
    MuzFlashClass=Class'XEffects.ShockProjMuzFlash3rd'
    LightType=LT_Steady
    LightEffect=LE_NonIncidence
    LightHue=200
    LightSaturation=70
    LightBrightness=255.00
    LightRadius=4.00
    LightPeriod=3
    Mesh=SkeletalMesh'NewWeapons2004.NewShockRifle_3rd'
    RelativeLocation=(X=-3.00,Y=-5.00,Z=-10.00),
    RelativeRotation=(Pitch=32768,Yaw=0,Roll=0),
    Skins(0)=Texture'UT2004Weapons.NewWeaps.ShockRifleTex0'
    Skins(1)=TexOscillator'UT2004Weapons.Shaders.TexOscillator1'
}
