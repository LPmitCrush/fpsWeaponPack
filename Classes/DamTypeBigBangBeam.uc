class DamTypeBigBangBeam extends WeaponDamageType
	abstract;

static function GetHitEffects(out class<xEmitter> HitEffects[4], int VictemHealth )
{
    HitEffects[0] = class'HitSmoke';
}

defaultproperties
{
     WeaponClass=Class'fpsWeaponPack.BigBangRifle'
     DeathString="%o was fatally enlightened by %k's Big Bang beam."
     FemaleSuicide="%o somehow managed to shoot herself with the Big Bang rifle."
     MaleSuicide="%o somehow managed to shoot himself with the Big Bang rifle."
     bDetonatesGoop=True
     DamageOverlayMaterial=Shader'UT2004Weapons.Shaders.ShockHitShader'
     DamageOverlayTime=0.800000
     GibPerterbation=0.750000
     VehicleDamageScaling=0.850000
     VehicleMomentumScaling=0.500000
}
