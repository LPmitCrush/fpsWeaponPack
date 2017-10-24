//=============================================================================
// VortexINVProj
// $Id: VortexINVProj.uc,v 1.2 2004/03/18 23:14:27 Melaneus Exp $
// Modified from Partent verison to avoid killing team mates in INV games
//=============================================================================
class VortexINVProj extends VortexProj;

//=============================================================================
// KillObject
//=============================================================================
// Kills or destroys the specified actor .

simulated function KillObject(Actor Other, float DistToCenter)
{
	if ( Pawn(Other) != None && Other.Role == ROLE_Authority && Pawn(Other).Health > 0
			&& !Pawn(Other).InGodMode() && !HasRespawnProtection(Pawn(Other)) && (Other.IsA('Monster')
            || Other == Instigator))
	{
		Other.TakeDamage(1000, Instigator, Other.Location, vect(0,0,0), MyDamageType);
		if ( Pawn(Other).Health > 0 )
			Pawn(Other).Died(InstigatorController, MyDamageType, Other.Location);
		PlaySound(SlurpSound[Rand(SlurpSound.Length)], SLOT_Misc, 255.0,, 6000.0);
	}
	else if ( Pickup(Other) != None )
    {
		Other.Destroy();	// was dropped anyways, so it can be destroyed
	}
	else if (!Other.IsA('xPawn'))  // Don't let players get hurt...only MonStars (Space Jam Ref) :)
    {
		Other.Touch(Self);
		DamageObject(Other, DistToCenter);
	}
}


//=============================================================================
// DamageObject
//=============================================================================
// Damages the specified actor based on its distance to the center of the
// vortex.

simulated function DamageObject(Actor Other, float DistToCenter)
{
	if ( Other == None || Other.IsA('Pawn') && Other.Role < ROLE_Authority )
		return;

	if (!Other.IsA('Pawn')  || Pawn(Other).Health > 0
    && !Pawn(Other).InGodMode() && !HasRespawnProtection(Pawn(Other)) && (Other.IsA('Monster')
    || Other == Instigator))
	{
		Other.TakeDamage(Damage * (1 - DistToCenter / DamageRadius), Instigator,
				Other.Location, vect(0,0,0), MyDamageType);
	}
}


//=============================================================================
// default properties
//=============================================================================

defaultproperties
{
}
