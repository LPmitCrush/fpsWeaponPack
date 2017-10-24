Class VortexShell extends Projectile;

#exec AUDIO IMPORT FILE="Snds\vortexshellbounce1.wav" NAME="vortexshellbounce1" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortexshellbounce2.wav" NAME="vortexshellbounce2" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortexshellbounce3.wav" NAME="vortexshellbounce3" GROUP="Vortex"

// Sounds
var(VortexSounds) array<Sound> ImpactSounds;


simulated function PostBeginPlay()
{
	RandSpin(100000);
}

simulated function HitWall(vector HitNormal, Actor Wall)
{
	Velocity -= (Velocity dot HitNormal) * HitNormal * RandRange(1.7, 1.9);
	Velocity *= RandRange(0.5, 0.7);
	RandSpin(100000);
	if ( VSize(Velocity) > 80 )
		PlaySound(ImpactSounds[Rand(ImpactSounds.Length)], SLOT_Misc);
	else if ( VSize(Velocity) < 10 )
		SetPhysics(PHYS_None);
}

simulated singular function Touch(Actor Other)
{
	local actor HitActor;
	local vector HitLocation, HitNormal, VelDir;
	local bool bBeyondOther;
	local float BackDist, DirZ;

	if ( Other == None ) // Other just got destroyed in its touch?
		return;
	if ( Other.bProjTarget || (Other.bBlockActors && Other.bBlockPlayers) )
	{
		if ( Velocity == vect(0,0,0) )
			return;

		//get exact hitlocation - trace back along velocity vector
		bBeyondOther = Velocity Dot (Location - Other.Location) > 0;
		VelDir = Normal(Velocity);
		DirZ = Sqrt(Abs(VelDir.Z));
		BackDist = Other.CollisionRadius * (1 - DirZ) + Other.CollisionHeight * DirZ;
		if ( bBeyondOther )
			BackDist += VSize(Location - Other.Location);
		else
			BackDist -= VSize(Location - Other.Location);

	 	HitActor = Trace(HitLocation, HitNormal, Location, Location - 1.1 * BackDist * VelDir, true);
		HitWall(HitNormal, HitActor);
	}
}

defaultproperties
{
     ImpactSounds(0)=Sound'fpsWeaponPack.Vortex.vortexshellbounce1'
     ImpactSounds(1)=Sound'fpsWeaponPack.Vortex.vortexshellbounce2'
     ImpactSounds(2)=Sound'fpsWeaponPack.Vortex.vortexshellbounce3'
     Physics=PHYS_Falling
     RemoteRole=ROLE_None
     LifeSpan=30.000000
     Mesh=SkeletalMesh'fpsWepAnim.Vortex.Chaos_VXspherehf'
     DrawScale=1.200000
     AmbientGlow=80
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bBounce=True
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
