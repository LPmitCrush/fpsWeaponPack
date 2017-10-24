Class VortexProj extends Projectile;

#exec AUDIO IMPORT FILE="Snds\vortex_start.wav" NAME="vortex_start" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_flash1.wav" NAME="vortex_flash1" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_flash2.wav" NAME="vortex_flash2" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_flash3.wav" NAME="vortex_flash3" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_flash4.wav" NAME="vortex_flash4" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_flash5.wav" NAME="vortex_flash5" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_flash6.wav" NAME="vortex_flash6" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_flash7.wav" NAME="vortex_flash7" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_run.wav" NAME="vortex_run" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_slurp.wav" NAME="vortex_slurp" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_slurp1.wav" NAME="vortex_slurp1" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_slurp2.wav" NAME="vortex_slurp2" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_slurp3.wav" NAME="vortex_slurp3" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_slurp4.wav" NAME="vortex_slurp4" GROUP="Vortex"

//=============================================================================
// properties
//=============================================================================

//var(Vortex) float VortexGravity, VortexRange;
var(Vortex) float VortexGravCompensation;              // scale gravity affecting the vortex projectile
var(Vortex) float GravBeltScale;                       // scaling values for vortex gravity
var(Vortex) float InitialDelay, BuildUpTime, EffectsSpawnTime, ActiveTime, CalmDownTime;
var(Vortex) float InitialRisingRate;                   // upward acceleration when starting to suck things in
var(Vortex) float MinSpeed;                            // minimum speed for secondary firing mode
var(Vortex) float MaxRisingSpeed;                      // maximum speed when starting to suck things in
var(Vortex) float SlowDownRate, WaterSlowDownRate;     // vortex constantly slows down at this rate
var(Vortex) float DampenFactor, DampenFactorParallel;  // dampening when hitting objects
//var(Vortex) float KickUpSpeed;                         // for actors with PHYS_None or PHYS_Rotating
//var(Vortex) float KillRadius;                          // objects withing this radius are killed/destroyed

// config vars
var() globalconfig int VortexRange;
var() globalconfig int VortexGravity;
var() globalconfig int KillRadius;
var() globalconfig int KickUpSpeed;
//var() globalconfig int Damage;
//var() globalconfig int DamageRadius;

// sounds
var(VortexSounds) Sound VortexStartSound;
var(VortexSounds) array<Sound> VortexFlash;
var(VortexSounds) Sound VortexAmbientSound;
var(VortexSounds) array<Sound> SlurpSound;
var(VortexSounds) array<Sound> ImpactSounds;

// display
var(Display) Material ActiveMaterial;
var(Display) Mesh ActiveMesh;

// internal variables
var protected float StartTimeIndex;                    // Level.TimeSeconds when this vortex was spawned
var protected float StrengthFadeTimeIndex;             // Level.TimeSecunds when this vortext starts/stops sucking
var protected float DamageTime;                        // time since last damaging
var protected Emitter VortexEmitter, VortexMainLightning, VortexLightning;
var protected array<VortexSphere> VortexSpheres;
var protected VortexWatcher VortexWatcher;             // for checking vortex limit

// Fearspot/Avoid Marker
var AvoidMarker Fear;                                  // use to warn the bots not to walk through this
Var Float EndTime;                                     // used to fix the ghost vortex issues


//=============================================================================
// replication
//=============================================================================

replication
{
	// variables initially replicated to clients
	reliable if ( Role == ROLE_Authority && bNetInitial )
		InitialDelay, EndTime;
}


//=============================================================================
// PostBeginPlay
//=============================================================================

simulated function PostBeginPlay()
{
	StartTimeIndex = Level.TimeSeconds;

	Velocity = Speed * vector(Rotation);
	RandSpin(100000);
	//log("PostBeginPlay at"@Level.TimeSeconds, Name);

	if ( Instigator != None )
		InstigatorController = Instigator.Controller;

	if ( Role == ROLE_Authority )
    {
        // Check to see if we need a VortexWatcher, if limit is 0, then it makes no sense
        // to spawn the VortexWatcher
		If (class'VortexWatcher'.default.VortexLimit != 0)
        {
            ForEach DynamicActors(class'VortexWatcher', VortexWatcher)
               break;
		    if ( VortexWatcher == None )
			     VortexWatcher = Spawn(class'VortexWatcher');
		    VortexWatcher.AddVortex(Instigator.PlayerReplicationInfo);
		}
        if ( Fear == None )  // run away...run away....
        {
            Fear = Spawn(class'AvoidMarker',self);
            Fear.SetPhysics(PHYS_Trailer);
            Fear.SetCollisionSize(1500,1500);
            Fear.StartleBots();
        }
	}
}


//=============================================================================
// FellOutOfWorld
//=============================================================================
// The vortex should stay active even when dropping out of the world

simulated event FellOutOfWorld(eKillZType KillType);


//=============================================================================
// Destroyed
//=============================================================================

simulated function Destroyed()
{
	if ( VortexWatcher != None )
		VortexWatcher.RemoveVortex();

    if (Fear != None )
        Fear.Destroy();
	//log("Destroyed at"@Level.TimeSeconds, Name);
}


//=============================================================================
// ProcessTouch
//=============================================================================
// Do nothing, especially not go away when touched.

function ProcessTouch(Actor Other, Vector HitLocation);


//=============================================================================
// Landed
//=============================================================================
// Same as HitWall().

simulated function Landed(vector HitNormal)
{
	HitWall(HitNormal, None);
}


//=============================================================================
// HitWall
//=============================================================================
// Bounce off walls with dampening.

simulated function HitWall(vector HitNormal, Actor Wall)
{
	Velocity -= (Velocity dot HitNormal) * HitNormal * (1 + DampenFactorParallel);
	Velocity *= DampenFactor;
}



//=============================================================================
// state Flying
//=============================================================================
// initial state after the vortex has been launched

auto simulated state Flying
{
	simulated function ProcessTouch(Actor Other, Vector HitLocation)
	{
		if ( Other != Instigator )
			HitWall(Normal(Other.Location - Location), Other);
	}

	simulated function HitWall(vector HitNormal, Actor Wall)
	{
		Global.HitWall(HitNormal, Wall);
		if ( VSize(Velocity) > 80 )
			PlaySound(ImpactSounds[Rand(ImpactSounds.Length)], SLOT_Misc,,,,1.5);
	}

	simulated function BeginState()
	{
		//log("Flying BeginState at"@Level.TimeSeconds, Name);
	}
Begin:
	Sleep(InitialDelay);
	GotoState('StartSucking');
}


//=============================================================================
// SpawnVisualEffects
//=============================================================================
// Spawns some spheres and an emitter.

simulated function SpawnVisualEffects()
{
	local float TimeRemaining;

	//AmbientSound = VortexAmbientSound;	// doesn't work? (works with bFullVolume) - Wormbo
    PlaySound(VortexAmbientSound, SLOT_Interact, 255.0,, 6000.0);
	if ( Level.NetMode == NM_DedicatedServer )
		return;

	TimeRemaining = (BuildUpTime - EffectsSpawnTime) + ActiveTime;

	VortexSpheres[0] = Spawn(class'VortexSphere', self);
	VortexSpheres[0].LifeSpan = TimeRemaining;
	VortexSpheres[1] = Spawn(class'VortexSphereB', self);
	VortexSpheres[1].LifeSpan = TimeRemaining;
	VortexLightning = Spawn(class'VortexMainLightning',Self);
    //VortexSpheres[2] = Spawn(class'VortexSphereC', self);
	//VortexSpheres[2].LifeSpan = TimeRemaining;
}


//=============================================================================
// ReleaseVortex
//=============================================================================
// Visual effect for opening the golden sphere and releasing the actual gravity
// vortex.

simulated function ReleaseVortex()
{
	local vector RandDir;
	local VortexShell ShellPart;

	RandDir = VRand();

	// spawn two half spheres
	ShellPart = Spawn(class'VortexShell',,, Location + 2 * RandDir, rotator(RandDir));
	if ( ShellPart != None)
		ShellPart.Velocity = 200 * RandDir;

	ShellPart = Spawn(class'VortexShell',,, Location - 2 * RandDir, rotator(-RandDir));
	if ( ShellPart != None)
		ShellPart.Velocity = -200 * RandDir;

	if ( Role == ROLE_Authority ) {
		bUpdateSimulatedPosition = False;
		//bTearOff = True;
	}

	// Change the mesh
	LinkMesh(ActiveMesh);
	SetDrawScale(1.2);
	Skins[0] = ActiveMaterial;
	RepSkin = ActiveMaterial;
	LoopAnim('flying', 1.0);
	bUnlit = True;
}



//=============================================================================
// state StartSucking
//=============================================================================
// Vortex builds up its power.

simulated state StartSucking
{
	simulated function BeginState()
	{
		StrengthFadeTimeIndex = Level.TimeSeconds;
		//log("StartSucking BeginState at"@Level.TimeSeconds, Name);
		SetPhysics(PHYS_Projectile);	// no longer affected by gravity
		Acceleration = vect(0,0,1) * InitialRisingRate;
		MaxSpeed = MaxRisingSpeed;

		//SpawnVisualEffects();
		ReleaseVortex();
		bProjTarget = False;
		SetCollision(False, False, False);
		SetTimer(EffectsSpawnTime, False);

		LightType = LT_Flicker;
		LightRadius = 1.0;
	}

	simulated function Timer()
	{
		SpawnVisualEffects();
	}

	simulated function Tick(float DeltaTime)
	{
		local float StrengthScale;

		// starts with lower radius
		StrengthScale = (Level.TimeSeconds - StrengthFadeTimeIndex) / BuildUpTime;
		SuckInActors(VortexGravity * StrengthScale, VortexRange * StrengthScale, DeltaTime);

		LightRadius = Default.LightRadius * (BuildUpTime - LatentFloat) / BuildUpTime;
	}

	simulated function EndState()
	{
		Acceleration = vect(0,0,0);
		//log("StartSucking EndState at"@Level.TimeSeconds, Name);
	}

Begin:
	VortexEmitter = Spawn(class'VortexEmitter', self);
	VortexEmitter.LifeSpan = BuildUpTime + ActiveTime + CalmDownTime;
	PlaySound(VortexStartSound, SLOT_Misc, 255.0,, 6000.0);	// plays fine - Wormbo
	Sleep(BuildUpTime);
	GotoState('Sucking');
}



//=============================================================================
// state Sucking
//=============================================================================
// Active state of the vortex.

simulated state Sucking
{
	simulated function Tick(float DeltaTime)
	{
		SuckInActors(VortexGravity, VortexRange, DeltaTime);

		if ( Physics != PHYS_Rotating ) SlowDown(DeltaTime);
		// fix to avoid ghost vortexs
		// Basically throw in a check on an absolute time to end the effect
		// As the current ghost vortex is an effect of loosing sync
        if (Level.Timeseconds >= Endtime)
		      GotoState('Collapsing');
	}

	simulated function BeginState()
	{
		VortexMainLightning = Spawn(class'VortexFX', self);
		Timer();
	}

	simulated function Timer()
	{
		local Sound S;

		S = VortexFlash[Rand(VortexFlash.Length)];
		PlaySound(S, SLOT_Misc, 255.0,, 6000.0);

		// play next sound when this one is finished and there's enough time left
		// (LatentFloat is the remaining time of the Sleep() function)
		if ( LatentFloat > GetSoundDuration(S) )
			SetTimer(GetSoundDuration(S) + FRand(), False);
	}

	simulated function EndState()
	{
		SetTimer(0.0, False);
	}

Begin:
    Endtime = Level.Timeseconds + ActiveTime;
	Sleep(ActiveTime);
	GotoState('Collapsing');
}



//=============================================================================
// state Collapsing
//=============================================================================
// Vortex gets weaker and collapses.

simulated state Collapsing
{
	simulated function BeginState()
	{
		if ( VortexEmitter != None )
			VortexEmitter.Kill();	// shut down emitter
		if ( VortexLightning != None )
			VortexLightning.Kill();	// should be killed already
		if ( VortexMainLightning != None )
			VortexMainLightning.Kill();
		StrengthFadeTimeIndex = Level.TimeSeconds;
		//log("Collapsing BeginState at"@Level.TimeSeconds, Name);
	}

	simulated function Tick(float DeltaTime)
	{
		local float StrengthScale;

		StrengthScale = 1 - (Level.TimeSeconds - StrengthFadeTimeIndex) / CalmDownTime;
		SuckInActors(VortexGravity * StrengthScale, VortexRange * StrengthScale, DeltaTime);
		if ( Physics != PHYS_Rotating ) SlowDown(DeltaTime);

		LightRadius = Default.LightRadius * LatentFloat / CalmDownTime;
	}

Begin:
	Sleep(CalmDownTime);
	Destroy();
}


//=============================================================================
// SuckInActors
//=============================================================================
// Used during StartSucking, Sucking and Dying states to suck in actors.

simulated function SuckInActors(float Gravity, float Range, float DeltaTime)
{
	local Actor thisActor;
	local Pawn thisPawn;
	local vector dir, ActorLocation;
	local float dist, strength, ActorSize;

	DamageTime += DeltaTime;

	if ( Instigator == None && InstigatorController != None )
		Instigator = InstigatorController.Pawn;

	ForEach CollidingActors(class'Actor', thisActor, Range, Location)
    {
		// only affect visible actors that can actually be sucked in
		if ( thisActor.IsA('VortexProj') || !IsMovable(thisActor) || !IsVisible(thisActor)
				|| !FastTrace(thisActor.Location, Location) )
			continue;

		thisPawn = Pawn(thisActor);
		// find this actor's location
		if ( thisActor.Physics == PHYS_Karma )
        {
			// use center of mass as karma actor location
			thisActor.KGetCOMPosition(ActorLocation);
			ActorSize = thisActor.GetRenderBoundingSphere().W * thisActor.DrawScale;
		}
		else {
			ActorLocation = thisActor.Location;
			ActorSize = 0;
		}

		dir = Normal(Location - ActorLocation);	// pointing towards center of vortex
		dist = VSize(Location - ActorLocation);
		strength = Gravity * DeltaTime * (2.1 - 2 * Square(dist / Range));

		if ( thisActor.Physics == PHYS_Karma || thisActor.Physics == PHYS_KarmaRagdoll )
        {
           // experimental karma stuff and drop strength bassed on wheigh of vehicles
		    if (thisPawn.IsA('SVehicle'))
                  	strength = strength/SVehicle(thisActor).VehicleMass;

            if ( !thisActor.KIsAwake() )
				thisActor.KWake();
			thisActor.KAddImpulse(dir * strength * thisActor.Mass * thisActor.KGetMass(), ActorLocation, 'bip01 Spine');
		}
		else if ( thisPawn != None )
        {
//			if ( HasGravbelt(thisPawn) )
//				strength *= GravBeltScale;	// scale force applied to players with activated gravbelt
			if ( thisPawn.Physics == PHYS_Walking && dir.Z < 0 )
				dir.Z = KickUpSpeed / strength;	// make sure player doesn't get crushed when getting stuck
			thisPawn.AddVelocity(dir * strength);	// automatically sets physics, etc.
			thisPawn.DelayedDamageInstigatorController = InstigatorController;
		}
		else {
			if ( thisActor.Physics == PHYS_None || thisActor.Physics == PHYS_Rotating ) {
				if ( thisActor.IsA('GameObject') && thisActor.IsInState('Home') )
					thisActor.GotoState('Dropped');
				thisActor.SetPhysics(PHYS_Falling);
				thisActor.Velocity = vect(0,0,1) * KickUpSpeed;
			}

			// this changes the rotation based on the change of the object's direction of movement
			if ( thisActor.Physics == PHYS_Projectile  || thisActor.IsA('RipperBlade') )
				thisActor.SetRotation(thisActor.Rotation - rotator(thisActor.Velocity));
			thisActor.Velocity += dir * strength;
			if ( thisActor.Physics == PHYS_Projectile )
				thisActor.SetRotation(thisActor.Rotation + rotator(thisActor.Velocity));
		}

        // Check for a proxy if it has a proxy set a flag
//        if ( thisActor.IsA('ProxyMine')  &&  !ProxyMine(thisActor).bInVortex )
//        {
//				ProxyMine(thisActor).bInVortex=true;
//				ProxyMine(thisActor).PlayVortex();
//        }
		// damage/kill objects
		if ( dist < KillRadius && IsInState('Sucking') && !thisActor.IsA('VortexShell') )
			KillObject(thisActor, dist);
		else if ( dist < DamageRadius && DamageTime > 0.2 )
			DamageObject(thisActor, dist);
	}

	if ( DamageTime > 0.2 )
		DamageTime -= 0.2;
}


//=============================================================================
// SlowDown
//=============================================================================
// Permanently slows down the vortex until it stops.

simulated function SlowDown(float DeltaTime)
{
	if ( VSize(Velocity) > MaxSpeed )
		DeltaTime *= 2;
	if ( !PhysicsVolume.bWaterVolume )
		speed = FMax(VSize(Velocity) - SlowDownRate * DeltaTime, 0);
	else
		speed = FMax(VSize(Velocity) - WaterSlowDownRate * DeltaTime, 0);
	if ( speed > 0 )
		Velocity = Normal(Velocity) * speed;
	else {
		Velocity = vect(0,0,0);
		Speed = 0;
		SetPhysics(PHYS_Rotating);
		SetCollision(False, False, False);
	}
}


//=============================================================================
// KillObject
//=============================================================================
// Kills or destroys the specified actor.

simulated function KillObject(Actor Other, float DistToCenter)
{
//	if ( Pawn(Other) != None && Other.Role == ROLE_Authority && Pawn(Other).Health > 0
//			&& !Pawn(Other).InGodMode() && !HasRespawnProtection(Pawn(Other)) )
    if (Pawn(Other) != None && Pawn(Other).PlayerReplicationInfo != None &&
Instigator.PlayerReplicationInfo.Team == Pawn(Other).PlayerReplicationInfo.Team)
    Return;
//	{
		Other.TakeDamage(1000, Instigator, Other.Location, vect(0,0,0), MyDamageType);
		if ( Pawn(Other).Health > 0 )
			Pawn(Other).Died(InstigatorController, MyDamageType, Other.Location);
		PlaySound(SlurpSound[Rand(SlurpSound.Length)], SLOT_Misc, 255.0,, 6000.0);
//	}
//	else
    if ( Pickup(Other) != None )
    {
		Other.Destroy();	// was dropped anyways, so it can be destroyed
	}
	else {
		Other.Touch(Self);
		DamageObject(Other, DistToCenter);
	}
}


//=============================================================================
// DamageObject
//=============================================================================
// Damages the specified actor based on its distance to the center of the
// vortex.

simulated function DamageObject(Actor Other, float DistToCenter)
{
	if ( Other == None || Other.IsA('Pawn') && Other.Role < ROLE_Authority )
		return;

	if ( !Other.IsA('Pawn')
			|| Pawn(Other).Health > 0 && !Pawn(Other).InGodMode() && !HasRespawnProtection(Pawn(Other)) )
	{
		Other.TakeDamage(Damage * (1 - DistToCenter / DamageRadius), Instigator,
				Other.Location, vect(0,0,0), MyDamageType);
	}
}


//=============================================================================
// IsVisible
//=============================================================================
// Returns whether an actor is visible to the vortex. Brushes, terrain,
// fluid surfaces, etc. are not concidered visible vor the vortex.

simulated function bool IsVisible(Actor Other)
{
	return !Other.bHidden && (Other.DrawType == DT_Mesh || Other.DrawType == DT_StaticMesh
			|| Other.DrawType == DT_Sprite || Other.DrawType == DT_SpriteAnimOnce
			|| Other.DrawType == DT_RopeSprite || Other.DrawType == DT_VerticalSprite);
}


//=============================================================================
// IsMovable
//=============================================================================
// Returns whether the vortex may apply momentum to this actor.

simulated function bool IsMovable(Actor Other)
{
	if ( Other.bStatic || Other.bNoDelete )
		return false;

	// game objects
	if ( Other.IsA('GameObject') && (Other.Physics == PHYS_None || Other.Physics == PHYS_Rotating) )
		return Other.IsInState('Dropped') || Other.IsInState('Home');

	// players (I'm not sure about flying players)
	// Jb: un-commeted it to see how it reacts....
	if ( Other.IsA('UnrealPawn') && (Other.Physics == PHYS_Walking
			|| Other.Physics == PHYS_Falling || Other.Physics == PHYS_Swimming
			|| Other.Physics == PHYS_Flying || Other.Physics == PHYS_Spider
			|| Other.Physics == PHYS_Ladder || Other.Physics == PHYS_KarmaRagDoll) )
		return true;

	if ( Other.IsA('Pickup') && Pickup(Other).bDropped )
		return true;

	// other stuff
	return Other.Physics == PHYS_Projectile || Other.Physics == PHYS_Falling || Other.Physics == PHYS_Karma;
}

//=============================================================================
// HasRespawnProtection
//=============================================================================
// Returns whether this pawn is under the effect of respawn protection.

simulated function bool HasRespawnProtection(Pawn Other)
{
	// only works in DeathMatch games
	if ( DeathMatch(Level.Game) == None )
		return false;

	// check for Epic's respawn protection
	if ( Level.TimeSeconds - Other.SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime )
		return true;

	return false;

}


//=============================================================================
// GetVortexDuration
//=============================================================================
// Returns whether this pawn is under the effect of respawn protection.

simulated static function float GetVortexDuration()
{
	return default.InitialDelay + default.BuildUpTime + default.ActiveTime + default.CalmDownTime;
}

//=============================================================================
// default properties
//=============================================================================

defaultproperties
{
     GravBeltScale=0.300000
     InitialDelay=2.000000
     BuildUpTime=2.000000
     EffectsSpawnTime=1.000000
     ActiveTime=9.700000
     CalmDownTime=0.800000
     InitialRisingRate=50.000000
     MinSpeed=300.000000
     MaxRisingSpeed=200.000000
     SlowDownRate=100.000000
     WaterSlowDownRate=150.000000
     DampenFactor=0.500000
     DampenFactorParallel=0.750000
     VortexRange=2500
     VortexGravity=2000
     KillRadius=150
     KickUpSpeed=80
     Damage=10
     DamageRadius=300
     VortexStartSound=Sound'fpsWeaponPack.Vortex.vortex_start'
     VortexFlash(0)=Sound'fpsWeaponPack.Vortex.vortex_flash1'
     VortexFlash(1)=Sound'fpsWeaponPack.Vortex.vortex_flash2'
     VortexFlash(2)=Sound'fpsWeaponPack.Vortex.vortex_flash3'
     VortexFlash(3)=Sound'fpsWeaponPack.Vortex.vortex_flash4'
     VortexFlash(4)=Sound'fpsWeaponPack.Vortex.vortex_flash5'
     VortexFlash(5)=Sound'fpsWeaponPack.Vortex.vortex_flash6'
     VortexFlash(6)=Sound'fpsWeaponPack.Vortex.vortex_flash7'
     VortexAmbientSound=Sound'fpsWeaponPack.Vortex.vortex_run'
     SlurpSound(0)=Sound'fpsWeaponPack.Vortex.vortex_slurp'
     SlurpSound(1)=Sound'fpsWeaponPack.Vortex.vortex_slurp1'
     SlurpSound(2)=Sound'fpsWeaponPack.Vortex.vortex_slurp2'
     SlurpSound(3)=Sound'fpsWeaponPack.Vortex.vortex_slurp3'
     SlurpSound(4)=Sound'fpsWeaponPack.Vortex.vortex_slurp4'
     ImpactSounds(0)=Sound'fpsWeaponPack.Vortex.vortexshellbounce1'
     ImpactSounds(1)=Sound'fpsWeaponPack.Vortex.vortexshellbounce2'
     ImpactSounds(2)=Sound'fpsWeaponPack.Vortex.vortexshellbounce3'
     ActiveMaterial=TexEnvMap'AWGlobal.Cubes.BriteEnv1'
     ActiveMesh=VertMesh'XWeapons_rc.GoopMesh'
     Speed=600.000000
     MaxSpeed=1200.000000
     MyDamageType=Class'fpsWeaponPack.DamTypeVortex'
     LightEffect=LE_QuadraticNonIncidence
     LightHue=140
     LightSaturation=20
     LightBrightness=150.000000
     LightRadius=75.000000
     bDynamicLight=True
     bNetTemporary=False
     bUpdateSimulatedPosition=True
     Physics=PHYS_Falling
     LifeSpan=0.000000
     Mesh=SkeletalMesh'fpsWepAnim.Vortex.Chaos_VXsphere'
     DrawScale=1.200000
     AmbientGlow=80
     SoundVolume=255
     SoundRadius=6000.000000
     TransientSoundVolume=255.000000
     TransientSoundRadius=6000.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bProjTarget=True
     bBounce=True
}
