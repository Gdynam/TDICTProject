class TDSpawnTower extends Actor;

var StaticMeshComponent Mesh;

defaultproperties
{
        Begin Object Class=StaticMeshComponent Name=SpawnMesh
                BlockActors=false
                CollideActors=true
                BlockRigidBody=false
                StaticMesh=StaticMesh'GenericFoliage01.Ruins.Mesh.SM_UDK_Torch01'
                //Scale3D=(X=.20,Y=.20,Z=.20)
        End Object
        Mesh=SpawnMesh
        CollisionComponent=SpawnMesh
        Components.Add(SpawnMesh)
}