//=============================================================================
// VortexFire
// $Id: VortexFire.uc,v 1.5 2004/05/06 03:33:15 jb Exp $
//=============================================================================
class VortexFire extends ProjectileFire;

var protected VortexWatcher VortexWatcher;

simulated function DestroyEffects()
{
	Super.DestroyEffects();

    if (Vortex(Weapon)!= None && Vortex(Weapon).DummyProj != None )
        Vortex(Weapon).DummyProj.Destroy();
	VortexWatcher=None;
}

function InitEffects()
{
    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
    Super.InitEffects();

    if ( Vortex(Weapon).DummyProj == None )
        Vortex(Weapon).DummyProj = Spawn(class'VortexDummyProj');
    Weapon.AttachToBone(Vortex(Weapon).DummyProj, 'tip');
}

function DrawMuzzleFlash(Canvas Canvas)
{
    if (FlashEmitter != None)
        FlashEmitter.SetRotation(Weapon.Rotation);
    Super.DrawMuzzleFlash(Canvas);
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
		Vortex.Speed = pawnSpeed + Vortex.Speed;
        Vortex.Velocity = Vortex.Speed * Vector(Dir);
    }
	return Vortex;
}


//=============================================================================
// ModeDoFire
//=============================================================================
event ModeDoFire()
{
   if (!Vortex(Weapon).AtVortexLimit())     // do a quick check here
     super.ModeDoFire();
}



function StopFiring()
{
    super.StopFiring();
    Weapon.OutOfAmmo();
}

function PlayFiring()
{
	Super.PlayFiring();
	if ( FireCount > 0 )
		Vortex(Weapon).HideDummyProj();
}

function StartBerserk()
{
}

function StopBerserk()
{
}

defaultproperties
{
     ProjSpawnOffset=(X=20.000000,Y=9.000000,Z=-6.000000)
     bTossed=True
     FireEndAnim=
     FireSound=Sound'fpsWeaponPack.Vortex.vortex_fire'
     FireForce="AssaultRifleAltFire"
     FireRate=1.500000
     AmmoClass=Class'fpsWeaponPack.VortexAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=70.000000)
     ShakeRotRate=(X=1000.000000)
     ShakeRotTime=1.800000
     ShakeOffsetMag=(Z=-2.000000)
     ShakeOffsetRate=(Z=1000.000000)
     ShakeOffsetTime=1.800000
     ProjectileClass=Class'fpsWeaponPack.VortexProj'
     BotRefireRate=0.800000
     FlashEmitterClass=Class'XEffects.BioMuzFlash1st'
}
