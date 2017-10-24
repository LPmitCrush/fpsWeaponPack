class DamTypeOrphanMakerChunk extends WeaponDamageType
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
     WeaponClass=Class'fpsWeaponPack.OrphanMaker'
     DeathString="%o's parents were deleted."
     FemaleSuicide="%o deleted her own parents........and then herself."
     MaleSuicide="%o deleted his own parents........and then himself."
     bDelayedDamage=True
     bBulletHit=True
     VehicleMomentumScaling=0.500000
}
