//=============================================================================
// VortexLimitMessage
// $Id: VortexLimitMessage.uc,v 1.3 2004/05/16 22:47:25 jimmarlowe Exp $
//
// Switch:
//  0   player tried to fire vortex while at vortex limit
//  1+  warning about the vortex limit to all players who have a vortex with
//      ammo in their inventory
//
// RelatedPRI_1:
//  0   not used
//  1+  PRI of the new vortex' instigator
//
// RelatedPRI_2:
//  not used
//
// OptionalObject:
//  not used
//=============================================================================
class VortexLimitMessage extends LocalMessage;

var localized string LimitOneText, LimitMoreText;
var localized string LimitActiveText;

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	local string s;

	if ( Switch == 0 ) {
		return Default.LimitActiveText;
	}
	else if ( Switch == 1 ) {
		return Default.LimitOneText;
	}
	else {
		s = Default.LimitMoreText;
		StaticReplaceText(s, "%n", string(Switch));
		return s;
	}
	return "";
}

static simulated function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if ( Switch == 0 || PlayerHasVortex(P) && (P.PlayerReplicationInfo != RelatedPRI_1 || Switch > 1) )
		Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
	else
		return;
}

static simulated function bool PlayerHasVortex(PlayerController P)
{
	local Inventory thisItem;

	if ( P.Pawn == None )
		return false;

	for (thisItem = P.Pawn.Inventory; thisItem != None; thisItem = thisItem.Inventory)
		if ( Vortex(thisItem) != None )
			return Vortex(thisItem).HasAmmo();

	return false;
}

// The very same function as Actor.ReplaceText.
// The only difference is the 'static' function modifier.
static final function StaticReplaceText(out string Text, string Replace, string With)
{
	local int i;
	local string Input;

	Input = Text;
	Text = "";
	i = InStr(Input, Replace);
	while(i != -1)
	{
		Text = Text $ Left(Input, i) $ With;
		Input = Mid(Input, i + Len(Replace));
		i = InStr(Input, Replace);
	}
	Text = Text $ Input;
}

defaultproperties
{
     LimitOneText="Found active gravity vortex, vortex launcher disabled."
     LimitMoreText="Limit of %n active gravity vortices reached."
     LimitActiveText="Vortex launcher is temporarily disabled."
     bIsUnique=True
     bIsConsoleMessage=False
     bFadeMessage=True
     DrawColor=(B=0,G=200,R=200)
     StackMode=SM_Down
     PosY=0.300000
     FontSize=1
}
