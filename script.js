const connectBtn =
document.getElementById("connectBtn");

const walletAddress =
document.getElementById("walletAddress");

async function connectWallet(){

  if(!window.ethereum){

    alert("Please install MetaMask Wallet");

    return;
  }

  try{

    const accounts =
    await ethereum.request({
      method:"eth_requestAccounts"
    });

    const userAddress =
    accounts[0];

    walletAddress.innerText =
      userAddress.substring(0,6) +
      "..." +
      userAddress.substring(userAddress.length - 4);

    connectBtn.innerText =
      "Connected";

  }catch(error){

    console.log(error);

    walletAddress.innerText =
      "Connection Failed";
  }

}

connectBtn.addEventListener(
  "click",
  connectWallet
);



// Active navbar highlight

const sections =
document.querySelectorAll("section");

const navLinks =
document.querySelectorAll(".nav-links a");

window.addEventListener("scroll", () => {

  let current = "";

  sections.forEach(section => {

    const sectionTop =
    section.offsetTop;

    if(pageYOffset >= sectionTop - 200){

      current =
      section.getAttribute("id");

    }

  });

  navLinks.forEach(link => {

    link.classList.remove("active");

    if(
      link.getAttribute("href")
      .includes(current)
    ){
      link.classList.add("active");
    }

  });

});
