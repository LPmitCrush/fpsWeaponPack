Class pgProjEmitter extends Emitter;

// Fueg, when you have two versions of an emitter (one for primary one for secondary) please add the colour changes here so that there is only one copy of the emitter
// I'm assuing the only difference between primary/secondary emitters will be the colour but if you make other changes, they can be added here too
simulated function SetColour(byte FireMode)
{
	// Primary
	if (FireMode == 0)
	{
		if (Emitters[0] != none)
		{
			// Red Green Blue is the order of the MakeColor function, the emitter properties often show it backwards
			Emitters[0].ColorScale[0].Color = Class'Canvas'.static.MakeColor(147, 255, 255);
			Emitters[0].ColorScale[1].Color = Class'Canvas'.static.MakeColor(147, 198, 255);
		}

		if (Emitters[1] != none)
		{
			Emitters[1].ColorScale[0].Color = Class'Canvas'.static.MakeColor(83, 255, 255);
			Emitters[1].ColorScale[1].Color = Class'Canvas'.static.MakeColor(0, 43, 213);
		}
	}
	// Secondary
	else if (FireMode == 1)
	{
		if (Emitters[0] != none)
		{
			// Red Green Blue is the order of the MakeColor function, the emitter properties often show it backwards
			Emitters[0].ColorScale[0].Color = Class'Canvas'.static.MakeColor(255, 255, 147);
			Emitters[0].ColorScale[1].Color = Class'Canvas'.static.MakeColor(255, 198, 147);
		}

		if (Emitters[1] != none)
		{
			Emitters[1].ColorScale[0].Color = Class'Canvas'.static.MakeColor(255, 255, 83);
			Emitters[1].ColorScale[1].Color = Class'Canvas'.static.MakeColor(213, 43, 0);
		}
	}
	// Discharge projectile
	else if (FireMode == 2)
	{
		if (Emitters[0] != none)
		{
			// Red Green Blue is the order of the MakeColor function, the emitter properties often show it backwards
			Emitters[0].ColorScale[0].Color = Class'Canvas'.static.MakeColor(50, 50, 50);
			Emitters[0].ColorScale[1].Color = Class'Canvas'.static.MakeColor(50, 50, 50);
		}

		if (Emitters[1] != none)
		{
			Emitters[1].ColorScale[0].Color = Class'Canvas'.static.MakeColor(43, 43, 43);
			Emitters[1].ColorScale[1].Color = Class'Canvas'.static.MakeColor(43, 43, 43);
		}
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=pgSpriteEmitter
         UseColorScale=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=25.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'fpsWeaponPack.pgProjEmitter.pgSpriteEmitter'

     Begin Object Class=SpriteEmitter Name=pgSpriteEmitter2
         UseColorScale=True
         UseRevolution=True
         UseRevolutionScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseVelocityScale=True
         ColorScale(1)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=0.001000,Max=0.001000)
         RevolutionsPerSecondRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         RevolutionScale(0)=(RelativeRevolution=(X=1.000000,Y=1.000000,Z=1.000000))
         RevolutionScale(1)=(RelativeTime=0.500000,RelativeRevolution=(X=1.000000,Y=1.000000,Z=1.000000))
         RevolutionScale(2)=(RelativeTime=1.000000)
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=20.000000))
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=0.200000,Max=0.500000)
         StartVelocityRadialRange=(Min=1.000000,Max=100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'fpsWeaponPack.pgProjEmitter.pgSpriteEmitter2'

     bNoDelete=False
     Physics=PHYS_Trailer
}
