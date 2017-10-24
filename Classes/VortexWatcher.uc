//=============================================================================
// VortexWatcher
// $Id: VortexWatcher.uc,v 1.2 2004/03/18 23:14:27 Melaneus Exp $
// Prvents 2 or more active vortex's at the same time if so needed
//=============================================================================
class VortexWatcher extends ReplicationInfo config
                    config(GravVortex);

// config vars
var() globalconfig int VortexLimit;

//var protected int VortexLimit;
var protected bool bLimitReached, bPrevLimitReached;
var protected int nVorticesActive;

var float VortexEndTime;

replication
{
	reliable if ( Role == ROLE_Authority )
		bLimitReached;
}

function PostBeginPlay()
{
	VortexLimit = class'VortexWatcher'.default.VortexLimit;
}

function AddVortex(PlayerReplicationInfo VortexOwnerPRI)
{
	nVorticesActive++;
	if ( !bLimitReached )
    {
		bLimitReached = VortexLimit != 0 && VortexLimit > 0 && nVorticesActive >= VortexLimit;
		if ( bLimitReached )
			BroadcastLocalizedMessage(class'VortexLimitMessage', VortexLimit, VortexOwnerPRI);
	}
	if ( bLimitReached )
		VortexEndTime = Level.TimeSeconds + class'VortexProj'.static.GetVortexDuration();
}

function RemoveVortex()
{
	nVorticesActive--;
	bLimitReached = VortexLimit > 0 && nVorticesActive >= VortexLimit;
}

simulated function bool VortexLimitReached()
{
	return bLimitReached;
}

simulated function PostNetReceive()
{
	if ( bLimitReached && !bPrevLimitReached )
		VortexEndTime = Level.TimeSeconds + class'VortexProj'.static.GetVortexDuration();

	bPrevLimitReached = bLimitReached;
}

defaultproperties
{
     bNetNotify=True
}
