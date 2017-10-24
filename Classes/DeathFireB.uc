class DeathFireB extends ProjectileFire;

var int SpreadSize;
var int NumDeathProj;
var vector ProjAimOffset;

function InitEffects()
{
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
   
}

////START SHIT DON'T WORK AT ALL////
/*
simulated function bool AllowFire()
{

	//if we can fire....
	if (bIsfiring && (wordd == 3))
	{
		return false;
	}
	else
	{
		return True;
	}
}

simulated function bool plzsAllowFire( DeathCannon DeathCannon )
{

	//if we can fire....
	if (DeathCannon.AmmoAmount(0) < 0)
        default.wordd = 4;
        AllowFire();
        return false;
}
*/
////END SHIT THAT DONT WORK AT ALL///

function DoFireEffect()
{
    local int p;
    local Vector StartProj, StartTrace, X,Y,Z;
    local Actor Other;
    local Rotator Aim;
    local Vector HitLocation, HitNormal,FireLocation;
    local DeathChunk FiredChunks[219];

    Instigator.MakeNoise(1.0);
    Weapon.GetViewAxes(X,Y,Z);

    StartTrace = Instigator.Location + Instigator.EyePosition();
    StartProj = StartTrace + Z*ProjSpawnOffset.Z;

    // check if projectile would spawn through a wall and adjust start location accordingly
    Other = Weapon.Trace(HitLocation, HitNormal, StartProj, StartTrace, false);
    if (Other != None)
    {
        StartProj = HitLocation;
    }

    Aim = AdjustAim(StartProj, AimError);

    for ( p=0; p<NumDeathProj; p++ )
    {
 		Firelocation = StartProj - 2*((Sin(p*2*PI/NumDeathProj)*8 - 7)*Y - (Cos(p*2*PI/NumDeathProj)*8 - 7)*Z) - X * 8 * FRand();
 		if(Instigator.Controller.IsA('PlayerController'))
 		    Aim = rotator((Instigator.Location + Instigator.EyePosition() + X*ProjAimOffset.X + Y*ProjAimOffset.Y + Z*ProjAimOffset.Z) - Firelocation);
                    //Aim = AdjustAim(StartProj, AimError);
        else
 		    Aim = rotator((Instigator.Location + X*ProjAimOffset.X + Y*ProjAimOffset.Y + Z*ProjAimOffset.Z) - Firelocation);
        FiredChunks[p] = DeathChunk(SpawnProjectile(FireLocation, Aim));
    }
}

event ModeDoFire()
{
      Local DeathCannon DeathCannon;
      DeathCannon = DeathCannon(Weapon);
      Super.ModeDoFire();
      DeathCannon.ConsumeAmmo(ThisModeNum, DeathCannon.AmmoAmount(0));
}

defaultproperties
{
     SpreadSize=219
     NumDeathProj=40
     ProjAimOffset=(X=300.000000,Y=13.400000,Z=-19.000000)
     ProjPerFire=40
     ProjSpawnOffset=(X=4000.000000,Y=5.000000,Z=-6.000000)
     bSplashDamage=True
     bSplashJump=True
     bRecommendSplashDamage=True
     FireEndAnim=
     FireAnimRate=0.950000
     TweenTime=0.000000
     FireSound=SoundGroup'WeaponSounds.FlakCannon.FlakCannonFire'
     FireForce="FlakCannonFire"
     FireRate=6.894700
     AmmoClass=Class'fpsWeaponPack.DeathCannonAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'fpsWeaponPack.DeathChunk'
     BotRefireRate=6.700000
     WarnTargetPct=0.900000
     FlashEmitterClass=Class'fpsWeaponPack.DeathSmoke1st'
     Spread=15000.000000
     SpreadStyle=SS_Ring
}
