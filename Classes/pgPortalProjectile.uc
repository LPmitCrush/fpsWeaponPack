Class pgPortalProjectile extends Projectile;//LinkProjectile;

var int FireMode;
var bool bForceMinimumGrowth;
var float DefaultPortalSize;
var float StartingPortalSize;

// Distance to put portal out from wall (affects the impact emitter too)
var float PortalDistance;

var pgProjEmitter ProjEffect;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		FireMode;
}

simulated function PostBeginPlay()
{
	Velocity = vector(Rotation) * Speed;

	Super.PostBeginPlay();
}

simulated function PostNetBeginPlay()
{
	if (Level.Netmode != NM_DedicatedServer)
	//if (Level.Netmode == NM_Standalone || Level.Netmode == NM_ListenServer)
	{
		ProjEffect = Spawn(Class'pgProjEmitter', self);
		ProjEffect.SetColour(FireMode);
	}

	// ***
	Acceleration = Normal(Velocity) * 3000.0;
	// ***
}

/*simulated function PostNetReceive()
{
	// This if statement even neccessary?
	if (Level.Netmode == NM_Client && FireMode != -1 && ProjEffect == none)
	{
		ProjEffect = Spawn(Class'pgProjEmitter', self);
		ProjEffect.SetColour(FireMode);

		// Only want this once
		bNetNotify = False;
	}
}*/

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local pgProjImpactEmitter ImpactEffect;

	if (EffectIsRelevant(Location, False))
	{
		ImpactEffect = Spawn(Class'pgProjImpactEmitter',,,HitLocation + (HitNormal * (PortalDistance + 10.0)));
		ImpactEffect.SetColour(FireMode);
	}

	// Replace with A_Spec's sound later
	PlaySound(Sound'WeaponSounds.BioRifle.BioRifleGoo2');


	Destroy();
}

simulated function Destroyed()
{
	if (ProjEffect != none)
		ProjEffect.Destroy();

	Super.Destroyed();
}

simulated function HitWall(vector HitNormal, Actor Wall)
{
	local pgPortalDecal pd;

	// Spawn the 'portal decal'
	//if (Role == ROLE_Authority)
	if (Level.Netmode != NM_Client)
	{
		// hack
		Class'pgPortalDecal'.default.FireMode = FireMode;
		Class'pgPortalDecal'.default.DefaultDrawScale = DefaultPortalSize;
		//Class'pgPortalDecal'.default.StartingDrawScale = StartingPortalSize;
		Class'pgPortalDecal'.default.StartingGrowthEnergy = StartingPortalSize;

		pd = Spawn(Class'pgPortalDecal', InstigatorController,, Location + (HitNormal * PortalDistance), Rotator(HitNormal));


		// further hacking to trick netcode
		Class'pgPortalDecal'.default.FireMode = -1;
		Class'pgPortalDecal'.default.DefaultDrawScale = -1;
		//Class'pgPortalDecal'.default.StartingDrawScale = -1;
		Class'pgPortalDecal'.default.StartingGrowthEnergy = -1;

		pd.bForceMinimumGrowth = bForceMinimumGrowth;
		pd.SetBase(Wall);
	}

	Super.HitWall(HitNormal, Wall);
}

defaultproperties
{
     FireMode=-1
     PortalDistance=8.000000
     Speed=4000.000000
     MaxSpeed=4000.000000
     DamageRadius=0.000000
     MaxEffectDistance=7000.000000
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=100
     LightSaturation=100
     LightBrightness=255.000000
     LightRadius=3.000000
     DrawType=DT_None
     CullDistance=3500.000000
     bDynamicLight=True
     AmbientSound=Sound'WeaponSounds.LinkGun.LinkGunProjectile'
     LifeSpan=6.000000
     AmbientGlow=217
     FluidSurfaceShootStrengthMod=6.000000
     SoundVolume=255
     SoundRadius=50.000000
     bNetNotify=True
}
