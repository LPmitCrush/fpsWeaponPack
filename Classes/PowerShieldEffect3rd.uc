//=========================================================================
// PowerShieldEffect3rd
// ========================================================================
class PowerShieldEffect3rd extends AimedAttachment;

#exec OBJ LOAD FILE=XEffectMat.utx

var float Brightness, DesiredBrightness;
var int HitCount, OldHitCount;
var ShieldSparks Sparks;

replication
{
    unreliable if (Role == ROLE_Authority && !bHidden)
        HitCount; 
}

simulated function Destroyed()
{
    if (Sparks != None)
        Sparks.Destroy();
}

simulated function Flash(int Drain)
{
    if (Sparks == None)
    {
	    Sparks = Spawn(class'ShieldSparks');
    }

    if (Instigator != None && Instigator.IsFirstPerson())
    {
        Sparks.SetLocation(Location+Vect(0,0,20)+VRand()*12.0);
        Sparks.SetRotation(Rotation);
        Sparks.mStartParticles = 16;
    }
    else if ( EffectIsRelevant(Location,false) )
    {
        Sparks.SetLocation(Location+VRand()*8.0);
        Sparks.SetRotation(Rotation);
        Sparks.mStartParticles = 16;
    }
    Brightness = FMin(Brightness + Drain / 2, 250.0);
    //Skins[0] = Skins[1];
   // SetTimer(0.2, false);
}

function SetBrightness(int b, bool hit) // server only please
{
    DesiredBrightness = FMin(50+b*2, 250.0);
    if (hit)
    {
        HitCount++;
        Flash(50);
    }
}

simulated function PostNetReceive()
{
    if (OldHitCount == -1)
    {
        OldHitCount = HitCount;
    }
    else if (HitCount != OldHitCount)
    {
        Flash(50);
        OldHitCount = HitCount;
    }
}

defaultproperties
{
     Brightness=250.000000
     DesiredBrightness=250.000000
     OldHitCount=-1
     BaseOffset=(Z=5.000000)
     DownwardBias=16.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'fpsWepMesh.Shield.PlasmaSphere'
     bHidden=True
     bReplicateInstigator=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     DrawScale=0.800000
     DrawScale3D=(X=0.750000,Y=0.750000)
     AmbientGlow=250
     bUnlit=True
     bOwnerNoSee=True
     bNetNotify=True
}
