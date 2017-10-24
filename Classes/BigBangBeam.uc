class BigBangBeam extends ShockBeamEffect;

simulated function SpawnEffects()
{
	local ShockBeamEffect E;
	local ShockBeamEffect EE;
	local ShockBeamCoil CoilInner;
	
	Super.SpawnEffects();
	E = Spawn(class'BigBangBeamExtra');
	if ( E != None )
		E.AimAt(mSpawnVecA, HitNormal); 
	EE = Spawn(class'BigBangBeamExtraInner');
	if ( EE != None )
		EE.AimAt(mSpawnVecA, HitNormal); 
	CoilInner = Spawn(class'BigBangBeamCoilInner',,, Location, Rotation);
	if (CoilInner != None)
	     CoilInner.mSpawnVecA = mSpawnVecA;
}

defaultproperties
{
     CoilClass=Class'fpsWeaponPack.BigBangBeamCoil'
     MuzFlashClass=Class'fpsWeaponPack.BigBangMuzFlash'
     MuzFlash3Class=Class'fpsWeaponPack.BigBangFlash3rd'
     mLifeRange(0)=5.750000
     mSizeRange(0)=200.000000
     mSizeRange(1)=400.000000
     mColorRange(0)=(A=122)
     mColorRange(1)=(A=122)
     LightHue=230
     bNetTemporary=False
     LifeSpan=5.750000
     Texture=Texture'fpsWepTex.shockbeamfinal'
     Skins(0)=Texture'fpsWepTex.shockbeamfinal'
}
