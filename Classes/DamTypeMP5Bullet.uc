class DamTypeMP5Bullet extends WeaponDamageType
	abstract;

defaultproperties
{
     WeaponClass=Class'fpsWeaponPack.MP5Gun'
     DeathString="%o was ventilated by %k's ZenMP5."
     FemaleSuicide="%o assaulted herself."
     MaleSuicide="%o assaulted himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=2000.000000
}
