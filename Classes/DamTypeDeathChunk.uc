class DamTypeDeathChunk extends WeaponDamageType
	abstract;

var sound FlakMonkey; //OBSOLETE

static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.flakcount++;
		if ( (xPRI.flakcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('FlackMonkey',15);
	}
}

defaultproperties
{
     WeaponClass=Class'fpsWeaponPack.DeathCannon'
     DeathString="%o was shredded by %k's Death."
     FemaleSuicide="%o was perforated by her own Death."
     MaleSuicide="%o was perforated by his own Death."
     bDelayedDamage=True
     bBulletHit=True
     VehicleMomentumScaling=0.500000
}
