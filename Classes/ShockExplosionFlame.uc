class ShockExplosionFlame extends Emitter;

#exec OBJ LOAD FILE=EpicParticles.utx
#exec OBJ LOAD FILE="fpsWepMesh.usx"
#exec OBJ LOAD FILE="fpsWepTex.utx"

/*
    Begin Object Class=MeshEmitter Name=MeshEmitter1
        StaticMesh=StaticMesh'fpsWepMesh.ShockExplosionBall'
        RenderTwoSided=True
        UseParticleColor=True
        UseColorScale=True
	    SpinParticles=True
        //ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=1.000000,Max=1.000000))
        ColorScale(0)=(RelativeTime=0.00000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=0.300000,Color=(B=0,G=165,R=255,A=255))
        ColorScale(2)=(RelativeTime=0.900000,Color=(B=0,G=69,R=255,A=255))
        ColorScale(3)=(RelativeTime=1.000000)
        FadeOutStartTime=30.000000
        FadeOut=True
        FadeInEndTime=1.500000
        FadeIn=True
        MaxParticles=2
        RespawnDeadParticles=False
        SpinsPerSecondRange=(X=(Min=-0.5,Max=0.500000),Y=(Min=-0.5,Max=0.500000),Z=(Min=-0.5,Max=0.500000))
        UseSizeScale=True
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=0.00000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=200.000000)
        StartSizeRange=(X=(Min=0.800000,Max=0.90000),Y=(Min=0.800000,Max=0.90000),Z=(Min=0.800000,Max=0.90000))
        UniformSize=True
        InitialParticlesPerSecond=50000.000000
        AutomaticInitialSpawning=False
        DrawStyle=PTDS_Translucent
        //Texture=Texture'EpicParticles.Smoke.FlameGradient'
        LifetimeRange=(Min=30.750000,Max=30.750000)
        SecondsBeforeInactive=0
        Name="MeshEmitter1"
    End Object
    Emitters(5)=MeshEmitter'MeshEmitter1'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        UseColorScale=True
        ColorScale(0)=(Color=(B=111,G=172,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=55,G=100,R=234))
        FadeOutStartTime=0.900000
        FadeOut=True
        FadeInEndTime=0.100000
        FadeIn=True
        MaxParticles=2
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.700000,RelativeSize=15.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        UniformSize=True
        InitialParticlesPerSecond=50000.000000
        AutomaticInitialSpawning=False
        Texture=Texture'EpicParticles.Flares.BurnFlare1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        SecondsBeforeInactive=0
        Name="SpriteEmitter5"
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter5'
*/

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'fpsWepMesh.ShockExplosionBall'
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(G=165,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.900000,Color=(G=69,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         FadeOutStartTime=6.000000
         FadeInEndTime=1.500000
         MaxParticles=3
         SpinsPerSecondRange=(X=(Min=-0.500000,Max=0.500000),Y=(Min=-0.500000,Max=0.500000),Z=(Min=-0.500000,Max=0.500000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=200.000000)
         StartSizeRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.800000,Max=0.900000))
         InitialParticlesPerSecond=5000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=7.750000,Max=7.750000)
     End Object
     Emitters(0)=MeshEmitter'fpsWeaponPack.ShockExplosionFlame.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=69,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.900000,Color=(G=69,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         FadeOutStartTime=6.000000
         FadeInEndTime=0.100000
         SpinsPerSecondRange=(X=(Min=-0.500000,Max=0.500000),Y=(Min=-0.500000,Max=0.500000),Z=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=200.000000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'EpicParticles.Flares.BurnFlare1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=7.000000,Max=7.000000)
     End Object
     Emitters(7)=SpriteEmitter'fpsWeaponPack.ShockExplosionFlame.SpriteEmitter5'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     Style=STY_Masked
     bDirectional=True
}
