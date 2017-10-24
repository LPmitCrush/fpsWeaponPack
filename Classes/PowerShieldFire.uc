//=========================================================================
// PowerShieldFire
// ========================================================================
class PowerShieldFire extends ShieldFire;
/*
simulated function InitEffects()
{
	if ( Level.NetMode != NM_DedicatedServer )
	{
		ChargingEmitter = Spawn(class'PowerShieldCharge');
		ChargingEmitter.mRegenPause = true;
	}
    bStartedChargingForce = false;  // jdf
    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
    if ( (FlashEmitterClass != None) && ((FlashEmitter == None) || FlashEmitter.bDeleteMe) )
    {
        FlashEmitter = Spawn(FlashEmitterClass);
        //log("Spawned "$FlashEmitter);
    }
    if ( (SmokeEmitterClass != None) && ((SmokeEmitter == None) || SmokeEmitter.bDeleteMe) )
    {
        SmokeEmitter = Spawn(SmokeEmitterClass);
    }
}*/
/*
function DrawMuzzleFlash(Canvas Canvas)
{
    if (ChargingEmitter != None && HoldTime > 0.0 && !bNowWaiting)
    {
        ChargingEmitter.SetLocation( Weapon.GetEffectStart() );
        Canvas.DrawActor( ChargingEmitter, false, false, Weapon.DisplayFOV );
    }    

    if (FlashEmitter != None)
    {
        FlashEmitter.SetLocation( Weapon.GetEffectStart() );
        FlashEmitter.SetRotation(Weapon.Rotation);
        Canvas.DrawActor( FlashEmitter, false, false, Weapon.DisplayFOV ); 
    }
    
    if ( (Instigator.AmbientSound == ChargingSound)
		&& ((HoldTime <= 0.0) || bNowWaiting) )
        Instigator.AmbientSound = None;    

}

function DoFireEffect()
{
	local Vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;
    local Rotator Aim;
	local Actor Other;
    local float Scale, Damage, Force;

	Instigator.MakeNoise(1.0);
    Weapon.GetViewAxes(X,Y,Z);
	bAutoRelease = false;
	StartTrace = Instigator.Location;
    
    Aim = AdjustAim(StartTrace, AimError);

	EndTrace = StartTrace + ShieldRange * Vector(Aim); 

	Other = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);
    
    Scale = (FClamp(HoldTime, MinHoldTime, FullyChargedTime) - MinHoldTime) / (FullyChargedTime - MinHoldTime); // result 0 to 1
    Damage = MinDamage + Scale * (MaxDamage - MinDamage);
    Force = MinForce + Scale * (MaxForce - MinForce);

    Instigator.AmbientSound = None;
    
    if (ChargingEmitter != None)
        ChargingEmitter.mRegenPause = true;

    if ( Other != None && Other != Instigator )
    {
	    if ( Pawn(Other) != None )
            Other.TakeDamage(Damage, Instigator, HitLocation, Force*(X+vect(0,0,0.5)), DamageType);
	    else
	    {
            if (xPawn(Instigator).bBerserk) 
				Force *= 2.0;	                
            Instigator.TakeDamage(SelfDamageScale*Damage, Instigator, HitLocation, -SelfForceScale*Force*X, DamageType);
        }
	}

    SetTimer(0, false);
}


function Timer()
{
    local Actor Other;
    local Vector HitLocation, HitNormal, StartTrace, EndTrace;
    local Rotator Aim;
    local float Regen;
    local float ChargeScale;

    if (HoldTime > 0.0 && !bNowWaiting)
    {        
	    StartTrace = Instigator.Location;  
		Aim = AdjustAim(StartTrace, AimError);
	    EndTrace = StartTrace + ShieldRange * Vector(Aim); 

        Other = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);
        if ( Other != None && Other != Instigator && Other.IsA('Pawn'))
        {
			bAutoRelease = true;
            bIsFiring = false;
            Instigator.AmbientSound = None;
            if (ChargingEmitter != None)
                ChargingEmitter.mRegenPause = true;
        }
        else
        {                
            Instigator.AmbientSound = ChargingSound;
            ChargeScale = FMin(HoldTime, FullyChargedTime);
            if (ChargingEmitter != None)
            {
                ChargingEmitter.mRegenPause = false;            
                Regen = ChargeScale * 20 + 30;
                ChargingEmitter.mRegenRange[0] = Regen*3;
                ChargingEmitter.mRegenRange[1] = Regen*3;
                ChargingEmitter.mSpeedRange[0] = ChargeScale * -85.0;
                ChargingEmitter.mSpeedRange[1] = ChargeScale * -85.0;            
                Regen = FMax((ChargeScale / 20.0),0.40);
                ChargingEmitter.mLifeRange[0] = Regen;
                ChargingEmitter.mLifeRange[1] = Regen;
            }
            
            if (!bStartedChargingForce)
            {
                bStartedChargingForce = true;
                ClientPlayForceFeedback( ChargingForce );
            }
        }
    }
    else
    {
		if ( Instigator.AmbientSound == ChargingSound )
			Instigator.AmbientSound = None;
        SetTimer(0, false);
    }
}


function PlayPreFire()
{
    Weapon.PlayAnim('Charge', 1.0/FullyChargedTime, 0.1);
}
*/

defaultproperties
{
     DamageType=Class'fpsWeaponPack.DamTypePowerShieldImpact'
     ShieldRange=120.000000
     MinHoldTime=0.250000
     MinDamage=800.000000
     MaxDamage=800.000000
     SelfForceScale=1.500000
     SelfDamageScale=0.800000
     FullyChargedTime=3.000000
     AmmoClass=Class'fpsWeaponPack.PowerShieldAmmo'
     FlashEmitterClass=Class'fpsWeaponPack.PowerForceRingA'
}
