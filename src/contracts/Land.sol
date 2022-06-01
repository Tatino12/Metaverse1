// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Land is ERC721 {
    uint256 public cost = 1 ether; //esto me va a costar un pedazo de tierra.
    uint256 public maxSupply = 5; //maximo que vamos a poder tener de tierras.
    uint256 public totalSupply = 0; //xq empezamos con 0 tierras.

    struct Building {
        string name; //nombre de nuestro edificio
        address owner; // direccion del dueño
        int256 posX; //posicion del edificio
        int256 posY;
        int256 posZ;
        uint256 sizeX; //tamaño del edificio
        uint256 sizeY;
        uint256 sizeZ;
    
    }
        Building[] public buildings; //[] para diferenciar variables de arrays

    constructor(string memory _name, string memory _symbol, uint256 _cost) ERC721 (_name, _symbol) {
        cost = _cost;
        buildings.push(
            Building("City Turumeloide", address(0x0), 0, 0, 0, 10, 10, 10)
        );
        buildings.push(
            Building("Stadium", address(0x0), 0, 10, 0, 10, 5, 3));
        buildings.push( 
            Building("University", address(0x0), 0, -10, 0, 10, 5, 3));
         buildings.push( 
            Building("Shopping Plaza 1", address(0x0), 10, 0, 0, 5, 25, 5));
        buildings.push( 
            Building("Shopping Plaza 2", address(0x0), -10, 0, 0, 5, 25, 5));

    }

    function mint(uint256 _id) public payable { //publica para que cualquiera pueda llamar a esta funcion y payable significa que podes mandar dinero a esta funcion (1 ether en este caso)
        uint256 supply = totalSupply;
        require(supply <= maxSupply);
        require(buildings[_id - 1].owner == address(0x0));//_id comienza en 1, por eso resto 1 ,xq el array siempre empieza en 0.Me aseguro que el edificio no tiene dueño por eso el owner == address(0x0)
        require(msg.value >= 1 ether);// aca me aseguro que se tenga 1 o mas ethers para la compra.

        //si pasa todas esas condiciones:
        buildings[_id - 1].owner = msg.sender; //aca obtengo la dire del nuevo dueño.
        totalSupply = totalSupply + 1; // aumento en 1 porque un edificio fue comprado.
        _safeMint(msg.sender, _id); // aca una funcion de erc721, me pasa la dire del dueño y el id de la tierra.
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );

        // Update Building ownership
        buildings[tokenId - 1].owner = to;

        _transfer(from, to, tokenId);
    }

     function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );

        // Update Building ownership
        buildings[tokenId - 1].owner = to;

        _safeTransfer(from, to, tokenId, _data);
    }

    function getBuildings() public view returns(Building[] memory) { // es view porque esta funcion solo lee data de la blockchain, no estamos haciendo ninguna transaccion.
        return buildings;
    }

    function getBuilding(uint256 _id) public view returns(Building memory) { //esta funcion es para un edificio en especifico
        return buildings[_id - 1];
    }
}