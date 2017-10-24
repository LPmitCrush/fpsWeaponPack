Class pgDischargeProj extends Projectile;

var int PortalDistance;

var pgProjEmitter ProjEffect;

simulated function PostBeginPlay()
{
	Velocity = vector(Rotation) * Speed;

	Super.PostBeginPlay();
}

simulated function PostNetBeginPlay()
{
	if (Level.Netmode != NM_DedicatedServer)
	{
		ProjEffect = Spawn(Class'pgProjEmitter', self);
		ProjEffect.SetColour(2);
	}

	Acceleration = Normal(Velocity) * 3000.0;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local pgProjImpactEmitter ImpactEffect;

	if (EffectIsRelevant(Location, False))
	{
		ImpactEffect = Spawn(Class'pgProjImpactEmitter',,,HitLocation + (HitNormal * (PortalDistance + 10.0)));
		ImpactEffect.SetColour(2);
	}

	// Replace with A_Spec's sound
	PlaySound(Sound'WeaponSounds.BioRifle.BioRifleGoo2');

	Destroy();
}

simulated function Destroyed()
{
	if (ProjEffect != none)
		ProjEffect.Destroy();

	Super.Destroyed();
}

defaultproperties
{
     PortalDistance=8
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
     LifeSpan=0.000000
     AmbientGlow=217
     FluidSurfaceShootStrengthMod=6.000000
     SoundVolume=255
     SoundRadius=50.000000
}
