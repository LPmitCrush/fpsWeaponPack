class DamTypeRedeemer extends WeaponDamageType
	abstract;

defaultproperties
{
    WeaponClass=Class'NuclearShockRifle'
    DeathString="%o was PULVERIZED by %k!"
    FemaleSuicide="%o was PULVERIZED!"
    MaleSuicide="%o was PULVERIZED!"
    bArmorStops=False
    bSuperWeapon=True
    bKUseOwnDeathVel=True
    bDelayedDamage=True
    KDeathVel=600.00
    KDeathUpKick=600.00
}
