//=============================================================================
// Suck effect for Voxtex
// $Id: VortexEmitter.uc,v 1.2 2004/03/18 23:14:27 Melaneus Exp $
//=============================================================================
class VortexEmitter extends Emitter;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(11.0, False);
//	log("Spawned"@Self);
}

simulated function Timer()
{
	Kill();
//	log("Killed"@Self);
}

simulated function Tick(float DeltaTime)
{
	local float alpha;
	
	alpha = 0.1 * (Default.LifeSpan - LifeSpan);
	
	SpriteEmitter(Emitters[0]).FadeOutStartTime = Lerp(alpha, 0.4, 1.0);
	SpriteEmitter(Emitters[0]).StartVelocityRadialRange.Min = Lerp(alpha, -10, -25);
	SpriteEmitter(Emitters[0]).StartVelocityRadialRange.Max = Lerp(alpha, -10, -25);
	SpriteEmitter(Emitters[0]).SphereRadiusRange.Min = Lerp(alpha, 150, 500);
	SpriteEmitter(Emitters[0]).SphereRadiusRange.Max = Lerp(alpha, 150, 500);
	SpriteEmitter(Emitters[0]).LifetimeRange.Min = Lerp(alpha, 0.25, 1.5);
	SpriteEmitter(Emitters[0]).LifetimeRange.Max = Lerp(alpha, 0.25, 1.5);
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=VortexEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         UseVelocityScale=True
         ColorScale(0)=(Color=(B=255,G=20,R=20))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=255,G=170,R=170))
         ColorScale(2)=(RelativeTime=1.400000,Color=(B=255,G=255,R=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         MaxParticles=150
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=512.000000,Max=512.000000)
         RevolutionsPerSecondRange=(Z=(Min=0.200000,Max=0.500000))
         RevolutionScale(0)=(RelativeRevolution=(Z=2.000000))
         RevolutionScale(1)=(RelativeTime=0.600000)
         RevolutionScale(2)=(RelativeTime=1.000000,RelativeRevolution=(Z=2.000000))
         SpinsPerSecondRange=(X=(Max=4.000000))
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=8.000000,Max=8.000000))
         Texture=Texture'EpicParticles.Flares.HotSpot'
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRadialRange=(Min=-20.000000,Max=-20.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(1)=(RelativeTime=0.100000)
         VelocityScale(2)=(RelativeTime=0.200000,RelativeVelocity=(X=-32.000000,Y=-32.000000,Z=-32.000000))
     End Object
     Emitters(0)=SpriteEmitter'fpsWeaponPack.VortexEmitter.VortexEmitter2'

     bNoDelete=False
     Physics=PHYS_Trailer
     LifeSpan=13.600000
}
