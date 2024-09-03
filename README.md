# SOLANA NFT Gallery APP[[Download Now]](https://drive.google.com/file/d/10uUThjbqOHFtsZ5K6aMXfFh0eamCwgJ_/view?usp=drive_link)

An app where you can see and download all the NFTs related to a wallet address. 

## Tech Stack

1) Solana
2) Flutter
3) bip39 package
4) GoRouter
5) Helius RPC provider

## Features Added Till Now 
1) Create a Wallet in the Solana and Sign in to the wallet
2) Can work both in **Mainnet and Devnet**
3) Check the Balance of the wallet
4) **See all the NFTs** associated with the user's wallet-only **images as well as 3D**
5) **Download** and Store the NFT in Gallary

# Progession
## 1st Iteration of NFT Gallery App [[Apk Here for 1st Iteration]](https://drive.google.com/file/d/1MetC-OaVQ5wx7wOrJLKYKJ5VEXPSjez5/view?usp=drive_link)
### Contains Features: 
1) Create a Wallet in the Solana and Sign in to the wallet
2) Can work both in **Mainnet and Devnet**
3) Check the Balance of the wallet
4) **See all the NFTs** associated with the user's wallet-only(**Image Only**)
5) Download and Store the NFT in Gallary

### Improvement and Features to be added
1) **Create a 3d viewer** for the NFT(Meshy API can used to Imageto3d conversion)
2) **Minting NFT from the app.**

### Screenshots (1st Iteration of NFT Gallery App)

<div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139005.png" alt="Screenshot 1" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139018.png" alt="Screenshot 2" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139032.png" alt="Screenshot 6" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139059.png" alt="Screenshot 3" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139083.png" alt="Screenshot 4" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139128.png" alt="Screenshot 5" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139136.png" alt="Screenshot 5" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139146.png" alt="Screenshot 5" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725139160.png" alt="Screenshot 5" style="width: 30%; margin-bottom: 10px;">
</div>

## 2nd Iteration of NFT Gallery App[[Apk Here for 2nd Iteration]](https://drive.google.com/file/d/1JZYgGxYwLf3LM-rdXZEpx03PlLgqFR2C/view?usp=drive_link)
### Features Added : 
1) User can put an IPFS link for their **3D NFT(.glb)** and can interact with it then using the app itself
   - First I was thinking about using the Meshy API to convert the Image to a 3D model and show it on the app.
   - I **successfully created the image for the 3D model** part with a satisfying model but could not load it into the app.
   - I **could not find a way to load the 3D downloaded model** into the App and pass it to the 3D Viewer page as I could not find a package that could solve this need.
   - I also tried to load the model directly through the link but **Meshy API is blocking the app from accessing the model** and could not find how to solve this problem.
2) **Improving the UI** of App Interface with intuitive **CTA(Call to Action)**.

### Improvement and Features to be added
1) **Remove the dependency from the user side** to put the IPFS link manually. Fetch and show the 3D models directly.
2) **Minting NFT from the app.**

### Screenshots (2nd Iteration of NFT Gallery App) 
<div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725316922.png" alt="Screenshot 1" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725316734.png" alt="Screenshot 2" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725316756.png" alt="Screenshot 6" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725316889.png" alt="Screenshot 3" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725316905.png" alt="Screenshot 4" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725316910.png" alt="Screenshot 5" style="width: 30%; margin-bottom: 10px;">
</div>

## 3rd Iteration of NFT Gallery App[[Apk Here for 3rd Iteration]](https://drive.google.com/file/d/10uUThjbqOHFtsZ5K6aMXfFh0eamCwgJ_/view?usp=drive_link)
### Features Added : 
1) Show a 3D model associated with the wallet directly **without needing user intervention.**
   - By modifying the NFT API response parsing the dart model and adjusting the UI a little bit I was able to show the 3D model of the wallet without the user needing to put the URL of the model manually.

### Improvement and Features to be added
1) **Minting NFT from the app.**
2) Open for any suggestions

### Screenshots (3rd Iteration of NFT Gallery App) 
<div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725402009.png" alt="Screenshot 1" style="width: 30%; margin-bottom: 10px;">
    <img src="https://github.com/Wannabe-King/NFTGalleryApp/blob/main/readmeData/Screenshot_1725402020.png" alt="Screenshot 2" style="width: 30%; margin-bottom: 10px;">
</div>

# Getting Started

To Setup this Project, first smile a little 😊 and let's get started.

1) Use the git clone command to **copy the repository** ```git clone https://github.com/Wannabe-King/NFTGalleryApp```
2) Install all the necessary **dependencies** for the project by using command ```flutter pub get```
3) Visit Helius at : [https://www.helius.dev/](https://www.helius.dev/) and **SignIn/Create an account**
4) Go to the EndPoint Section and get the **RPC and WSS URL for Mainnet and Devnet**
5) Create a **.env file** at the root of the project and set the following variables
   ```
    HELIUS_RPC_URL=
    HELIUS_RPC_WSS=
    HELIUS_RPC_URL_DEVNET=
    HELIUS_RPC_WSS_DEVNET=
   ```
6) You're all set. Use ```flutter run``` command to launch the app.



## Give a Star⭐ for this project to improve its reach.
