Class pgPortalGunFire extends ProjectileFire;


// For a fix which allows release-fire weapons to rapid-fire when shooting primary and then secondary. (not the other way round...caused by tick complications)
var bool bJustFired;

var float HoldTimeLimit; // When using HoldTime to calculate the portal size, this is the maximum size that can be applied (typically, should match the charge bar time)

var bool bDischargeFire;


function Projectile SpawnProjectile(vector Start, rotator Dir)
{
	local pgPortalProjectile Proj;
	local pgDischargeProj DProj;

	if (bDischargeFire)
	{
		ProjectileClass = Class'pgDischargeProj';
		DProj = pgDischargeProj(Super.SpawnProjectile(Start, Dir));
		ProjectileClass = default.ProjectileClass;

		bDischargeFire = False;

		return DProj;
	}

	Class'pgPortalProjectile'.default.FireMode = ThisModeNum;

	Proj = pgPortalProjectile(Super.SpawnProjectile(Start, Dir));

	// Replication hack
	Class'pgPortalProjectile'.default.FireMode = -1;

	if (Proj == none)
		return None;

	Proj.bForceMinimumGrowth = pgPortalGun(Weapon).bForceMinimumGrowth;
	Proj.DefaultPortalSize = pgPortalGun(Weapon).DefaultPortalSize;
	Proj.StartingPortalSize = FMax(pgPortalGun(Weapon).DefaultPortalSize, 1.0 + FMin(HoldTime, HoldTimeLimit) * (1.0 / HoldTimeLimit));

	return Proj;
}


// Important fix (obsolete since third fire mode was put in but keep it here for future reference)
function ModeTick(float dt)
{
	bJustFired = False;

	Super.ModeTick(dt);
}

function StopFiring()
{
	bJustFired = True;

	Super.StopFiring();
}

defaultproperties
{
     HoldTimeLimit=4.000000
     ProjSpawnOffset=(X=25.000000,Y=12.000000,Z=-8.000000)
     bFireOnRelease=True
     FireLoopAnim=
     FireEndAnim=
     FireAnimRate=0.750000
     FireSound=SoundGroup'WeaponSounds.PulseRifle.PulseRifleFire'
     FireRate=0.800000
     AmmoClass=Class'fpsWeaponPack.pgDudAmmo'
     ProjectileClass=Class'fpsWeaponPack.pgPortalProjectile'
}
