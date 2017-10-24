class FlamerFire extends ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

defaultproperties
{
     ProjSpawnOffset=(X=35.000000,Y=5.000000,Z=-6.000000)
     FireEndAnim=
     FireAnimRate=0.950000
     FireSound=SoundGroup'WeaponSounds.FlakCannon.FlakCannonFire'
     FireForce="FlakCannonFire"
     FireRate=0.3
     AmmoClass=Class'XWeapons.FlakAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'fpsWeaponPack.FlamerProjectile'
     BotRefireRate=0.200000
     FlashEmitterClass=Class'XEffects.FlakMuzFlash1st'
     Spread=1700.000000
     SpreadStyle=SS_Random
}
