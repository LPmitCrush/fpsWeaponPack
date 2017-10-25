class Flamer extends flakcannon; 

simulated function SuperMaxOutAmmo()
{}

defaultproperties
{
     FireModeClass(0)=Class'FlamerFire'
     FireModeClass(1)=Class'FlamerAltFire'
     PickupClass=Class'FlamerPickup'
     ItemName="Flamer"
}
