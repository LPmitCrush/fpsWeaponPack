class LilLadyProjFire extends ProjectileFire;

#exec AUDIO IMPORT FILE="Snds\bang.wav" NAME="bang" GROUP="fire1"

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local LilLadyProj Rocket;
	

        Rocket = Spawn(class'LilLadyProj',,, Start, Dir);
        if (Rocket == None)
            log("failed spawning rocket!"@Start@" "@Dir);
        return Rocket;
}

defaultproperties
{
     ProjSpawnOffset=(X=25.000000,Z=0.000000)
     bSplashDamage=True
     FireAnim="AltFire"
     FireSound=Sound'fpsWeaponPack.fire1.bang'
     FireForce="ShockRifleAltFire"
     FireRate=0.140000
     AmmoClass=Class'fpsWeaponPack.LilLadyAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=60.000000,Y=20.000000)
     ShakeRotRate=(X=1000.000000,Y=1000.000000)
     ShakeRotTime=2.000000
     ProjectileClass=Class'fpsWeaponPack.LilLadyProj'
     BotRefireRate=0.500000
     FlashEmitterClass=Class'fpsWeaponPack.LilLadyMuzFlash'
}
