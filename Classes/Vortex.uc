Class Vortex extends Weapon
	config(user);

#exec AUDIO IMPORT FILE="Snds\vortex_holdambient.wav" NAME="vortex_holdambient" GROUP="Vortex"
#exec AUDIO IMPORT FILE="Snds\vortex_select.wav" NAME="vortex_select" GROUP="Vortex"

#exec TEXTURE IMPORT FILE="Tex\VortexIcon.tga" NAME="Vortex" GROUP="XHairs"

var protected VortexWatcher VortexWatcher;
var VortexDummyProj DummyProj;

simulated function SuperMaxOutAmmo()
{}

simulated function ShowDummyProj()
{
	if ( DummyProj != None )
		DummyProj.bHidden = False;
}

simulated function HideDummyProj()
{
	if ( DummyProj != None )
		DummyProj.bHidden = True;
}

simulated function ClientWeaponThrown()
{
	HideDummyProj();
	Super.ClientWeaponThrown();
}

simulated function Destroyed()
{
    if ( DummyProj != None )
		DummyProj.Destroy();
    Super.Destroyed();
}

// AI Interface
function float GetAIRating()
{
	local Bot B;
	local float EnemyDist;
	local vector EnemyDir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	// if retreating, favor this weapon
	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);
	if ( EnemyDist > 1500 )
		return 0.1;
	if ( B.IsRetreating() )
		return (AIRating + 0.4);
	if ( -1 * EnemyDir.Z > EnemyDist )
		return AIRating + 0.1;
	if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
		return (AIRating + 0.3);
	if ( EnemyDist > 1000 )
		return 0.35;
	return AIRating;
}

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	if ( FRand() < 0.8 )
		return 0;
	return 1;
}

function float SuggestAttackStyle()
{
	local Bot B;
	local float EnemyDist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0.4;

	EnemyDist = VSize(B.Enemy.Location - Instigator.Location);
	if ( EnemyDist > 1500 )
		return 1.0;
	if ( EnemyDist > 1000 )
		return 0.4;
	return -0.4;
}

function float SuggestDefenseStyle()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if ( VSize(B.Enemy.Location - Instigator.Location) < 1600 )
		return -0.6;
	return 0;
}

// End AI Interface

simulated function AnimEnd(int Channel)
{
	local name anim;
	local float frame, rate;
	GetAnimParams(0, anim, frame, rate);

	if (FireMode[1].bIsFiring )
		LoopAnim('Hold', 1.0, 0.1);
	else
		Super.AnimEnd(Channel);
}

simulated function PlayIdle()
{
	Super.PlayIdle();
	if (Ammo[0] != none && Ammo[0].AmmoAmount > 0 )
		ShowDummyProj();
}

// needed to add this check for a multi-ammo weapon and to allow the firing animations to play on the last shot
simulated function OutOfAmmo()
{

    if (Level.NetMode == NM_Standalone && !Instigator.IsLocallyControlled())
       return;

    if (FireMode[0].bIsFiring || FireMode[1].bIsFiring)
       return; // weapon is firing dont try to change ammo just yet...

    Super.OutOfAmmo();
}

simulated function float ChargeBar()
{
	if ( VortexWatcher == None )
		ForEach DynamicActors(class'VortexWatcher', VortexWatcher)
			break;
	if ( VortexWatcher != None && VortexWatcher.VortexEndTime > Level.TimeSeconds )
		return (VortexWatcher.VortexEndTime - Level.TimeSeconds) / class'VortexProj'.static.GetVortexDuration();
	//else
	return FMin(1,FireMode[1].HoldTime/VortexChargedFire(FireMode[1]).MaxChargeTime);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	AmbientSound=Sound'fpsWeaponPack.Vortex.vortex_holdambient';
	Super.BringUp();
}

simulated function bool PutDown()
{
	AmbientSound=None;
	return Super.PutDown();
}

simulated function bool AtVortexLimit()
{
	if ( VortexWatcher == None )
		ForEach DynamicActors(class'VortexWatcher', VortexWatcher)
			break;

	if ( VortexWatcher != None && VortexWatcher.VortexLimitReached() ) {
		if ( Instigator != None && PlayerController(Instigator.Controller) != None )
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(class'VortexLimitMessage');
		return true;
	}
	return false;
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon) {
	if ( HasAmmo() ) {
		if ( (CurrentChoice == None) ) {
			if ( CurrentWeapon != self )
			CurrentChoice = self;
		}
		else if (InventoryGroup == CurrentWeapon.InventoryGroup && InventoryGroup == CurrentChoice.InventoryGroup) {
			if (
				( GroupOffset < CurrentChoice.GroupOffset && CurrentChoice.GroupOffset < CurrentWeapon.GroupOffset ) ||
				( CurrentWeapon.GroupOffset < GroupOffset && GroupOffset < CurrentChoice.GroupOffset ) ||
				( CurrentChoice.GroupOffset < CurrentWeapon.GroupOffset && CurrentWeapon.GroupOffset < GroupOffset)
			)
				CurrentChoice = self;
		}
		else if (
			( CurrentWeapon.InventoryGroup == InventoryGroup && CurrentWeapon.GroupOffset < GroupOffset) ||
			( CurrentWeapon.InventoryGroup == CurrentChoice.InventoryGroup && CurrentChoice.GroupOffset < CurrentWeapon.GroupOffset) ||
			( CurrentChoice.InventoryGroup == InventoryGroup && GroupOffset < CurrentChoice.GroupOffset ) ||
			( InventoryGroup < CurrentChoice.InventoryGroup && CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup ) ||
			( CurrentWeapon.InventoryGroup < InventoryGroup && InventoryGroup < CurrentChoice.InventoryGroup ) ||
			( CurrentChoice.InventoryGroup < CurrentWeapon.InventoryGroup && CurrentWeapon.InventoryGroup < InventoryGroup)
		)
			CurrentChoice = self;
	}
	if ( Inventory == None )
		return CurrentChoice;
	else
		return Inventory.NextWeapon(CurrentChoice,CurrentWeapon);
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon) {
	if ( HasAmmo() ) {
		if ( (CurrentChoice == None) ) {
			if ( CurrentWeapon != self )
			CurrentChoice = self;
		}
		else if (InventoryGroup == CurrentWeapon.InventoryGroup && InventoryGroup == CurrentChoice.InventoryGroup) {
			if (
				( GroupOffset > CurrentChoice.GroupOffset && CurrentChoice.GroupOffset > CurrentWeapon.GroupOffset ) ||
				( CurrentWeapon.GroupOffset > GroupOffset && GroupOffset > CurrentChoice.GroupOffset ) ||
				( CurrentChoice.GroupOffset > CurrentWeapon.GroupOffset && CurrentWeapon.GroupOffset > GroupOffset)
			)
				CurrentChoice = self;
		}
		else if (
			( CurrentWeapon.InventoryGroup == InventoryGroup && CurrentWeapon.GroupOffset > GroupOffset) ||
			( CurrentWeapon.InventoryGroup == CurrentChoice.InventoryGroup && CurrentChoice.GroupOffset > CurrentWeapon.GroupOffset) ||
			( CurrentChoice.InventoryGroup == InventoryGroup && GroupOffset > CurrentChoice.GroupOffset ) ||
			( InventoryGroup > CurrentChoice.InventoryGroup && CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup ) ||
			( CurrentWeapon.InventoryGroup > InventoryGroup && InventoryGroup > CurrentChoice.InventoryGroup ) ||
			( CurrentChoice.InventoryGroup > CurrentWeapon.InventoryGroup && CurrentWeapon.InventoryGroup > InventoryGroup)
		)
			CurrentChoice = self;
	}
	if ( Inventory == None )
		return CurrentChoice;
	else
		return Inventory.PrevWeapon(CurrentChoice,CurrentWeapon);
}

defaultproperties
{
     FireModeClass(0)=Class'fpsWeaponPack.VortexFire'
     FireModeClass(1)=Class'fpsWeaponPack.VortexChargedFire'
     SelectAnim="Pickup"
     PutDownAnim="PutDown"
     IdleAnimRate=0.100000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
     SelectSound=Sound'fpsWeaponPack.Vortex.vortex_select'
     SelectForce="SwitchToFlakCannon"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     EffectOffset=(X=100.000000,Y=32.000000,Z=-20.000000)
     DisplayFOV=60.000000
     Priority=23
     SmallViewOffset=(Y=12.000000,Z=-26.000000)
     CenteredOffsetY=-20.000000
     CustomCrosshair=26
     CustomCrossHairColor=(B=128)
     CustomCrossHairTextureName="GravVortex_006.XHairs.Vortex"
     InventoryGroup=0
     GroupOffset=64
     PickupClass=Class'fpsWeaponPack.VortexPickup'
     PlayerViewOffset=(X=-24.000000,Y=-2.000000,Z=-16.000000)
     PlayerViewPivot=(Yaw=-16383)
     BobDamping=2.200000
     AttachmentClass=Class'fpsWeaponPack.VortexAttachment'
     IconMaterial=Texture'fpsWeaponPack.XHairs.Vortex'
     IconCoords=(X1=20,Y1=48,X2=107,Y2=77)
     ItemName="Gravity Vortex"
     Mesh=SkeletalMesh'fpsWepAnim.Vortex.chaos_vortexlauncher_1st'
     UV2Texture=Shader'XGameShaders.WeaponShaders.WeaponEnvShader'
}
