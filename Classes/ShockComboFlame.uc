class ShockComboFlame extends Actor;

#exec OBJ LOAD FILE=XEffectMat.utx

var ShockComboFlare Flare;
var float DamageRadiusPoo;
var class<DamageType> MyDamageTypePoo;
var float DamagePoo;

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if (Level.NetMode != NM_DedicatedServer)
    {
        Spawn(class'ShockComboExpRing');
        Flare = Spawn(class'ShockComboFlare');
        //Spawn(class'ShockComboSphere');
        Spawn(class'ShockExplosionFlame');
        Spawn(class'ShockComboSphereOrange');
        Spawn(class'ShockComboVortex');
        Spawn(class'ShockComboWiggles');
        Spawn(class'ShockComboFlash');
    }
}

auto simulated state Combo
{

Begin:
    Sleep(0.9);
    //Spawn(class'ShockAltExplosion');
    if ( Flare != None )
    {
		Flare.mStartParticles = 2;
		Flare.mRegenRange[0] = 0.0;
		Flare.mRegenRange[1] = 0.0;
		Flare.mLifeRange[0] = 0.7;
		Flare.mLifeRange[1] = 0.7;
		Flare.mSizeRange[0] = 550;
		Flare.mSizeRange[1] = 550;
		Flare.mGrowthRate = 500;
		Flare.mAttenKa = 0.9;
	}
    LightType = LT_None;

}

defaultproperties
{
     DamageRadiusPoo=2000.000000
     MyDamageTypePoo=Class'XWeapons.DamTypeRedeemer'
     DamagePoo=500.000000
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=195
     LightSaturation=100
     LightBrightness=255.000000
     LightRadius=10.000000
     DrawType=DT_None
     bDynamicLight=True
     bNetTemporary=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=2.000000
     bCollideActors=True
     ForceType=FT_Constant
     ForceRadius=300.000000
     ForceScale=-500.000000
}
