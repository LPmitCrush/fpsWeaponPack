class MP5Tracer extends Emitter;

#exec OBJ LOAD FILE=..\Textures\\AW-2004Particles.utx

simulated function SpawnParticle( int Amount )
{
	local PlayerController PC;
	local vector Dir, LineDir, LinePos, RealLocation;
	
	Super.SpawnParticle(Amount);
	
    if ( (Instigator == None) || Instigator.IsFirstPerson() )
		return;
   
	// see if local player controller near bullet, but missed
	PC = Level.GetLocalPlayerController();
	if ( (PC != None) && (PC.Pawn != None) )
	{
		Dir.X = Emitters[0].StartVelocityRange.X.Min;
		Dir.Y = Emitters[0].StartVelocityRange.Y.Min;
		Dir.Z = Emitters[0].StartVelocityRange.Z.Min;
		Dir = Normal(Dir);
		LinePos = (Location + (Dir dot (PC.Pawn.Location - Location)) * Dir);
		LineDir = PC.Pawn.Location - LinePos;
		if ( VSize(LineDir) < 150 )
		{
			RealLocation = Location;
			SetLocation(LinePos);
			if ( FRand() < 0.5 )
				PlaySound(sound'Impact3Snd',,,,80);
			else
				PlaySound(sound'Impact7Snd',,,,80);
			SetLocation(RealLocation);
		}
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseDirectionAs=PTDU_Right
         UseColorScale=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseAbsoluteTimeForSizeScale=True
         UseRegularSizeScale=False
         ScaleSizeXByVelocity=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.200000)
         ColorScale(0)=(Color=(B=50,G=50,R=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=50,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=50,G=255,R=50))
         ColorScale(3)=(RelativeTime=0.700000,Color=(B=255,G=50,R=50))
         ColorScale(4)=(RelativeTime=1.000000)
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         MaxParticles=100
         SizeScale(1)=(RelativeTime=0.030000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=7.000000,Max=7.000000))
         ScaleSizeByVelocityMultiplier=(X=0.002000)
         Texture=Texture'AW-2004Particles.Weapons.TracerShot'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=10000.000000,Max=10000.000000))
     End Object
     Emitters(0)=SpriteEmitter'fpsWeaponPack.MP5Tracer.SpriteEmitter13'

     bNoDelete=False
     bHardAttach=True
}
