//=============================================================================
// BigBangProjectile.
//=============================================================================
class BigBangProjectile extends Projectile;

var() Sound ComboSound;
var() float ComboDamage;
var() float ComboRadius;
var() float ComboMomentumTransfer;
var ShockBall ShockBallEffect;
var() int ComboAmmoCost;
var class<DamageType> ComboDamageType;
var float DamageRadiusPoo;
var class<DamageType> MyDamageTypePoo;
var float DamagePoo;

var Pawn ComboTarget;		// for AI use

var Vector tempStartLoc;

simulated event PreBeginPlay()
{
    Super.PreBeginPlay();

    if( Pawn(Owner) != None )
        Instigator = Pawn( Owner );
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
	{
        ShockBallEffect = Spawn(class'ShockBall', self);
        ShockBallEffect.SetBase(self);
	}

	Velocity = Speed * Vector(Rotation); // starts off slower so combo can be done closer

    SetTimer(0.4, false);
    tempStartLoc = Location;
}

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
	Super.PostNetBeginPlay();
	
	if ( Level.NetMode == NM_DedicatedServer )
		return;
		
	PC = Level.GetLocalPlayerController();
	if ( (Instigator != None) && (PC == Instigator.Controller) )
		return;
	if ( Level.bDropDetail || (Level.DetailMode == DM_Low) )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else if ( (PC == None) || (PC.ViewTarget == None) || (VSize(PC.ViewTarget.Location - Location) > 3000) )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
}

function Timer()
{
    SetCollisionSize(20, 20);
}

simulated function Destroyed()
{
    if (ShockBallEffect != None)
    {
		if ( bNoFX )
			ShockBallEffect.Destroy();
		else
			ShockBallEffect.Kill();
	}
	
	Super.Destroyed();
}

simulated function DestroyTrails()
{
    if (ShockBallEffect != None)
        ShockBallEffect.Destroy();
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X, RefNormal, RefDir;

	if (Other == Instigator) return;
    if (Other == Owner) return;

    if (Other.IsA('xPawn') && xPawn(Other).CheckReflect(HitLocation, RefNormal, Damage*0.25))
    {
        if (Role == ROLE_Authority)
        {
            X = Normal(Velocity);
            RefDir = X - 2.0*RefNormal*(X dot RefNormal);
            RefDir = RefNormal;
            Spawn(Class, Other,, HitLocation+RefDir*20, Rotator(RefDir));
        }
        DestroyTrails();
        Destroy();
    }
    else if ( !Other.IsA('Projectile') || Other.bProjTarget )
    {
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		if ( BigBangProjectile(Other) != None )
			BigBangProjectile(Other).Explode(HitLocation,Normal(Other.Location - HitLocation));
    }
}

simulated function Explode(vector HitLocation,vector HitNormal)
{
    if ( Role == ROLE_Authority )
    {
        HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
    }

   	PlaySound(ImpactSound, SLOT_Misc);
	if ( EffectIsRelevant(Location,false) )
	{
	    Spawn(class'ShockExplosionCore',,, Location);
		if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) )
			Spawn(class'ShockExplosion',,, Location);
	}
    SetCollisionSize(0.0, 0.0);
    Destroy();
}

event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if (DamageType == ComboDamageType)
    {
        Instigator = EventInstigator;
        SuperExplosion();
        if( EventInstigator.Weapon != None )
        {
			EventInstigator.Weapon.ConsumeAmmo(0, ComboAmmoCost, true);
            Instigator = EventInstigator;
        }
    }
}

function SuperExplosion()
{
	local actor HitActor;
	local vector HitLocation, HitNormal;

	HurtRadius(ComboDamage, ComboRadius, class'DamTypeBigBangCombo', ComboMomentumTransfer, Location );

	Spawn(class'ShockComboFlame');
	if ( (Level.NetMode != NM_DedicatedServer) && EffectIsRelevant(Location,false) )
	{
		HitActor = Trace(HitLocation, HitNormal,Location - Vect(0,0,120), Location,false);
		if ( HitActor != None )
			Spawn(class'ComboDecal',self,,HitLocation, rotator(vect(0,0,-1)));
	}
	PlaySound(ComboSound, SLOT_None,1.0,,800);
    DestroyTrails();
    	MakeNoise(1.0);
	SetPhysics(PHYS_None);
	bHidden = true;
    GotoState('Dying');
}

function Monitor(Pawn P)
{
	ComboTarget = P;

	if ( ComboTarget != None )
		GotoState('WaitForCombo');
}

State WaitForCombo
{
	function Tick(float DeltaTime)
	{
		if ( (ComboTarget == None) || ComboTarget.bDeleteMe
			|| (Instigator == None) || (BigBangRifle(Instigator.Weapon) == None) )
		{
			GotoState('');
			return;
		}

		if ( (VSize(ComboTarget.Location - Location) <= 0.5 * ComboRadius + ComboTarget.CollisionRadius)
			|| ((Velocity Dot (ComboTarget.Location - Location)) <= 0) )
		{
			BigBangRifle(Instigator.Weapon).DoCombo();
			GotoState('');
			return;
		}
	}
}

state Dying
{
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType) {}
	function Timer() {}

    function BeginState()
    {
		bHidden = true;
		SetPhysics(PHYS_None);
		SetCollision(false,false,false);
		Spawn(class'IonCore',,, Location, Rotation);
		InitialState = 'Dying';
		SetTimer(0, false);
    }


Begin:
    PlaySound(sound'WeaponSounds.redeemer_explosionsound');
    HurtRadius(DamagePoo, DamageRadiusPoo*0.05, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.1, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.15, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.20, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.25, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.3, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.35, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.4, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.45, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.5, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.55, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.6, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.65, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.7, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.75, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.8, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.85, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.9, MyDamageTypePoo, 200000, Location);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*0.95, MyDamageTypePoo, 200000, lOcation);
    Sleep(1.5);
    HurtRadius(DamagePoo, DamageRadiusPoo*1.00, MyDamageTypePoo, 200000, Location);
    Destroy();
}

defaultproperties
{
     ComboSound=Sound'WeaponSounds.ShockRifle.ShockComboFire'
     ComboDamage=200.000000
     ComboRadius=275.000000
     ComboMomentumTransfer=150000.000000
     ComboAmmoCost=1000
     ComboDamageType=Class'fpsWeaponPack.DamTypeBigBangBeam'
     DamageRadiusPoo=35000.000000
     MyDamageTypePoo=Class'XWeapons.DamTypeRedeemer'
     DamagePoo=500.000000
     Speed=1150.000000
     MaxSpeed=1150.000000
     bSwitchToZeroCollision=True
     Damage=45.000000
     DamageRadius=150.000000
     MomentumTransfer=70000.000000
     MyDamageType=Class'fpsWeaponPack.DamTypeBigBangBall'
     ImpactSound=Sound'WeaponSounds.ShockRifle.ShockRifleExplosion'
     ExplosionDecal=Class'XEffects.ShockImpactScorch'
     MaxEffectDistance=7000.000000
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=195
     LightSaturation=85
     LightBrightness=255.000000
     LightRadius=4.000000
     DrawType=DT_Sprite
     CullDistance=4000.000000
     bDynamicLight=True
     bNetTemporary=False
     bOnlyDirtyReplication=True
     AmbientSound=Sound'WeaponSounds.ShockRifle.ShockRifleProjectile'
     LifeSpan=10.000000
     Texture=Texture'XEffectMat.Shock.shock_core_low'
     DrawScale=0.700000
     Skins(0)=Texture'XEffectMat.Shock.shock_core_low'
     Style=STY_Translucent
     FluidSurfaceShootStrengthMod=8.000000
     SoundVolume=50
     SoundRadius=100.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bProjTarget=True
     bAlwaysFaceCamera=True
     ForceType=FT_Constant
     ForceRadius=40.000000
     ForceScale=5.000000
}
