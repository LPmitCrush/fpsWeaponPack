class DamTypeBigBangBall extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictemHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     WeaponClass=Class'fpsWeaponPack.BigBangRifle'
     DeathString="%o was wasted by %k's Big Bang core."
     FemaleSuicide="%o snuffed herself with the Big Bang core."
     MaleSuicide="%o snuffed himself with the Big Bang core."
     bDetonatesGoop=True
     bDelayedDamage=True
     DamageOverlayMaterial=Shader'UT2004Weapons.Shaders.ShockHitShader'
     DamageOverlayTime=0.800000
}
