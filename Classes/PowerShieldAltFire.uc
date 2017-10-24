//=========================================================================
// PowerShieldAltFire
// ========================================================================
class PowerShieldAltFire extends ShieldAltFire;

//var PowerShieldEffect ShieldEffect;
/*var() float AmmoRegenTime;
var() float ChargeupTime;
var	  float RampTime;
var Sound ChargingSound;                // charging sound
var() int holdShield;

simulated function DestroyEffects()
{
    if ( Weapon.Role == ROLE_Authority )
    {
        if ( ShieldEffect != None )
            ShieldEffect.Destroy();
    }
    Super.DestroyEffects();
}
*/
function DoFireEffect()
{
    local PowerShieldAttachment Attachment;

    Attachment = PowerShieldAttachment(Weapon.ThirdPersonActor);
    Instigator.AmbientSound = ChargingSound;
    Instigator.SoundVolume = ShieldSoundVolume;
   
    if( Attachment != None && Attachment.ShieldEffect3rd != None )
        Attachment.ShieldEffect3rd.bHidden = false;

    SetTimer(AmmoRegenTime, true);
}


/*function PlayFiring()
{
    ClientPlayForceFeedback("ShieldNoise");  // jdf
    SetTimer(AmmoRegenTime, true);
    Weapon.LoopAnim('Shield');
}*/

function StopFiring()
{
    local PowerShieldAttachment Attachment;

    Attachment = PowerShieldAttachment(Weapon.ThirdPersonActor);
	Instigator.AmbientSound = None;
    Instigator.SoundVolume = Instigator.Default.SoundVolume;
    
    if( Attachment != None && Attachment.ShieldEffect3rd != None )
    {
        Attachment.ShieldEffect3rd.bHidden = true;
        StopForceFeedback( "ShieldNoise" );  // jdf
    }

    SetTimer(AmmoRegenTime, true);
}

function TakeHit(int Drain)
{
    if (ShieldEffect != None)
    {
        ShieldEffect.Flash(Drain);
    }

    SetBrightness(true);
}

function StartBerserk()
{
}

function StopBerserk()
{
}

function SetBrightness(bool bHit)
{
    local PowerShieldAttachment Attachment;
 	local float Brightness;

	Brightness = Weapon.AmmoAmount(0);
	if ( RampTime < ChargeUpTime )
		Brightness *= RampTime/ChargeUpTime; 
    if (ShieldEffect != None)
        ShieldEffect.SetBrightness(Brightness);

    Attachment = PowerShieldAttachment(Weapon.ThirdPersonActor);
    if( Attachment != None )
        Attachment.SetBrightness(Brightness, bHit);
}

function DrawMuzzleFlash(Canvas Canvas)
{
    Super(WeaponFire).DrawMuzzleFlash(Canvas);

    if (ShieldEffect == None)
        ShieldEffect = Weapon.Spawn(class'PowerShieldEffect', instigator);

    if ( bIsFiring && Weapon.AmmoAmount(1) > 0 )
    {
        ShieldEffect.SetLocation( Weapon.GetEffectStart() );
        ShieldEffect.SetRotation( Instigator.GetViewRotation() );
        Canvas.DrawActor( ShieldEffect, false, false, Weapon.DisplayFOV );
    }
}
/*
function Timer()
{

   if( Weapon.AmmoAmount(0) == 0 )
        return;

    if (!bIsFiring)
    {
		RampTime = 0;
        if (Weapon.AmmoAmount(0) < Weapon.Ammo[1].MaxAmmo)
	{
            Weapon.Ammo[1].AmmoAmount += 1;
	    NextFireTime = Level.TimeSeconds + (Weapon.Ammo[1].MaxAmmo - Weapon.Ammo[1].AmmoAmount ) * AmmoRegenTime;
	}
        else
            SetTimer(0, false);
    }
    else
    {
        if (!Weapon.Ammo[1].UseAmmo(1))
        {
            if (Weapon.ClientState == WS_ReadyToFire)
                Weapon.PlayIdle();
            StopFiring();
        }
        else
			RampTime += AmmoRegenTime;
    }
	
	SetBrightness(false);
}
*/

defaultproperties
{
     AmmoRegenTime=0.350000
     ChargeupTime=1.000000
     FireRate=2.000000
     AmmoClass=Class'fpsWeaponPack.PowerShieldAmmo'
     AmmoPerFire=1
}
