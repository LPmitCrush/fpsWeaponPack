class OrphanMakerFireB extends ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
   
}

event ModeDoFire()
{
      Local OrphanMaker OrphanMaker;
      OrphanMaker = OrphanMaker(Weapon);
      Super.ModeDoFire();
      OrphanMaker.ConsumeAmmo(ThisModeNum, OrphanMaker.AmmoAmount(0));
}

defaultproperties
{
     ProjPerFire=50
     ProjSpawnOffset=(X=25.000000,Y=5.000000,Z=-6.000000)
     FireEndAnim=
     FireAnimRate=0.950000
     FireSound=SoundGroup'WeaponSounds.FlakCannon.FlakCannonFire'
     FireForce="FlakCannonFire"
     FireRate=6.894700
     AmmoClass=Class'fpsWeaponPack.OrphanMakerAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'fpsWeaponPack.OrphanMakerChunk'
     BotRefireRate=6.700000
     FlashEmitterClass=Class'XEffects.FlakMuzFlash1st'
     Spread=3.000000
     SpreadStyle=SS_Line
}
