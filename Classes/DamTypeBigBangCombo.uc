class DamTypeBigBangCombo extends WeaponDamageType
	abstract;

var sound ComboWhore; // OBSOLETE

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictemHealth )
{
    HitEffects[0] = class'HitSmoke';
}

static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;
	
	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.combocount++;
		if ( (xPRI.combocount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('ComboWhore',15);
	}
}		

defaultproperties
{
     WeaponClass=Class'fpsWeaponPack.BigBangRifle'
     DeathString="%o couldn't avoid the blast from %k's Big Bang combo."
     FemaleSuicide="%o made a tactical error with her Big Bang combo."
     MaleSuicide="%o made a tactical error with his Big Bang combo."
     bAlwaysSevers=True
     bDetonatesGoop=True
     bThrowRagdoll=True
}
