Class pgPortalGun extends Weapon;

var bool bForceMinimumGrowth;
var float DefaultPortalSize;

// Debug
//var vector NewProjSpawnOffset;

simulated function SuperMaxOutAmmo()
{}

simulated function float ChargeBar()
{
	return FMin(1, FMax(FireMode[0].HoldTime, FireMode[1].HoldTime) * 0.25);
}

simulated function bool HasAmmo()
{
	return True;
}


// Fix code for weapons with double release fire weapon modes
simulated function bool StartFire(int Mode)
{
	local int OtherMode;

	// debug
	//if (NewProjSpawnOffset != vect(0,0,0))
	//	ProjectileFire(FireMode[Mode]).ProjSpawnOffset = NewProjSpawnOffset;

	if (Mode == 0)
		OtherMode = 1;
	else
		OtherMode = 0;

	// Somehow this only works primary fire to secondary fire online
	if (FireMode[OtherMode].bIsFiring && FireMode[OtherMode].NextFireTime <= Level.TimeSeconds)
	{
		pgPortalGunFire(FireMode[OtherMode]).bDischargeFire = True;
		StopFire(OtherMode);

		return False;
	}

	if (Mode == 1 && pgPortalGunFire(FireMode[0]).bJustFired)
	{
		if (ReadyToFire(Mode))
			FireMode[Mode].bServerDelayStartFire = True;

		return False;
	}

	return Super.StartFire(Mode);
}

defaultproperties
{
     DefaultPortalSize=1.000000
     FireModeClass(0)=Class'fpsWeaponPack.pgPortalGunFire'
     FireModeClass(1)=Class'fpsWeaponPack.pgPortalGunFire'
     PutDownAnim="PutDown"
     IdleAnimRate=0.030000
     SelectSound=Sound'NewWeaponSounds.NewLinkSelect'
     AIRating=0.000000
     bShowChargingBar=True
     EffectOffset=(X=100.000000,Y=25.000000,Z=-3.000000)
     DisplayFOV=60.000000
     SmallViewOffset=(X=10.000000,Y=1.000000,Z=-6.000000)
     CenteredOffsetY=-5.000000
     CenteredRoll=1000
     CenteredYaw=-1000
     CustomCrossHairTextureName="fpsWeaponPack.PortalCross"
     InventoryGroup=5
     GroupOffset=1
     PickupClass=Class'fpsWeaponPack.pgPortalGunPickup'
     PlayerViewOffset=(X=7.000000,Y=-1.000000,Z=-5.000000)
     PlayerViewPivot=(Pitch=-32000,Yaw=16000,Roll=-17500)
     AttachmentClass=Class'fpsWeaponPack.pgPortalGunAttachment'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X1=169,Y1=78,X2=244,Y2=124)
     ItemName="Portal Gun"
     Mesh=SkeletalMesh'fpsWepAnim.pgWeaponMesh'
     Skins(0)=Texture'fpsWepTex.PortalGun.PortalGunSkin'
}
