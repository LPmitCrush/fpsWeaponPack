class MP5GrenadeAmmo extends GrenadeAmmo config(fpsWeaponPack);

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
     clientMaxAmmo=10
     MaxAmmo=10
     PickupAmmo=4
     PickupClass=Class'fpsWeaponPack.MP5AmmoPickup'
     ItemName="ZenMP5 Grenade Ammo"
}
