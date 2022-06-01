
import './App.css';
import Web3 from 'web3';
import { useState, useEffect} from 'react';
import Land from './abis/Land.json';


function App() {

  const [web3, setWeb3] = useState(null);
  const [account, setAccount] = useState(null);
  const [landContract, setLandContract] = useState(null);
  const [cost, setCost] = useState(0);
  const [buildings, setBuildings] = useState(null);

  useEffect( () => {
    loadBlockchainData()
  },[account])

  const loadBlockchainData = async () => {
      if (typeof window.ethereum !== 'undefined') { // aca chequeamos si nuestro browser tiene metamask instalado
        const web3 = new Web3(window.ethereum)
        setWeb3(web3)

        const accounts = await web3.eth.getAccounts()

        if(account.length > 0) { // si el usuario tiene 1,o mas cuentas
          setAccount(accounts[0]) //establezco la primera cuenta
        }

        const networkId = await web3.eth.net.getId()

        const land = new web3.eth.Contract(Land.abi, Land.networks[networksId].address)
        setLandContract(land)

        const cost = await land.methods.cost().call()
        setCost(web3.utils.fromWei(cost.toString(), 'ether'))

        const buildings = await land.methods.getBuildings().call()
        setBuildings(buildings)
        
        //even listener
        window.ethereum.on('accountsChanged', function (accounts) { // cada vez que cambiamos de cuenta en metamask
          setAccount(accounts[0]) //establecemos la primera cuenta nuevamente, es recomendado por metamask 
        })

        window.ethereum.on('chainChanged', (chainId) => { //cuando cambies de blockchain en tu metamask
          window.location.reload(); //la pagina volvera a cargarse
        })
      }
  }

  const web3Handler = async () => {
    if (web3) {
      const accounts = await window.ethereum.request({ method: 'eth_requestAccounts'})
      setAccount(accounts[0])
    }
  }


  return (
    <div >
      virtual land 
    </div>
  );
}

export default App;
