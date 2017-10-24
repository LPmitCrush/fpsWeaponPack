//=============================================================================
// VortexMainLightning
// $Id: VortexMainLightning.uc,v 1.2 2004/03/18 23:14:27 Melaneus Exp $
//=============================================================================
class VortexMainLightning extends Emitter;

//simulated function PostBeginPlay()
//{
//	Super.PostBeginPlay();
//	log("Spawned"@Self);
//}

simulated function Tick(float DeltaTime)
{
	local float alpha;

	alpha = FClamp(0.5 * (Default.LifeSpan - LifeSpan), 0.1, 1.0);
	
	BeamEmitter(Emitters[0]).BeamDistanceRange.Min = Lerp(alpha, 100, 300, True);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Max = Lerp(alpha, 200, 500, True);

	BeamEmitter(Emitters[1]).BeamDistanceRange.Max = Lerp(alpha, 50, 200, True);
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=300.000000,Max=500.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=2.000000
         BeamTextureVScale=0.500000
         RotatingSheets=4
         LowFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-20.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HFScaleFactors(1)=(FrequencyScale=(X=3.000000,Y=3.000000,Z=3.000000),RelativeLength=1.000000)
         UseHighFrequencyScale=True
         DynamicTimeBetweenNoiseRange=(Max=1.000000)
         UseBranching=True
         BranchProbability=(Min=1.000000,Max=5.000000)
         BranchHFPointsRange=(Min=1.000000,Max=100.000000)
         BranchEmitter=1
         BranchSpawnAmountRange=(Min=1.000000,Max=2.000000)
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         ColorScale(0)=(Color=(B=204,G=204,R=255))
         ColorScale(1)=(RelativeTime=1.000000)
         ColorScaleRepeats=2.000000
         ColorMultiplierRange=(X=(Min=0.500000,Max=1.100000),Z=(Max=1.300000))
         FadeOutStartTime=0.800000
         FadeInEndTime=0.050000
         MaxParticles=4
         StartSizeRange=(X=(Min=40.000000,Max=80.000000))
         ParticlesPerSecond=1.000000
         Texture=Texture'XEffects.Skins.LightningBoltT'
         LifetimeRange=(Min=0.300000,Max=2.000000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'fpsWeaponPack.VortexMainLightning.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=50.000000,Max=200.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureVScale=0.500000
         LowFrequencyNoiseRange=(X=(Max=3.000000),Y=(Max=3.000000))
         LowFrequencyPoints=8
         HighFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=0.500000,Max=5.000000))
         HighFrequencyPoints=6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000)
         ColorScaleRepeats=2.000000
         FadeOutStartTime=0.400000
         FadeInEndTime=0.050000
         MaxParticles=40
         StartSizeRange=(X=(Min=10.000000,Max=30.000000))
         Texture=Texture'XEffects.Skins.LightningBoltT'
         LifetimeRange=(Min=0.100000,Max=0.500000)
         AddVelocityFromOtherEmitter=0
         GetVelocityDirectionFrom=PTVD_OwnerAndStartPosition
     End Object
     Emitters(1)=BeamEmitter'fpsWeaponPack.VortexMainLightning.BeamEmitter1'

     bNoDelete=False
     Physics=PHYS_Trailer
     LifeSpan=13.600000
}
