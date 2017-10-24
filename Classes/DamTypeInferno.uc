class DamTypeInferno extends VehicleDamageType
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
     VehicleClass=Class'Onslaught.ONSHoverTank'
     DeathString="%o got Burned! by %k"
     FemaleSuicide="%o Burned! herself."
     MaleSuicide="%o Burned! himself."
	bAlwaysSevers=True
     bDetonatesGoop=True
     bDelayedDamage=True
     bThrowRagdoll=True
     bFlaming=True
	GibPerterbation=0.150000
	KDamageImpulse=20000.000000
     VehicleDamageScaling=1.750000
     VehicleMomentumScaling=1.300000
}
