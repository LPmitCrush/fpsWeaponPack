class FlamerAltFire extends ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

defaultproperties
{     
     ProjSpawnOffset=(X=25.000000,Y=9.000000,Z=-12.000000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     FireAnim="AltFire"
     FireEndAnim=
     FireAnimRate=0.900000
     FireSound=SoundGroup'WeaponSounds.FlakCannon.FlakCannonAltFire'
     FireForce="FlakCannonAltFire"
     FireRate=3.000000
     AmmoClass=Class'XWeapons.FlakAmmo'
     AmmoPerFire=4
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'fpsWeaponPack.FlamerAltProjectile'
     BotRefireRate=2.000000
     WarnTargetPct=0.900000
}
