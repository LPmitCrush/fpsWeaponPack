class DamTypeMP5Grenade extends WeaponDamageType
	abstract;
	
static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictimHealth )
{
    HitEffects[0] = class'HitSmoke';

    if( VictimHealth <= 0 )
        HitEffects[1] = class'HitFlameBig';
    else if ( FRand() < 0.8 )
        HitEffects[1] = class'HitFlame';
}

defaultproperties
{
     WeaponClass=Class'fpsWeaponPack.MP5Gun'
     DeathString="%o couldn't avoid %k's ZenMP5 grenade."
     FemaleSuicide="%o jumped on her own ZenMP5 grenade."
     MaleSuicide="%o jumped on his own ZenMP5 grenade."
     GibPerterbation=0.400000
}
