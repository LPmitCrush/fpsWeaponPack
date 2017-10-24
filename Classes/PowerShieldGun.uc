Class PowerShieldGun extends ShieldGun;

#exec OBJ LOAD FILE="fpsWepAnim.ukx"

var Float ShieldJumpStrength;
var Inventory SG;

function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	PowerShieldFire(FireMode[0]).SelfForceScale=ShieldJumpStrength;

}

function bool CheckReflect( Vector HitLocation, out Vector RefNormal, int AmmoDrain )
{
    local Vector HitDir;
    local Vector FaceDir;

    if (!FireMode[1].bIsFiring || AmmoAmount(0) == 0) return false;

    FaceDir = Vector(Instigator.Controller.Rotation);
    HitDir = Normal(Instigator.Location - HitLocation + Vect(0,0,8));
    //Log(self@"HitDir"@(FaceDir dot HitDir));

    RefNormal = FaceDir;

    return true;
    /*if ( FaceDir dot HitDir < -0.37 ) // 68 degree protection arc
    {
        if (AmmoDrain > 0)
            ConsumeAmmo(0,AmmoDrain);
        return true;
    }
    return false;*/
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, 
						         out Vector Momentum, class<DamageType> DamageType)
{
    local int Drain;
    local vector Reflect;
    local vector HitNormal, hitdir;
    local float DamageMax;

    HitDir = -1.0 * Normal(Instigator.Location - HitLocation + Vect(0,0,8));
	DamageMax = 100.0;
	if ( DamageType == class'Fell' )
		DamageMax =0.0;
	//else if( !DamageType.default.bArmorStops || (DamageType == class'DamTypeShieldImpact' && InstigatedBy == Instigator) )
        //return;

    if ( CheckReflect(HitLocation, HitNormal, 0) )
    {
        Drain = Min( AmmoAmount(1), Damage );
		Drain = Min(Drain,DamageMax);
	    Reflect = MirrorVectorByNormal( Normal(Location - HitLocation), HitDir );
        Damage -= Drain;
        Momentum *= 1.25;
       // Ammo[1].UseAmmo(Drain/4);
        DoReflectEffect(Drain/2);
    }
}
/*
simulated function ShieldRenderOverlays( Canvas Canvas )
{
    local int m;
	local vector NewScale3D;
	local rotator CenteredRotation;
	local name AnimSeq;
	local float frame,rate;

    if (Instigator == None)
        return;

	if ( Instigator.Controller != None )
		Hand = Instigator.Controller.Handedness;

    if ((Hand < -1.0) || (Hand > 1.0))
        return;

    // draw muzzleflashes/smoke for all fire modes so idle state won't
    // cause emitters to just disappear
    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None)
        {
            FireMode[m].DrawMuzzleFlash(Canvas);
        }
    }

	if ( (OldMesh != None) && (bUseOldWeaponMesh != (OldMesh == Mesh)) )
	{
		GetAnimParams(0,AnimSeq,frame,rate);
		bInitOldMesh = true;
		if ( bUseOldWeaponMesh )
			LinkMesh(OldMesh);
		else
			LinkMesh(Default.Mesh);
		PlayAnim(AnimSeq,rate,0.0);
	}

    if ( (Hand != RenderedHand) || bInitOldMesh )
    {
		newScale3D = Default.DrawScale3D;
		//if ( Hand != 0 )
		//	newScale3D.Y *= Hand;
		SetDrawScale3D(newScale3D);
		SetDrawScale(Default.DrawScale);
		CenteredRoll = Default.CenteredRoll;
		CenteredYaw = Default.CenteredYaw;
		CenteredOffsetY = Default.CenteredOffsetY;
		PlayerViewPivot = Default.PlayerViewPivot;
		SmallViewOffset = Default.SmallViewOffset;
		if ( SmallViewOffset == vect(0,0,0) )
			SmallViewOffset = Default.PlayerviewOffset;
		bInitOldMesh = false;
		if ( Default.SmallEffectOffset == vect(0,0,0) )
			SmallEffectOffset = EffectOffset + Default.PlayerViewOffset - SmallViewOffset;
		else
			SmallEffectOffset = Default.SmallEffectOffset;
		if ( Mesh == OldMesh )
		{
			SmallEffectOffset = EffectOffset + OldPlayerViewOffset - OldSmallViewOffset;
			PlayerViewPivot = OldPlayerViewPivot;
			SmallViewOffset = OldSmallViewOffset;
			if ( Hand != 0 )
			{
				PlayerViewPivot.Roll *= Hand;
				PlayerViewPivot.Yaw *= Hand;
			}
			CenteredRoll = OldCenteredRoll;
			CenteredYaw = OldCenteredYaw;
			CenteredOffsetY = OldCenteredOffsetY;
			SetDrawScale(OldDrawScale);
		}
		else if ( Hand == 0 )
		{
			PlayerViewPivot.Roll = Default.PlayerViewPivot.Roll;
			PlayerViewPivot.Yaw = Default.PlayerViewPivot.Yaw;
		}
		else
		{
			PlayerViewPivot.Roll = Default.PlayerViewPivot.Roll * Hand;
			PlayerViewPivot.Yaw = Default.PlayerViewPivot.Yaw * Hand;
		}
		RenderedHand = Hand;
	}

	if ( Mesh == OldMesh )
		PlayerViewOffset = OldPlayerViewOffset;
	else
		PlayerViewOffset = Default.PlayerViewOffset;
	if ( Hand == 0 )
		PlayerViewOffset.Y = CenteredOffsetY;
	else
		PlayerViewOffset.Y *= Hand;

    SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
    if ( Hand == 0 )
    {
		CenteredRotation = Instigator.GetViewRotation();
		CenteredRotation.Yaw += CenteredYaw;
		CenteredRotation.Roll = CenteredRoll;
	    SetRotation(CenteredRotation);
    }
    else
	    SetRotation( Instigator.GetViewRotation() );

	PreDrawFPWeapon();	// Laurent -- Hook to override things before render (like rotation if using a staticmesh)

    bDrawingFirstPerson = true;
    Canvas.DrawActor(self, false, false, DisplayFOV);
    bDrawingFirstPerson = false;
	if ( Hand == 0 )
		PlayerViewOffset.Y = 0;
}

simulated event RenderOverlays( Canvas Canvas )
{
    local int m;

    if ((Hand < -1.0) || (Hand > 1.0))
    {
		for (m = 0; m < NUM_FIRE_MODES; m++)
		{
			if (FireMode[m] != None)
			{
				FireMode[m].DrawMuzzleFlash(Canvas);
			}
		}
	}
    ShieldRenderOverlays(Canvas);
}
*/
simulated function vector GetEffectStart()
{
    local Vector X,Y,Z;

    // jjs - this function should actually never be called in third person views
    // any effect that needs a 3rdp weapon offset should figure it out itself

    // 1st person
    if (Instigator.IsFirstPerson())
    {
        if ( WeaponCentered() )
			return CenteredEffectStart();

        GetViewAxes(X, Y, Z);
	return (Instigator.Location +
	Instigator.CalcDrawOffset(self) +
	EffectOffset.X * X +
	EffectOffset.Y * Y * Hand +
	EffectOffset.Z * Z);
    }
    // 3rd person
    else
    {
        return (Instigator.Location +
            Instigator.EyeHeight*Vect(0,0,0.5) +
            Vector(Instigator.Rotation) * 40.0);
    }
}

simulated function bool ShieldOn()
{
	if ( FireMode[1].isFiring() )
		return true;
	else
		return false;
}

defaultproperties
{
     ShieldJumpStrength=5.000000
     FireModeClass(0)=Class'fpsWeaponPack.PowerShieldFire'
     FireModeClass(1)=Class'fpsWeaponPack.PowerShieldAltFire'
     SelectAnimRate=12.000000
     PutDownAnimRate=12.000000
     PutDownTime=0.100000
     BringUpTime=0.100000
     bCanThrow=True
     bNoAmmoInstances=False
     Description="Power Shield Gun. This weapon can give enemy's 800 Damage and it can protect you around yourself!"
     PickupClass=Class'fpsWeaponPack.PowerShieldGunPickup'
     AttachmentClass=Class'fpsWeaponPack.PowerShieldAttachment'
     ItemName="Power Shield Gun"
     Mesh=SkeletalMesh'fpsWepAnim.Shield.PowerShieldGun_1st'
}
