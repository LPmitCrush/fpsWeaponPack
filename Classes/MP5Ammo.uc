class MP5Ammo extends Ammunition config(fpsWeaponPack);

var config int clientMaxAmmo;

replication
{
reliable if (role == role_Authority)
	clientMaxAmmo;
}

simulated function PostNetBeginPlay()
{
		MaxAmmo = clientMaxAmmo;

	super.PostNetBeginPlay();
}

defaultproperties
{
     clientMaxAmmo=180
     MaxAmmo=180
     InitialAmount=90
     PickupAmmo=45
     PickupClass=Class'fpsWeaponPack.MP5AmmoPickup'
     IconMaterial=Texture'HUDContent.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="ZenMP5 or Minigun Ammo"
}
