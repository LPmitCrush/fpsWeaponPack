class BigBangBeamFire extends InstantFire;

var() class<ShockBeamEffect> BeamEffectClass;

#exec OBJ LOAD FILE=..\Sounds\WeaponSounds.uax


function DoFireEffect()
{
    local Vector StartTrace,X,Y,Z;
    local Rotator R, Aim;

    Instigator.MakeNoise(1.0);

    StartTrace = Instigator.Location + Instigator.EyePosition();
    if ( PlayerController(Instigator.Controller) != None )
    {
		// for combos
	   Weapon.GetViewAxes(X,Y,Z);
		StartTrace = StartTrace + X*class'BigBangProjFire'.Default.ProjSpawnOffset.X;
		if ( !Weapon.WeaponCentered() )
			StartTrace = StartTrace + Weapon.Hand * Y*class'BigBangProjFire'.Default.ProjSpawnOffset.Y + Z*class'BigBangProjFire'.Default.ProjSpawnOffset.Z;
	}

    Aim = AdjustAim(StartTrace, AimError);
	R = rotator(vector(Aim) + VRand()*FRand()*Spread);
    DoTrace(StartTrace, R);
}

function InitEffects()
{
	if ( Level.DetailMode == DM_Low )
		FlashEmitterClass = None;
    Super.InitEffects();
    if ( FlashEmitter != None )
		Weapon.AttachToBone(FlashEmitter, 'tip');
}

// for bot combos
function Rotator AdjustAim(Vector Start, float InAimError)
{
	if ( (BigBangRifle(Weapon) != None) && (BigBangRifle(Weapon).ComboTarget != None) )
		return Rotator(BigBangRifle(Weapon).ComboTarget.Location - Start);

	return Super.AdjustAim(Start, InAimError);
}

function SpawnBeamEffect(Vector Start, Rotator Dir, Vector HitLocation, Vector HitNormal, int ReflectNum)
{
    local ShockBeamEffect Beam;

    if (Weapon != None)
    {
        Beam = Weapon.Spawn(BeamEffectClass,,, Start, Dir);
        if (ReflectNum != 0) Beam.Instigator = None; // prevents client side repositioning of beam start
            Beam.AimAt(HitLocation, HitNormal);
    }
}

defaultproperties
{
     BeamEffectClass=Class'fpsWeaponPack.BigBangBeam'
     DamageType=Class'fpsWeaponPack.DamTypeBigBangBeam'
     DamageMin=4500
     DamageMax=4500
     TraceRange=17000.000000
     Momentum=60000.000000
     bReflective=True
     FireSound=SoundGroup'WeaponSounds.ShockRifle.ShockRifleFire'
     FireForce="ShockRifleFire"
     FireRate=4.700000
     AmmoClass=Class'fpsWeaponPack.BigBangAmmo'
     AmmoPerFire=1
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.000000)
     ShakeOffsetRate=(X=-600.000000)
     ShakeOffsetTime=3.200000
     BotRefireRate=0.700000
     FlashEmitterClass=Class'XEffects.ShockBeamMuzFlash'
     aimerror=700.000000
}
