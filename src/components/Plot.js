const Plot = ({ position, size, landId, landInfo, setLandName, setLandOwner, setHasOwner, setLandId}) => {
    const clickHandler = () => {
        setLandName(landInfo.name)
        setLandId(landId)

        if (landInfo.owner === '0x0000000000000000000000000000000000000000') {
            setLandOwner('No Owner')
            setHasOwner(false)
        } else {
            setLandOwner(landInfo.owner)
            setHasOwner(true)
        }
    }

    return(
        <mesh position={position} onClick={clickHandler}/>
    )
}