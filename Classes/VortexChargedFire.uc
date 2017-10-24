//=============================================================================
// VortexChargedFire
// $Id: VortexChargedFire.uc,v 1.4 2004/05/06 03:33:14 jb Exp $
//=============================================================================
class VortexChargedFire extends ProjectileFire;

#exec AUDIO IMPORT FILE="Snds\vortex_fire.wav" NAME="vortex_fire" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_altfire.wav" NAME="vortex_altfire" GROUP="Vortex"

var() float MaxChargeTime;
var() Sound HoldSound;

var protected VortexWatcher VortexWatcher;

//=============================================================================
// ModeDoFire
//=============================================================================
event ModeDoFire()
{
   if (!Vortex(Weapon).AtVortexLimit())     // do a quick check here
     super.ModeDoFire();
}


function DrawMuzzleFlash(Canvas Canvas)
{
	if ( FlashEmitter != None )
		FlashEmitter.SetRotation(Weapon.Rotation);
	Super.DrawMuzzleFlash(Canvas);
}

function ModeHoldFire()
{
	if (Weapon.HasAmmo() )
	{
		Super.ModeHoldFire();
		Weapon.PlaySound(HoldSound,SLOT_Interact,TransientSoundVolume,,,,false);
	}
}

function float MaxRange()
{
	return 1500;
}



function StopFiring()
{
    super.StopFiring();
    Weapon.OutOfAmmo();
}


simulated function PlayFiring()
{
	Super.PlayFiring();
	if ( FireCount > 0 )
		Vortex(Weapon).HideDummyProj();
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local VortexProj Vortex;
    local vector X, Y, Z;
    local float pawnSpeed;

	// Added in check for INV to spawn a more team friendly version
    if (Level.Game.IsA('Invasion'))
       Vortex = Spawn(class'VortexINVProj',Instigator,, Start, Dir);
    else
	   Vortex = Spawn(class'VortexProj',Instigator,, Start, Dir);

    if (Vortex != None)
    {
        Weapon.GetViewAxes(X,Y,Z);
        pawnSpeed = X dot Instigator.Velocity;

		if ( Bot(Instigator.Controller) != None )
			Vortex.Speed = Vortex.MaxSpeed;
		else
			Vortex.Speed = Lerp(FMin(HoldTime / MaxChargeTime, 1.0), Vortex.MinSpeed, Vortex.MaxSpeed);
		Vortex.Speed = pawnSpeed + Vortex.Speed;
        Vortex.Velocity = Vortex.Speed * Vector(Dir);
    }
	return Vortex;
}

function StartBerserk()
{
	//ChargeRate = default.ChargeRate*0.75;
}

function StopBerserk()
{
	//ChargeRate = default.ChargeRate;
}

defaultproperties
{
     MaxChargeTime=3.000000
     HoldSound=Sound'fpsWeaponPack.Vortex.vortex_altfire'
     ProjSpawnOffset=(X=20.000000,Y=9.000000,Z=-6.000000)
     bTossed=True
     bFireOnRelease=True
     FireEndAnim=
     FireSound=Sound'fpsWeaponPack.Vortex.vortex_fire'
     FireForce="AssaultRifleAltFire"
     FireRate=1.500000
     AmmoClass=Class'fpsWeaponPack.VortexAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=100.000000)
     ShakeRotRate=(X=1000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-4.000000,Z=-4.000000)
     ShakeOffsetRate=(X=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'fpsWeaponPack.VortexProj'
     BotRefireRate=0.500000
     WarnTargetPct=0.800000
}
