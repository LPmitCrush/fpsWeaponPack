class VortexAttachment extends xWeaponAttachment;

var xEmitter MuzFlash3rd;

simulated function Destroyed()
{
    if (MuzFlash3rd != None)
        MuzFlash3rd.Destroy();
    Super.Destroyed();
}

defaultproperties
{
     bHeavy=True
     Mesh=SkeletalMesh'fpsWepAnim.Vortex.chaos_vortexlauncher_3rd'
}
