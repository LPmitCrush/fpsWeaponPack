//=========================================================================
// PowerShieldCharge
// ========================================================================
class PowerShieldCharge extends xEmitter;
	

defaultproperties
{
     mParticleType=PT_Line
     mSpawningType=ST_Explode
     mStartParticles=0
     mMaxParticles=200
     mLifeRange(0)=0.100000
     mLifeRange(1)=0.100000
     mRegenRange(0)=75.000000
     mRegenRange(1)=100.000000
     mPosDev=(X=9.000000,Y=9.000000,Z=9.000000)
     mSpawnVecB=(X=5.000000,Z=0.080000)
     mSpeedRange(0)=-75.000000
     mSpeedRange(1)=-75.000000
     mPosRelative=True
     mAirResistance=0.000000
     mSizeRange(0)=0.200000
     mSizeRange(1)=0.400000
     mColorRange(0)=(B=45,G=220,R=45,A=25)
     mColorRange(1)=(B=65,G=250,R=65,A=200)
     bOnlyOwnerSee=True
     Physics=PHYS_Rotating
     Skins(0)=Texture'XEffects.FlakTrailTex'
     Style=STY_Additive
     bFixedRotationDir=True
     RotationRate=(Yaw=16000)
}
