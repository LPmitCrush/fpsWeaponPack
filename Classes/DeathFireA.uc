class DeathFireA extends ProjectileFire;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
   
}

event ModeDoFire()
{
      Local DeathCannon DeathCannon;
      //Spawn(class'fpsWeaponPack.nukemitterS',,,Instigator.Location,Rotator(Instigator.EyePosition()));
      DeathCannon = DeathCannon(Weapon);
      Super.ModeDoFire();
      DeathCannon.ConsumeAmmo(ThisModeNum, DeathCannon.AmmoAmount(0));
}

defaultproperties
{
     ProjPerFire=20
     ProjSpawnOffset=(X=25.000000,Y=5.000000,Z=-6.000000)
     FireEndAnim=
     FireAnimRate=0.950000
     FireSound=SoundGroup'WeaponSounds.FlakCannon.FlakCannonFire'
     FireForce="FlakCannonFire"
     FireRate=5.000000
     AmmoClass=Class'fpsWeaponPack.DeathCannonAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'fpsWeaponPack.DeathChunk'
     BotRefireRate=5.700000
     FlashEmitterClass=Class'fpsWeaponPack.DeathSmoke1st'
     Spread=700.000000
     SpreadStyle=SS_Line
}
