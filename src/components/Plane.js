const Plane = () => {
    return( //retornamos el modelo3D, para eso creamos geometry y material(cuando combinamos estos dos obtenemos mesh--> engranaje o malla)
        <mesh position={[0, 0, 0]}> 
            <planeBufferGeometry attach={"geometry"} args={[50, 50]} /> 
            <meshStandardMaterial color={"#404040"} />
        </mesh>
    );
}

export default Plane;