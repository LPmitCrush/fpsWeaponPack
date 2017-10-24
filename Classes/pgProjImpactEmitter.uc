Class pgProjImpactEmitter extends Emitter;

// Same deal as in the projectile emitter class
simulated function SetColour(byte FireMode)
{
	// Primary
	if (FireMode == 0)
	{
		if (Emitters[0] != none)
		{
			Emitters[0].ColorScale[0].Color = Class'Canvas'.static.MakeColor(147, 255, 244);
			Emitters[0].ColorScale[1].Color = Class'Canvas'.static.MakeColor(95, 95, 243);
		}

		if (Emitters[1] != none)
		{
			Emitters[1].ColorScale[0].Color = Class'Canvas'.static.MakeColor(83, 238, 255);
			Emitters[1].ColorScale[1].Color = Class'Canvas'.static.MakeColor(38, 51, 202);
		}
	}
	else if (FireMode == 1)
	{
		if (Emitters[0] != none)
		{
			Emitters[0].ColorScale[0].Color = Class'Canvas'.static.MakeColor(249, 255, 136);
			Emitters[0].ColorScale[1].Color = Class'Canvas'.static.MakeColor(255, 70, 9);
		}

		if (Emitters[1] != none)
		{
			Emitters[1].ColorScale[0].Color = Class'Canvas'.static.MakeColor(255, 234, 151);
			Emitters[1].ColorScale[1].Color = Class'Canvas'.static.MakeColor(200, 69, 26);
		}
	}
	else if (FireMode == 2)
	{
		if (Emitters[0] != none)
		{
			Emitters[0].ColorScale[0].Color = Class'Canvas'.static.MakeColor(70, 70, 70);
			Emitters[0].ColorScale[1].Color = Class'Canvas'.static.MakeColor(70, 70, 70);
		}

		if (Emitters[1] != none)
		{
			Emitters[1].ColorScale[0].Color = Class'Canvas'.static.MakeColor(69, 69, 69);
			Emitters[1].ColorScale[1].Color = Class'Canvas'.static.MakeColor(69, 69, 69);
		}
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=pgImpactSpriteEmitter
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=7
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=200.000000))
         InitialParticlesPerSecond=14.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'fpsWeaponPack.pgProjImpactEmitter.pgImpactSpriteEmitter'

     Begin Object Class=SpriteEmitter Name=pgImpactSpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseRevolution=True
         UseRevolutionScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseVelocityScale=True
         ColorScale(1)=(RelativeTime=1.000000)
         FadeOutStartTime=0.602000
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=4.000000,Max=40.000000)
         RevolutionsPerSecondRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         RevolutionScale(0)=(RelativeRevolution=(X=1.000000,Y=1.000000,Z=1.000000))
         RevolutionScale(1)=(RelativeTime=0.500000,RelativeRevolution=(X=1.000000,Y=1.000000,Z=1.000000))
         RevolutionScale(2)=(RelativeTime=1.000000)
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=15.000000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000))
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=0.001000,Max=0.700000)
         StartVelocityRange=(X=(Min=100.000000,Max=100.000000),Y=(Min=100.000000,Max=100.000000),Z=(Min=100.000000,Max=100.000000))
         StartVelocityRadialRange=(Min=150.000000,Max=200.692001)
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'fpsWeaponPack.pgProjImpactEmitter.pgImpactSpriteEmitter2'

     AutoDestroy=True
     bNoDelete=False
}
